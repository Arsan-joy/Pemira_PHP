<?php
require_once '../config/database.php';
require_once '../includes/session.php';
require_once '../includes/functions.php';

if (!is_admin_logged_in()) { header('Location: index.php'); exit; }

$message = '';
$error   = '';

// Tambah kandidat
if (isset($_POST['add_candidate'])) {
    $nama         = clean_input($_POST['nama'] ?? '');
    $posisi       = clean_input($_POST['posisi'] ?? '');
    $visi_misi    = clean_input($_POST['visi_misi'] ?? '');
    $grand_design = clean_input($_POST['grand_design'] ?? '');
    $nomor_urut   = (int)($_POST['nomor_urut'] ?? 0);

    if ($nama === '' || ($posisi !== 'kahim' && $posisi !== 'senat') || $nomor_urut <= 0) {
        $error = 'Data kandidat tidak valid.';
    } else {
        $foto = 'default.jpg';

        // Upload foto - aman: pastikan direktori ada & cek is_uploaded_file
        if (!empty($_FILES['foto']['name']) && $_FILES['foto']['error'] === UPLOAD_ERR_OK) {
            $allowed = ['jpg','jpeg','png','gif'];
            $ext = strtolower(pathinfo($_FILES['foto']['name'], PATHINFO_EXTENSION));
            if (in_array($ext, $allowed, true)) {
                // direktori upload absolut
                $uploadDir = __DIR__ . '/../assets/images/candidates';
                if (!is_dir($uploadDir)) {
                    // coba buat direktori secara rekursif
                    if (!mkdir($uploadDir, 0755, true) && !is_dir($uploadDir)) {
                        error_log('Gagal membuat direktori upload: ' . $uploadDir);
                    }
                }

                // generate nama file aman
                try {
                    $rand = bin2hex(random_bytes(3));
                } catch (Throwable $e) {
                    $rand = substr(md5(uniqid('', true)), 0, 6);
                }
                $new = 'candidate_' . time() . '_' . $rand . '.' . $ext;
                $target = $uploadDir . DIRECTORY_SEPARATOR . $new;

                if (is_uploaded_file($_FILES['foto']['tmp_name'])) {
                    if (move_uploaded_file($_FILES['foto']['tmp_name'], $target)) {
                        $foto = $new;
                    } else {
                        error_log('Gagal memindahkan file upload ke: ' . $target . ' ; $_FILES: ' . print_r($_FILES['foto'], true));
                    }
                } else {
                    error_log('File upload tidak dikenali sebagai uploaded file oleh PHP: ' . ($_FILES['foto']['tmp_name'] ?? ''));
                }
            } else {
                error_log('Ekstensi file tidak diizinkan: ' . $ext);
            }
        }

        $sql = "INSERT INTO candidates (nama, foto, posisi, visi_misi, grand_design, nomor_urut)
                VALUES (:nama, :foto, :posisi, :visi, :grand, :urut)";
        $ok = pdo()->prepare($sql)->execute([
            ':nama'  => $nama,
            ':foto'  => $foto,
            ':posisi'=> $posisi,
            ':visi'  => $visi_misi,
            ':grand' => $grand_design,
            ':urut'  => $nomor_urut,
        ]);

        if ($ok) {
            $message = 'Kandidat berhasil ditambahkan!';
            log_activity('admin', (int)$_SESSION['admin_id'], $_SESSION['admin_username'], "Menambah kandidat: $nama");
        } else {
            $error = 'Gagal menambahkan kandidat.';
        }
    }
}

// Edit kandidat
if (isset($_POST['edit_candidate'])) {
    $id           = (int)($_POST['id'] ?? 0);
    $nama         = clean_input($_POST['nama'] ?? '');
    $posisi       = clean_input($_POST['posisi'] ?? '');
    $visi_misi    = clean_input($_POST['visi_misi'] ?? '');
    $grand_design = clean_input($_POST['grand_design'] ?? '');
    $nomor_urut   = (int)($_POST['nomor_urut'] ?? 0);

    $st = pdo()->prepare("SELECT foto FROM candidates WHERE id = :id");
    $st->execute([':id' => $id]);
    $row = $st->fetch();
    if (!$row) {
        $error = 'Kandidat tidak ditemukan.';
    } else {
        $foto = $row['foto'];

        // Upload foto (edit) - gunakan pengecekan direktori & is_uploaded_file
        if (!empty($_FILES['foto']['name']) && $_FILES['foto']['error'] === UPLOAD_ERR_OK) {
            $allowed = ['jpg','jpeg','png','gif'];
            $ext = strtolower(pathinfo($_FILES['foto']['name'], PATHINFO_EXTENSION));
            if (in_array($ext, $allowed, true)) {
                $uploadDir = __DIR__ . '/../assets/images/candidates';
                if (!is_dir($uploadDir)) {
                    if (!mkdir($uploadDir, 0755, true) && !is_dir($uploadDir)) {
                        error_log('Gagal membuat direktori upload: ' . $uploadDir);
                    }
                }

                try {
                    $rand = bin2hex(random_bytes(3));
                } catch (Throwable $e) {
                    $rand = substr(md5(uniqid('', true)), 0, 6);
                }
                $new = 'candidate_' . time() . '_' . $rand . '.' . $ext;
                $target = $uploadDir . DIRECTORY_SEPARATOR . $new;

                if (is_uploaded_file($_FILES['foto']['tmp_name'])) {
                    if (move_uploaded_file($_FILES['foto']['tmp_name'], $target)) {
                        // hapus file lama jika bukan default
                        if ($foto !== 'default.jpg') {
                            $old = $uploadDir . DIRECTORY_SEPARATOR . $foto;
                            if (is_file($old)) @unlink($old);
                        }
                        $foto = $new;
                    } else {
                        error_log('Gagal memindahkan file upload ke: ' . $target . ' ; $_FILES: ' . print_r($_FILES['foto'], true));
                    }
                } else {
                    error_log('File upload tidak dikenali sebagai uploaded file oleh PHP: ' . ($_FILES['foto']['tmp_name'] ?? ''));
                }
            } else {
                error_log('Ekstensi file tidak diizinkan: ' . $ext);
            }
        }

        $sql = "UPDATE candidates SET nama=:nama, foto=:foto, posisi=:posisi, visi_misi=:visi, grand_design=:grand, nomor_urut=:urut
                WHERE id=:id";
        $ok = pdo()->prepare($sql)->execute([
            ':nama'=>$nama, ':foto'=>$foto, ':posisi'=>$posisi, ':visi'=>$visi_misi,
            ':grand'=>$grand_design, ':urut'=>$nomor_urut, ':id'=>$id
        ]);

        if ($ok) {
            $message = 'Kandidat berhasil diupdate!';
            log_activity('admin', (int)$_SESSION['admin_id'], $_SESSION['admin_username'], "Mengupdate kandidat: $nama");
        } else {
            $error = 'Gagal mengupdate kandidat.';
        }
    }
}

// Hapus kandidat
if (isset($_GET['delete'])) {
    $id = (int)$_GET['delete'];

    $st = pdo()->prepare("SELECT nama, foto FROM candidates WHERE id = :id");
    $st->execute([':id' => $id]);
    $cand = $st->fetch();

    if ($cand) {
        $del = pdo()->prepare("DELETE FROM candidates WHERE id = :id")->execute([':id' => $id]);
        if ($del) {
            if ($cand['foto'] !== 'default.jpg') {
                $f = __DIR__ . '/../assets/images/candidates/' . $cand['foto'];
                if (is_file($f)) @unlink($f);
            }
            $message = 'Kandidat berhasil dihapus!';
            log_activity('admin', (int)$_SESSION['admin_id'], $_SESSION['admin_username'], "Menghapus kandidat: {$cand['nama']}");
        } else {
            $error = 'Gagal menghapus kandidat.';
        }
    }
}

$candidates = pdo()->query("SELECT * FROM candidates ORDER BY posisi, nomor_urut ASC")->fetchAll();
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kelola Kandidat - Admin Pemira</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #1e3a8a;
            --secondary-color: #fbbf24;
            --accent-color: #0ea5e9;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --purple-color: #7c3aed;
        }
        
        body {
            background: #f1f5f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .sidebar {
            background: linear-gradient(180deg, var(--primary-color) 0%, #1e40af 100%);
            min-height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            width: 260px;
            padding: 0;
            box-shadow: 4px 0 20px rgba(0,0,0,0.1);
            z-index: 1000;
        }
        
        .sidebar-header {
            padding: 30px 20px;
            background: rgba(0,0,0,0.2);
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .sidebar-header h4 {
            color: white;
            font-weight: 700;
            margin: 15px 0 5px 0;
        }
        
        .sidebar-header p {
            color: rgba(255,255,255,0.8);
            margin: 0;
            font-size: 0.9rem;
        }
        
        .sidebar-menu {
            padding: 20px 0;
        }
        
        .sidebar-menu a {
            color: rgba(255,255,255,0.9);
            text-decoration: none;
            padding: 15px 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }
        
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: rgba(255,255,255,0.1);
            color: white;
            border-left-color: var(--secondary-color);
        }
        
        .sidebar-menu a i {
            width: 20px;
            text-align: center;
        }
        
        .main-content {
            margin-left: 260px;
            padding: 30px;
        }
        
        .top-bar {
            background: white;
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .top-bar h2 {
            color: var(--primary-color);
            font-weight: 700;
            margin: 0;
        }
        
        .content-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        
        .btn-add {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(16, 185, 129, 0.3);
        }
        
        .table-custom {
            font-size: 0.9rem;
        }
        
        .table-custom thead {
            background: #f8fafc;
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .table-custom tbody tr {
            transition: background 0.2s;
        }
        
        .table-custom tbody tr:hover {
            background: #f8fafc;
        }
        
        .candidate-photo-table {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--accent-color);
        }
        
        .badge-position {
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.85rem;
        }
        
        .modal-header {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-vote-yea" style="font-size: 50px; color: var(--secondary-color);"></i>
            <h4>PEMIRA HMTA</h4>
            <p>Admin Panel</p>
        </div>
        <div class="sidebar-menu">
            <a href="dashboard.php">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a href="candidates.php" class="active">
                <i class="fas fa-users"></i> Kelola Kandidat
            </a>
            <a href="voters.php">
                <i class="fas fa-user-check"></i> Kelola Pemilih
            </a>
            <a href="results.php">
                <i class="fas fa-chart-bar"></i> Hasil Voting
            </a>
            <a href="logs.php">
                <i class="fas fa-history"></i> Log Aktivitas
            </a>
            <a href="logout.php">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="top-bar">
            <h2><i class="fas fa-users"></i> Kelola Kandidat</h2>
            <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addModal">
                <i class="fas fa-plus-circle"></i> Tambah Kandidat
            </button>
        </div>

        <?php if ($message): ?>
            <div class="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle"></i> <?php echo $message; ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>

        <?php if ($error): ?>
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle"></i> <?php echo $error; ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>

        <div class="content-card">
            <div class="table-responsive">
                <table class="table table-custom table-hover">
                    <thead>
                        <tr>
                            <th width="5%">No</th>
                            <th width="10%">Foto</th>
                            <th>Nama</th>
                            <th width="12%">Posisi</th>
                            <th width="10%">No. Urut</th>
                            <th>Visi & Misi</th>
                            <th width="15%">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                        $no = 1;
                        foreach ($candidates as $candidate): 
                        ?>
                            <tr>
                                <td><?php echo $no++; ?></td>
                                <td>
                                    <img src="../assets/images/candidates/<?php echo htmlspecialchars($candidate['foto']); ?>" 
                                         class="candidate-photo-table"
                                         onerror="this.src='../assets/images/candidates/default.jpg'">
                                </td>
                                <td><strong><?php echo htmlspecialchars($candidate['nama']); ?></strong></td>
                                <td>
                                    <?php if ($candidate['posisi'] == 'kahim'): ?>
                                        <span class="badge-position bg-primary">
                                            <i class="fas fa-crown"></i> Kahim
                                        </span>
                                    <?php else: ?>
                                        <span class="badge-position bg-success">
                                            <i class="fas fa-users"></i> Senat
                                        </span>
                                    <?php endif; ?>
                                </td>
                                <td><strong><?php echo $candidate['nomor_urut']; ?></strong></td>
                                <td><?php echo substr(htmlspecialchars($candidate['visi_misi']), 0, 100); ?>...</td>
                                <td>
                                    <button class="btn btn-sm btn-warning" 
                                            onclick="editCandidate(<?php echo htmlspecialchars(json_encode($candidate)); ?>)">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-info" 
                                            onclick="viewCandidate(<?php echo htmlspecialchars(json_encode($candidate)); ?>)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <a href="?delete=<?php echo $candidate['id']; ?>" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Yakin ingin menghapus kandidat ini?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal Tambah Kandidat -->
    <div class="modal fade" id="addModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-plus-circle"></i> Tambah Kandidat</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Nama Lengkap</label>
                                    <input type="text" class="form-control" name="nama" required>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Posisi</label>
                                    <select class="form-select" name="posisi" required>
                                        <option value="kahim">Kepala Himpunan</option>
                                        <option value="senat">Senat</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Nomor Urut</label>
                                    <input type="number" class="form-control" name="nomor_urut" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Foto Kandidat</label>
                            <input type="file" class="form-control" name="foto" accept="image/*">
                            <small class="text-muted">Format: JPG, PNG, GIF (Maks 2MB)</small>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Visi & Misi</label>
                            <textarea class="form-control" name="visi_misi" rows="4" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Grand Design Organisasi</label>
                            <textarea class="form-control" name="grand_design" rows="4" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" name="add_candidate" class="btn btn-primary">
                            <i class="fas fa-save"></i> Simpan
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Edit Kandidat -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-edit"></i> Edit Kandidat</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="id" id="edit_id">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Nama Lengkap</label>
                                    <input type="text" class="form-control" name="nama" id="edit_nama" required>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Posisi</label>
                                    <select class="form-select" name="posisi" id="edit_posisi" required>
                                        <option value="kahim">Kepala Himpunan</option>
                                        <option value="senat">Senat</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Nomor Urut</label>
                                    <input type="number" class="form-control" name="nomor_urut" id="edit_nomor_urut" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Foto Kandidat (Kosongkan jika tidak diubah)</label>
                            <input type="file" class="form-control" name="foto" accept="image/*">
                            <small class="text-muted">Format: JPG, PNG, GIF (Maks 2MB)</small>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Visi & Misi</label>
                            <textarea class="form-control" name="visi_misi" id="edit_visi_misi" rows="4" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Grand Design Organisasi</label>
                            <textarea class="form-control" name="grand_design" id="edit_grand_design" rows="4" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" name="edit_candidate" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal View Kandidat -->
    <div class="modal fade" id="viewModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-eye"></i> Detail Kandidat</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="text-center mb-4">
                        <img id="view_foto" src="" alt="Foto" style="width: 150px; height: 150px; border-radius: 50%; border: 5px solid var(--accent-color);">
                    </div>
                    <table class="table">
                        <tr>
                            <th width="30%">Nama</th>
                            <td id="view_nama"></td>
                        </tr>
                        <tr>
                            <th>Posisi</th>
                            <td id="view_posisi"></td>
                        </tr>
                        <tr>
                            <th>Nomor Urut</th>
                            <td id="view_nomor_urut"></td>
                        </tr>
                        <tr>
                            <th>Visi & Misi</th>
                            <td id="view_visi_misi" style="white-space: pre-line;"></td>
                        </tr>
                        <tr>
                            <th>Grand Design</th>
                            <td id="view_grand_design" style="white-space: pre-line;"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editCandidate(candidate) {
            document.getElementById('edit_id').value = candidate.id;
            document.getElementById('edit_nama').value = candidate.nama;
            document.getElementById('edit_posisi').value = candidate.posisi;
            document.getElementById('edit_nomor_urut').value = candidate.nomor_urut;
            document.getElementById('edit_visi_misi').value = candidate.visi_misi;
            document.getElementById('edit_grand_design').value = candidate.grand_design;
            
            new bootstrap.Modal(document.getElementById('editModal')).show();
        }

        function viewCandidate(candidate) {
            document.getElementById('view_foto').src = '../assets/images/candidates/' + candidate.foto;
            document.getElementById('view_nama').textContent = candidate.nama;
            document.getElementById('view_posisi').textContent = candidate.posisi == 'kahim' ? 'Kepala Himpunan' : 'Senat';
            document.getElementById('view_nomor_urut').textContent = candidate.nomor_urut;
            document.getElementById('view_visi_misi').textContent = candidate.visi_misi;
            document.getElementById('view_grand_design').textContent = candidate.grand_design;
            
            new bootstrap.Modal(document.getElementById('viewModal')).show();
        }
    </script>
</body>
</html>