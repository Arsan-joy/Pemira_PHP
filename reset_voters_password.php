<?php
/**
 * Script untuk Reset Password Pemilih/Peserta
 * Jalankan file ini di browser untuk mereset password pemilih
 */

require_once 'config/database.php';

$message = '';
$success = false;

// Proses reset password
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['reset_single'])) {
        // Reset password single voter
        $username = $_POST['username'];
        $new_password = $_POST['new_password'];
        
        // Hash password baru
        $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);
        
        // Update password
        $stmt = $conn->prepare("UPDATE voters SET password = ? WHERE username = ?");
        $stmt->bind_param("ss", $hashed_password, $username);
        
        if ($stmt->execute()) {
            if ($stmt->affected_rows > 0) {
                $success = true;
                $message = "Password pemilih berhasil direset!<br>Username: <strong>$username</strong><br>Password baru: <strong>$new_password</strong>";
            } else {
                $message = "Username pemilih tidak ditemukan!";
            }
        } else {
            $message = "Gagal mereset password!";
        }
        
        $stmt->close();
    } elseif (isset($_POST['reset_all'])) {
        // Reset password semua voter dengan password default
        $default_password = $_POST['default_password'];
        $hashed_password = password_hash($default_password, PASSWORD_DEFAULT);
        
        $stmt = $conn->prepare("UPDATE voters SET password = ?");
        $stmt->bind_param("s", $hashed_password);
        
        if ($stmt->execute()) {
            $affected = $stmt->affected_rows;
            $success = true;
            $message = "Password <strong>$affected pemilih</strong> berhasil direset!<br>Password default: <strong>$default_password</strong>";
        } else {
            $message = "Gagal mereset password semua pemilih!";
        }
        
        $stmt->close();
    }
}

// Tampilkan daftar pemilih
$voters_list = $conn->query("SELECT id, username, nama_lengkap, nim, has_voted FROM voters ORDER BY nama_lengkap ASC");
$total_voters = $voters_list->num_rows;
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password Pemilih - Pemira HIMATEP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #0ea5e9 0%, #1e3a8a 100%);
            min-height: 100vh;
            padding: 30px 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .reset-container {
            max-width: 900px;
            margin: 0 auto;
        }
        
        .reset-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 40px;
            margin-bottom: 20px;
        }
        
        .reset-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .reset-header i {
            font-size: 60px;
            color: #0ea5e9;
            margin-bottom: 15px;
        }
        
        .reset-header h2 {
            color: #1e3a8a;
            font-weight: 700;
        }
        
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 2px solid #e5e7eb;
        }
        
        .form-control:focus {
            border-color: #0ea5e9;
            box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.1);
        }
        
        .btn-reset {
            background: linear-gradient(135deg, #0ea5e9 0%, #1e3a8a 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 25px;
            font-weight: 600;
            color: white;
            transition: transform 0.3s;
        }
        
        .btn-reset:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(14, 165, 233, 0.3);
            color: white;
        }
        
        .btn-reset-all {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 25px;
            font-weight: 600;
            color: white;
            transition: transform 0.3s;
        }
        
        .btn-reset-all:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(239, 68, 68, 0.3);
            color: white;
        }
        
        .alert-custom {
            border-radius: 10px;
            border: none;
            padding: 20px;
        }
        
        .warning-box {
            background: #fef3c7;
            border: 2px solid #fbbf24;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .warning-box i {
            color: #92400e;
        }
        
        .danger-box {
            background: #fee2e2;
            border: 2px solid #ef4444;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .danger-box i {
            color: #991b1b;
        }
        
        .voters-table {
            max-height: 400px;
            overflow-y: auto;
            border-radius: 10px;
            border: 1px solid #e5e7eb;
        }
        
        .table-custom {
            font-size: 0.9rem;
        }
        
        .table-custom thead {
            position: sticky;
            top: 0;
            background: #f8fafc;
            z-index: 10;
        }
        
        .badge-voted {
            background: #10b981;
            color: white;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.8rem;
        }
        
        .badge-not-voted {
            background: #fbbf24;
            color: #78350f;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.8rem;
        }
        
        .section-divider {
            border-top: 2px solid #e5e7eb;
            margin: 30px 0;
            position: relative;
        }
        
        .section-divider span {
            position: absolute;
            top: -12px;
            left: 50%;
            transform: translateX(-50%);
            background: white;
            padding: 0 20px;
            color: #64748b;
            font-weight: 600;
        }
        
        .stats-box {
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .stats-box h3 {
            color: #1e3a8a;
            font-weight: 700;
            margin: 0;
        }
        
        .stats-box p {
            color: #1e40af;
            margin: 5px 0 0 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="reset-container">
            <div class="reset-card">
                <div class="reset-header">
                    <i class="fas fa-users-cog"></i>
                    <h2>Reset Password Pemilih</h2>
                    <p class="text-muted">Sistem Pemira HIMATEP</p>
                </div>
                
                <div class="warning-box">
                    <i class="fas fa-exclamation-triangle"></i>
                    <strong>PERHATIAN:</strong> Setelah selesai mereset password, segera hapus file ini dari server untuk keamanan!
                </div>
                
                <?php if ($message): ?>
                    <div class="alert-custom <?php echo $success ? 'alert-success' : 'alert-danger'; ?>">
                        <?php if ($success): ?>
                            <i class="fas fa-check-circle"></i>
                        <?php else: ?>
                            <i class="fas fa-exclamation-circle"></i>
                        <?php endif; ?>
                        <?php echo $message; ?>
                    </div>
                <?php endif; ?>
                
                <div class="stats-box">
                    <h3><i class="fas fa-users"></i> <?php echo $total_voters; ?></h3>
                    <p>Total Pemilih Terdaftar</p>
                </div>
                
                <!-- Reset Single Voter -->
                <h5 class="mb-3"><i class="fas fa-user-edit"></i> Reset Password Individual</h5>
                <form method="POST" class="mb-4">
                    <div class="row">
                        <div class="col-md-5">
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-user"></i> Username Pemilih
                                </label>
                                <input type="text" class="form-control" name="username" 
                                       placeholder="Masukkan username" required>
                                <small class="text-muted">Pilih dari tabel di bawah</small>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-lock"></i> Password Baru
                                </label>
                                <input type="text" class="form-control" name="new_password" 
                                       placeholder="Masukkan password baru" required>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-bold d-none d-md-block">&nbsp;</label>
                            <button type="submit" name="reset_single" class="btn btn-reset w-100">
                                <i class="fas fa-key"></i> Reset
                            </button>
                        </div>
                    </div>
                </form>
                
                <div class="section-divider">
                    <span>ATAU</span>
                </div>
                
                <!-- Reset All Voters -->
                <div class="danger-box">
                    <i class="fas fa-exclamation-circle"></i>
                    <strong>BAHAYA:</strong> Fitur ini akan mereset password SEMUA pemilih sekaligus!
                </div>
                
                <h5 class="mb-3"><i class="fas fa-users-cog"></i> Reset Password Semua Pemilih</h5>
                <form method="POST" onsubmit="return confirm('PERHATIAN!\n\nAnda akan mereset password SEMUA pemilih (<?php echo $total_voters; ?> orang).\n\nApakah Anda yakin ingin melanjutkan?');">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-key"></i> Password Default untuk Semua Pemilih
                                </label>
                                <input type="text" class="form-control" name="default_password" 
                                       placeholder="Contoh: voter123" required>
                                <small class="text-muted">Password ini akan digunakan untuk semua pemilih</small>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold d-none d-md-block">&nbsp;</label>
                            <button type="submit" name="reset_all" class="btn btn-reset-all w-100">
                                <i class="fas fa-redo"></i> Reset Semua
                            </button>
                        </div>
                    </div>
                </form>
                
                <div class="section-divider">
                    <span>DAFTAR PEMILIH</span>
                </div>
                
                <!-- Daftar Pemilih -->
                <div class="voters-table">
                    <table class="table table-custom table-hover mb-0">
                        <thead>
                            <tr>
                                <th width="5%">No</th>
                                <th>Username</th>
                                <th>Nama Lengkap</th>
                                <th>NIM</th>
                                <th width="12%">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                            $no = 1;
                            $voters_list->data_seek(0); // Reset pointer
                            while ($voter = $voters_list->fetch_assoc()): 
                            ?>
                                <tr>
                                    <td><?php echo $no++; ?></td>
                                    <td><code><?php echo htmlspecialchars($voter['username']); ?></code></td>
                                    <td><?php echo htmlspecialchars($voter['nama_lengkap']); ?></td>
                                    <td><?php echo htmlspecialchars($voter['nim']); ?></td>
                                    <td>
                                        <?php if ($voter['has_voted']): ?>
                                            <span class="badge-voted">
                                                <i class="fas fa-check"></i> Voted
                                            </span>
                                        <?php else: ?>
                                            <span class="badge-not-voted">
                                                <i class="fas fa-clock"></i> Belum
                                            </span>
                                        <?php endif; ?>
                                    </td>
                                </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>
                
                <div class="text-center mt-4">
                    <hr>
                    <div class="d-flex gap-3 justify-content-center flex-wrap">
                        <a href="index.php" class="btn btn-outline-primary">
                            <i class="fas fa-arrow-left"></i> Login Pemilih
                        </a>
                        <a href="admin/index.php" class="btn btn-outline-secondary">
                            <i class="fas fa-user-shield"></i> Login Admin
                        </a>
                        <a href="reset_admin_password.php" class="btn btn-outline-danger">
                            <i class="fas fa-key"></i> Reset Admin
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="text-center text-white">
                <p class="mb-0">
                    <i class="fas fa-shield-alt"></i> 
                    <strong>Keamanan:</strong> Hapus file ini setelah selesai digunakan!
                </p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-fill username saat klik row di tabel
        document.querySelectorAll('.voters-table tbody tr').forEach(row => {
            row.style.cursor = 'pointer';
            row.addEventListener('click', function() {
                const username = this.querySelector('code').textContent;
                document.querySelector('input[name="username"]').value = username;
                document.querySelector('input[name="new_password"]').focus();
            });
        });
    </script>
</body>
</html>