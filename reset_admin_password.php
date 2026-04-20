<?php
/**
 * Script untuk Reset Password Admin
 * Jalankan file ini di browser untuk mereset password admin
 *
 * Perbaikan: sebelumnya file menggunakan $conn (mysqli) sehingga terjadi
 * `Undefined variable $conn`. Repo ini menggunakan PDO (lihat config/database.php),
 * jadi file ini diubah untuk memakai pdo() dan API PDO.
 */

require_once 'config/database.php';

$message = '';
$success = false;

// Proses reset password
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = trim($_POST['username'] ?? '');
    $new_password = trim($_POST['new_password'] ?? '');

    if ($username === '' || $new_password === '') {
        $message = 'Username dan password baru wajib diisi.';
    } else {
        // Hash password baru
        $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);

        try {
            $st = pdo()->prepare("UPDATE admin SET password = :pw WHERE username = :user");
            $st->execute([':pw' => $hashed_password, ':user' => $username]);

            if ($st->rowCount() > 0) {
                $success = true;
                // Escape output when shown in HTML
                $u = htmlspecialchars($username, ENT_QUOTES, 'UTF-8');
                $p = htmlspecialchars($new_password, ENT_QUOTES, 'UTF-8');
                $message = "Password admin berhasil direset!<br>Username: <strong>{$u}</strong><br>Password baru: <strong>{$p}</strong>";
            } else {
                $message = "Username admin tidak ditemukan atau password sama dengan yang lama.";
            }
        } catch (Throwable $e) {
            // Jangan tampilkan error DB detail ke user di production
            $message = "Gagal mereset password! (Error pada database)";
        }
    }
}

// Tampilkan daftar admin yang ada (gunakan PDO)
try {
    $admin_list = pdo()->query("SELECT id, username, nama FROM admin")->fetchAll();
} catch (Throwable $e) {
    $admin_list = [];
    $message = $message ?: 'Gagal mengambil daftar admin.';
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password Admin - Pemira HIMATEP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .reset-container { max-width: 600px; margin: 0 auto; }
        .reset-card { background: white; border-radius: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); padding: 40px; }
        .reset-header { text-align: center; margin-bottom: 30px; }
        .reset-header i { font-size: 60px; color: #667eea; margin-bottom: 15px; }
        .reset-header h2 { color: #1e3a8a; font-weight: 700; }
        .form-control { border-radius: 10px; padding: 12px 15px; border: 2px solid #e5e7eb; }
        .form-control:focus { border-color: #667eea; box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1); }
        .btn-reset { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; border-radius: 10px; padding: 12px; font-weight: 600; color: white; width: 100%; transition: transform 0.3s; }
        .btn-reset:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3); }
        .alert-custom { border-radius: 10px; border: none; padding: 20px; }
        .admin-list { background: #f8fafc; border-radius: 10px; padding: 15px; margin-top: 20px; }
        .admin-list h6 { color: #1e3a8a; font-weight: 700; margin-bottom: 10px; }
        .admin-item { background: white; padding: 10px; border-radius: 8px; margin-bottom: 8px; border-left: 4px solid #667eea; }
        .warning-box { background: #fef3c7; border: 2px solid #fbbf24; border-radius: 10px; padding: 15px; margin-bottom: 20px; }
        .warning-box i { color: #92400e; }
    </style>
</head>
<body>
    <div class="container">
        <div class="reset-container">
            <div class="reset-card">
                <div class="reset-header">
                    <i class="fas fa-key"></i>
                    <h2>Reset Password Admin</h2>
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
                    
                    <?php if ($success): ?>
                        <div class="text-center mt-3">
                            <a href="admin/index.php" class="btn btn-primary">
                                <i class="fas fa-sign-in-alt"></i> Login ke Admin Panel
                            </a>
                        </div>
                    <?php endif; ?>
                <?php endif; ?>
                
                <div class="admin-list">
                    <h6><i class="fas fa-users-cog"></i> Daftar Admin Terdaftar:</h6>
                    <?php if (!empty($admin_list)): ?>
                        <?php foreach ($admin_list as $admin): ?>
                            <div class="admin-item">
                                <strong>Username:</strong> <?php echo htmlspecialchars($admin['username'], ENT_QUOTES, 'UTF-8'); ?> <br>
                                <small class="text-muted">Nama: <?php echo htmlspecialchars($admin['nama'], ENT_QUOTES, 'UTF-8'); ?></small>
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <div class="text-muted">Tidak ada data admin yang ditemukan.</div>
                    <?php endif; ?>
                </div>
                
                <form method="POST" class="mt-4">
                    <div class="mb-3">
                        <label class="form-label fw-bold">
                            <i class="fas fa-user"></i> Username Admin
                        </label>
                        <input type="text" class="form-control" name="username" 
                               placeholder="Masukkan username admin" required>
                        <small class="text-muted">Pilih dari daftar admin di atas</small>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">
                            <i class="fas fa-lock"></i> Password Baru
                        </label>
                        <input type="text" class="form-control" name="new_password" 
                               placeholder="Masukkan password baru" required>
                        <small class="text-muted">Password baru yang akan digunakan</small>
                    </div>
                    
                    <button type="submit" class="btn-reset">
                        <i class="fas fa-key"></i> RESET PASSWORD
                    </button>
                </form>
                
                <div class="text-center mt-4">
                    <hr>
                    <a href="index.php" class="text-decoration-none">
                        <i class="fas fa-arrow-left"></i> Kembali ke Halaman Login Pemilih
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>