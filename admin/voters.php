<?php
require_once '../config/database.php';
require_once '../includes/session.php';
require_once '../includes/functions.php';

if (!is_admin_logged_in()) { header('Location: index.php'); exit; }

$message = '';
$error   = '';

// Tambah pemilih
if (isset($_POST['add_voter'])) {
    $username     = clean_input($_POST['username'] ?? '');
    $password_raw = $_POST['password'] ?? '';
    $nama_lengkap = clean_input($_POST['nama_lengkap'] ?? '');
    $nim          = clean_input($_POST['nim'] ?? '');
    $prodi        = clean_input($_POST['prodi'] ?? 'Teknik Pertambangan');

    if ($username === '' || $password_raw === '' || $nama_lengkap === '' || $nim === '') {
        $error = 'Data pemilih tidak lengkap.';
    } else {
        $password = password_hash($password_raw, PASSWORD_DEFAULT);
        $sql = "INSERT INTO voters (username, password, nama_lengkap, nim, prodi)
                VALUES (:u,:p,:n,:nim,:prodi)";
        try {
            pdo()->prepare($sql)->execute([
                ':u'=>$username, ':p'=>$password, ':n'=>$nama_lengkap, ':nim'=>$nim, ':prodi'=>$prodi
            ]);
            $message = 'Pemilih berhasil ditambahkan!';
            log_activity('admin', (int)$_SESSION['admin_id'], $_SESSION['admin_username'], "Menambah pemilih: $nama_lengkap");
        } catch (Throwable $e) {
            $error = 'Gagal menambahkan pemilih! Username atau NIM mungkin sudah ada.';
        }
    }
}

// Edit pemilih
if (isset($_POST['edit_voter'])) {
    $id           = (int)($_POST['id'] ?? 0);
    $username     = clean_input($_POST['username'] ?? '');
    $password_raw = $_POST['password'] ?? '';
    $nama_lengkap = clean_input($_POST['nama_lengkap'] ?? '');
    $nim          = clean_input($_POST['nim'] ?? '');
    $prodi        = clean_input($_POST['prodi'] ?? '');

    if ($id <= 0) {
        $error = 'ID pemilih tidak valid.';
    } else {
        if ($password_raw !== '') {
            $password = password_hash($password_raw, PASSWORD_DEFAULT);
            $sql = "UPDATE voters SET username=:u, password=:p, nama_lengkap=:n, nim=:nim, prodi=:prodi WHERE id=:id";
            $params = [':u'=>$username, ':p'=>$password, ':n'=>$nama_lengkap, ':nim'=>$nim, ':prodi'=>$prodi, ':id'=>$id];
        } else {
            $sql = "UPDATE voters SET username=:u, nama_lengkap=:n, nim=:nim, prodi=:prodi WHERE id=:id";
            $params = [':u'=>$username, ':n'=>$nama_lengkap, ':nim'=>$nim, ':prodi'=>$prodi, ':id'=>$id];
        }

        try {
            pdo()->prepare($sql)->execute($params);
            $message = 'Pemilih berhasil diupdate!';
            log_activity('admin', (int)$_SESSION['admin_id'], $_SESSION['admin_username'], "Mengupdate pemilih: $nama_lengkap");
        } catch (Throwable $e) {
            $error = 'Gagal mengupdate pemilih!';
        }
    }
}

// Hapus pemilih
if (isset($_GET['delete'])) {
    $id = (int)$_GET['delete'];
    $st = pdo()->prepare("SELECT nama_lengkap FROM voters WHERE id = :id");
    $st->execute([':id'=>$id]);
    $v = $st->fetch();
    if ($v) {
        $ok = pdo()->prepare("DELETE FROM voters WHERE id = :id")->execute([':id'=>$id]);
        if ($ok) {
            $message = 'Pemilih berhasil dihapus!';
            log_activity('admin', (int)$_SESSION['admin_id'], $_SESSION['admin_username'], "Menghapus pemilih: {$v['nama_lengkap']}");
        } else {
            $error = 'Gagal menghapus pemilih!';
        }
    }
}

// Reset status voting
if (isset($_GET['reset'])) {
    $id = (int)$_GET['reset'];
    $st = pdo()->prepare("SELECT nama_lengkap FROM voters WHERE id = :id");
    $st->execute([':id'=>$id]);
    $v = $st->fetch();

    if ($v) {
        $pdo = pdo();
        try {
            $pdo->beginTransaction();
            $pdo->prepare("DELETE FROM votes WHERE voter_id = :id")->execute([':id'=>$id]);
            $pdo->prepare("UPDATE voters SET has_voted = 0, voted_at = NULL WHERE id = :id")->execute([':id'=>$id]);
            $pdo->commit();
            $message = 'Status voting berhasil direset!';
            log_activity('admin', (int)$_SESSION['admin_id'], $_SESSION['admin_username'], "Reset status voting: {$v['nama_lengkap']}");
        } catch (Throwable $e) {
            if ($pdo->inTransaction()) $pdo->rollBack();
            $error = 'Gagal reset status voting!';
        }
    }
}

$voters = pdo()->query("SELECT * FROM voters ORDER BY has_voted ASC, nama_lengkap ASC")->fetchAll();
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kelola Pemilih - Admin Pemira</title>
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
        
        .badge-status {
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
            <a href="candidates.php">
                <i class="fas fa-users"></i> Kelola Kandidat
            </a>
            <a href="voters.php" class="active">
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
            <h2><i class="fas fa-user-check"></i> Kelola Pemilih</h2>
            <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addModal">
                <i class="fas fa-plus-circle"></i> Tambah Pemilih
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
                            <th>Nama Lengkap</th>
                            <th>NIM</th>
                            <th>Username</th>
                            <th>Prodi</th>
                            <th width="12%">Status</th>
                            <th>Waktu Vote</th>
                            <th width="15%">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                        $no = 1;
                        foreach ($voters as $voter): 
                        ?>
                            <tr>
                                <td><?php echo $no++; ?></td>
                                <td><strong><?php echo htmlspecialchars($voter['nama_lengkap']); ?></strong></td>
                                <td><?php echo htmlspecialchars($voter['nim']); ?></td>
                                <td><code><?php echo htmlspecialchars($voter['username']); ?></code></td>
                                <td><?php echo htmlspecialchars($voter['prodi']); ?></td>
                                <td>
                                    <?php if ($voter['has_voted']): ?>
                                        <span class="badge-status bg-success">
                                            <i class="fas fa-check-circle"></i> Sudah Vote
                                        </span>
                                    <?php else: ?>
                                        <span class="badge-status bg-warning text-dark">
                                            <i class="fas fa-clock"></i> Belum Vote
                                        </span>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <?php 
                                    if (!empty($voter['voted_at'])) {
                                        echo date('d/m/Y H:i', strtotime($voter['voted_at']));
                                    } else {
                                        echo '-';
                                    }
                                    ?>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-warning" 
                                            onclick="editVoter(<?php echo htmlspecialchars(json_encode($voter)); ?>)">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <?php if (!empty($voter['has_voted'])): ?>
                                        <a href="?reset=<?php echo $voter['id']; ?>" 
                                           class="btn btn-sm btn-info"
                                           onclick="return confirm('Yakin ingin reset status voting?')">
                                            <i class="fas fa-redo"></i>
                                        </a>
                                    <?php endif; ?>
                                    <a href="?delete=<?php echo $voter['id']; ?>" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Yakin ingin menghapus pemilih ini?')">
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

    <!-- Modal Tambah Pemilih -->
    <div class="modal fade" id="addModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-plus-circle"></i> Tambah Pemilih</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Username</label>
                            <input type="text" class="form-control" name="username" required>
                            <small class="text-muted">Username untuk login</small>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Password</label>
                            <input type="password" class="form-control" name="password" required>
                            <small class="text-muted">Password untuk login</small>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Nama Lengkap</label>
                            <input type="text" class="form-control" name="nama_lengkap" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">NIM</label>
                            <input type="text" class="form-control" name="nim" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Program Studi</label>
                            <input type="text" class="form-control" name="prodi" value="Teknik Pertambangan" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" name="add_voter" class="btn btn-primary">
                            <i class="fas fa-save"></i> Simpan
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Edit Pemilih -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-edit"></i> Edit Pemilih</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST">
                    <input type="hidden" name="id" id="edit_id">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Username</label>
                            <input type="text" class="form-control" name="username" id="edit_username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Password (Kosongkan jika tidak diubah)</label>
                            <input type="password" class="form-control" name="password">
                            <small class="text-muted">Isi hanya jika ingin mengubah password</small>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Nama Lengkap</label>
                            <input type="text" class="form-control" name="nama_lengkap" id="edit_nama_lengkap" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">NIM</label>
                            <input type="text" class="form-control" name="nim" id="edit_nim" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Program Studi</label>
                            <input type="text" class="form-control" name="prodi" id="edit_prodi" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" name="edit_voter" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editVoter(voter) {
            document.getElementById('edit_id').value = voter.id;
            document.getElementById('edit_username').value = voter.username;
            document.getElementById('edit_nama_lengkap').value = voter.nama_lengkap;
            document.getElementById('edit_nim').value = voter.nim;
            document.getElementById('edit_prodi').value = voter.prodi;
            
            new bootstrap.Modal(document.getElementById('editModal')).show();
        }
    </script>
</body>
</html>