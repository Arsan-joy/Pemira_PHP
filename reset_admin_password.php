<?php
require_once '../config/database.php';
require_once '../includes/session.php';
require_once '../includes/functions.php';

if (!is_admin_logged_in()) { header('Location: index.php'); exit; }

function h($s){ return htmlspecialchars((string)$s, ENT_QUOTES, 'UTF-8'); }

$log = [];
$summary = ['inserted'=>0,'updated'=>0,'skipped'=>0,'errors'=>0];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // basic file checks
    if (empty($_FILES['csv']) || $_FILES['csv']['error'] !== UPLOAD_ERR_OK) {
        $log[] = 'Upload CSV gagal atau tidak ada file.';
    } else {
        $tmp = $_FILES['csv']['tmp_name'];
        // optional default values
        $default_prodi = clean_input($_POST['default_prodi'] ?? 'Teknik Pertambangan');
        $update_password = isset($_POST['update_password_if_exists']);
        $use_nim_as_username = isset($_POST['use_nim_as_username']);

        // size limit (5MB)
        if ($_FILES['csv']['size'] > 5 * 1024 * 1024) {
            $log[] = 'Ukuran file CSV terlalu besar (maks 5MB).';
        } else {
            try {
                $fh = fopen($tmp, 'r');
                if (!$fh) throw new RuntimeException('Gagal membuka file CSV.');

                $delimiter = ';';

                // Many exported files contain some lines before the real header.
                // Strategy: skip up to 10 lines until we detect header containing NIM and Nama.
                $header = null;
                $maxSeek = 10;
                for ($i = 0; $i < $maxSeek && ($line = fgetcsv($fh, 0, $delimiter)) !== false; $i++) {
                    $cells = array_map('trim', $line);
                    $joined = strtolower(implode('|', $cells));
                    if (strpos($joined, 'nim') !== false && (strpos($joined, 'nama') !== false || strpos($joined, 'name') !== false)) {
                        $header = $cells;
                        break;
                    }
                }

                if ($header === null) {
                    // try one more time: maybe the file has exactly header at line 3 like example
                    rewind($fh);
                    // skip 2 lines (common in provided file) and read header
                    fgetcsv($fh, 0, $delimiter);
                    fgetcsv($fh, 0, $delimiter);
                    $header = fgetcsv($fh, 0, $delimiter);
                }

                if (!$header || !is_array($header)) {
                    throw new RuntimeException('Header CSV tidak ditemukan atau tidak valid.');
                }

                // normalize header and find indexes
                $map = array_map(function($s){ return strtolower(trim((string)$s)); }, $header);
                $idxNim  = array_search('nim', $map, true);
                $idxNama = array_search('nama', $map, true);
                $idxPass = array_search('password', $map, true);
                $idxUser = array_search('username', $map, true);

                if ($idxNim === false || $idxNama === false) {
                    throw new RuntimeException('Header CSV harus mengandung kolom: NIM dan Nama (Password/Username opsional).');
                }

                // If password/username columns missing, we'll fallback to sensible defaults.
                $hasPasswordColumn = $idxPass !== false;
                $hasUsernameColumn = $idxUser !== false;

                // Prepare statements once
                $stmtFindByNim = pdo()->prepare("SELECT id, username FROM voters WHERE nim = :nim LIMIT 1");
                $stmtFindByUsername = pdo()->prepare("SELECT id, nim FROM voters WHERE username = :username LIMIT 1");
                $stmtInsert = pdo()->prepare("INSERT INTO voters (username, password, nama_lengkap, nim, prodi) VALUES (:username, :password, :nama, :nim, :prodi)");
                $stmtUpdatePassword = pdo()->prepare("UPDATE voters SET password = :password, has_voted = 0, voted_at = NULL WHERE id = :id");
                $stmtUpdateData = pdo()->prepare("UPDATE voters SET username = :username, nama_lengkap = :nama, prodi = :prodi WHERE id = :id");

                pdo()->beginTransaction();

                // iterate remaining rows
                while (($row = fgetcsv($fh, 0, $delimiter)) !== false) {
                    // skip empty rows
                    if (!$row || count($row) < 2) continue;

                    // normalize row length and trim
                    $row = array_map(function($c){ return trim((string)$c); }, $row);

                    $nim = $row[$idxNim] ?? '';
                    $nama = $row[$idxNama] ?? '';
                    $plain = $hasPasswordColumn ? ($row[$idxPass] ?? '') : '';
                    $username = $hasUsernameColumn ? trim((string)($row[$idxUser] ?? '')) : '';

                    if ($nim === '' || $nama === '') {
                        $summary['errors']++;
                        $log[] = "Dilewati: data kurang lengkap (NIM='$nim', Nama='$nama').";
                        continue;
                    }

                    // If username empty and user chose to use NIM as username, or username column absent -> use NIM
                    if ($username === '') {
                        if ($use_nim_as_username) {
                            $username = $nim;
                        } elseif ($hasUsernameColumn === false) {
                            // fallback: use nim as username
                            $username = $nim;
                        } else {
                            // keep empty to let unique checks handle it
                            $username = $nim;
                        }
                    }

                    // Hash password: if missing fallback to NIM (not ideal but common)
                    if ($plain === '') $plain = $nim;
                    $hashed = password_hash($plain, PASSWORD_DEFAULT);

                    // Find existing by NIM first
                    $stmtFindByNim->execute([':nim' => $nim]);
                    $foundByNim = $stmtFindByNim->fetch();

                    if ($foundByNim) {
                        $voterId = (int)$foundByNim['id'];

                        // If username collided with another record (different NIM), try to detect
                        if ($foundByNim['username'] !== $username) {
                            // Ensure new username not used by someone else
                            $stmtFindByUsername->execute([':username' => $username]);
                            $foundByUser = $stmtFindByUsername->fetch();
                            if ($foundByUser && (int)$foundByUser['nim'] !== (int)$nim) {
                                // username conflict — skip updating username but update name/password optionally
                                if ($update_password) {
                                    $stmtUpdatePassword->execute([':password' => $hashed, ':id' => $voterId]);
                                    $summary['updated']++;
                                    $log[] = "Password diupdate untuk NIM=$nim (username konfliks, biarkan username lama).";
                                } else {
                                    $summary['skipped']++;
                                    $log[] = "Dilewati: NIM=$nim sudah ada dan username target dipakai oleh NIM lain.";
                                }
                            } else {
                                // no username conflict — update username and other fields
                                if ($update_password) {
                                    $stmtUpdatePassword->execute([':password' => $hashed, ':id' => $voterId]);
                                }
                                $stmtUpdateData->execute([':username' => $username, ':nama' => $nama, ':prodi' => $default_prodi, ':id' => $voterId]);
                                $summary['updated']++;
                                $log[] = "Diupdate: NIM=$nim, Username set to $username.";
                            }
                        } else {
                            // same username as stored
                            if ($update_password) {
                                $stmtUpdatePassword->execute([':password' => $hashed, ':id' => $voterId]);
                                $summary['updated']++;
                                $log[] = "Password diupdate untuk NIM=$nim (username sama).";
                            } else {
                                // update name/prodi only
                                $stmtUpdateData->execute([':username' => $username, ':nama' => $nama, ':prodi' => $default_prodi, ':id' => $voterId]);
                                $summary['updated']++;
                                $log[] = "Data diupdate untuk NIM=$nim (tanpa password).";
                            }
                        }
                    } else {
                        // Not found by NIM; check username uniqueness
                        $stmtFindByUsername->execute([':username' => $username]);
                        $foundByUser = $stmtFindByUsername->fetch();

                        if ($foundByUser) {
                            // username already exists for different nim -> skip to avoid collision
                            $summary['skipped']++;
                            $log[] = "Dilewati: Username '$username' sudah terpakai (NIM target tidak sama).";
                            continue;
                        }

                        // Insert new voter
                        $stmtInsert->execute([
                            ':username' => $username,
                            ':password' => $hashed,
                            ':nama'     => $nama,
                            ':nim'      => $nim,
                            ':prodi'    => $default_prodi
                        ]);
                        $summary['inserted']++;
                        $log[] = "Ditambahkan: NIM=$nim Username=$username";
                    }
                } // end while

                pdo()->commit();
                fclose($fh);

                $log[] = 'Import CSV selesai.';
            } catch (Throwable $e) {
                if (pdo()->inTransaction()) pdo()->rollBack();
                $summary['errors']++;
                $log[] = 'Error: ' . $e->getMessage();
            }
        }
    }
}
?>
<!doctype html>
<html lang="id">
<head>
  <meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Upload Voters CSV</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body{background:#f1f5f9;font-family:Inter,Segoe UI,Helvetica,Arial}
    .container{max-width:980px;margin:32px auto}
    .card{background:#fff;border-radius:12px;padding:20px;box-shadow:0 6px 24px rgba(2,6,23,.08)}
    .log{background:#0b1023;color:#d1d5db;border-radius:8px;padding:10px;font-family:ui-monospace, SFMono-Regular, Menlo, monospace;max-height:260px;overflow:auto}
  </style>
</head>
<body>
<div class="container">
  <div class="card">
    <h4>Import Voters dari CSV</h4>
    <p class="text-muted">Gunakan file CSV dengan delimiter semicolon (;). Contoh header: No.;NIM;Nama;Password;Username</p>

    <form method="post" enctype="multipart/form-data" class="row g-3">
      <div class="col-md-6">
        <label class="form-label">File CSV</label>
        <input type="file" name="csv" accept=".csv" class="form-control" required>
      </div>

      <div class="col-md-6">
        <label class="form-label">Default Program Studi (prodi)</label>
        <input type="text" name="default_prodi" class="form-control" value="Teknik Pertambangan">
      </div>

      <div class="col-12">
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="update_password_if_exists" id="upw">
          <label class="form-check-label" for="upw">Update password jika voter sudah ada</label>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="use_nim_as_username" id="use_nim" checked>
          <label class="form-check-label" for="use_nim">Gunakan NIM sebagai username ketika kolom Username kosong</label>
        </div>
      </div>

      <div class="col-12">
        <button class="btn btn-primary" type="submit"><i class="fa-solid fa-upload"></i> Upload & Import</button>
        <a href="voters.php" class="btn btn-secondary">Kembali ke Kelola Pemilih</a>
      </div>
    </form>
  </div>

  <?php if ($_SERVER['REQUEST_METHOD'] === 'POST'): ?>
    <div class="card mt-3">
      <h5>Ringkasan</h5>
      <ul>
        <li>Ditambahkan: <?= (int)$summary['inserted'] ?></li>
        <li>Diperbarui: <?= (int)$summary['updated'] ?></li>
        <li>Dilewati: <?= (int)$summary['skipped'] ?></li>
        <li>Errors: <?= (int)$summary['errors'] ?></li>
      </ul>
    </div>

    <div class="card mt-3">
      <h5>Log</h5>
      <div class="log">
        <?php foreach ($log as $line): ?>
          <?= h($line) ?><br>
        <?php endforeach; ?>
      </div>
    </div>
  <?php endif; ?>
</div>
</body>
</html>