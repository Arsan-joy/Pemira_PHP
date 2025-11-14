<?php
require_once '../config/database.php';
require_once '../includes/session.php';
require_once '../includes/functions.php';

if (is_admin_logged_in()) { header('Location: dashboard.php'); exit; }

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = clean_input($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($username === '' || $password === '') {
        $error = 'Username dan password harus diisi!';
    } else {
        $stmt = pdo()->prepare("SELECT * FROM admin WHERE username = :u LIMIT 1");
        $stmt->execute([':u' => $username]);
        $admin = $stmt->fetch();

        if ($admin && password_verify($password, $admin['password'])) {
            $_SESSION['admin_logged_in'] = true;
            $_SESSION['admin_id']       = (int)$admin['id'];
            $_SESSION['admin_username'] = $admin['username'];
            $_SESSION['admin_name']     = $admin['nama'];

            log_activity('admin', (int)$admin['id'], $admin['username'], 'Login berhasil');
            header('Location: dashboard.php'); exit;
        } else {
            $error = 'Username atau password salah!';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Pemira HMTA</title>
    <link rel="icon" href="assets/LOGO/IMG_1381.PNG" type="image/PNG">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #1e3a8a;
            --secondary-color: #fbbf24;
            --accent-color: #0ea5e9;
            --danger-color: #ef4444;
        }
        
        body {
            background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .login-container {
            max-width: 450px;
            margin: 0 auto;
        }
        
        .login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideUp 0.5s ease-out;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .login-header {
            background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }
        
        .login-header i {
            font-size: 60px;
            margin-bottom: 15px;
            animation: rotate 3s linear infinite;
        }
        
        
        .login-header h2 {
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .login-body {
            padding: 40px 30px;
        }
        
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 2px solid #e5e7eb;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #a78bfa;
            box-shadow: 0 0 0 3px rgba(167, 139, 250, 0.1);
        }
        
        .input-group-text {
            border-radius: 10px 0 0 10px;
            border: 2px solid #e5e7eb;
            border-right: none;
            background: #f9fafb;
        }
        
        .input-group .form-control {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }
        
        .btn-login {
            background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            color: white;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(124, 58, 237, 0.3);
        }
        
        .alert {
            border-radius: 10px;
            border: none;
        }
        
        .voter-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }
        
        .voter-link a {
            color: #7c3aed;
            text-decoration: none;
            font-weight: 600;
        }
        
        .voter-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="login-card">
                <div class="login-header">
                    <i class="fas fa-user-shield"></i>
                    <h2>ADMIN PANEL</h2>
                    <p>Pemira HMTA - Login Administrator</p>
                </div>
                
                <div class="login-body">
                    <h4 class="text-center mb-4" style="color: #7c3aed; font-weight: 700;">
                        <i class="fas fa-lock"></i> Login Administrator
                    </h4>
                    
                    <?php if ($error): ?>
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle"></i> <?php echo $error; ?>
                        </div>
                    <?php endif; ?>
                    
                    <form method="POST" action="">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Username</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-user"></i>
                                </span>
                                <input type="text" class="form-control" name="username" 
                                       placeholder="Masukkan username admin" required autofocus>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-lock"></i>
                                </span>
                                <input type="password" class="form-control" name="password" 
                                       placeholder="Masukkan password admin" required>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-login w-100">
                            <i class="fas fa-sign-in-alt"></i> LOGIN ADMIN
                        </button>
                    </form>
                    
                    <div class="voter-link">
                        <a href="../index.php">
                            <i class="fas fa-arrow-left"></i> Kembali ke Login Pemilih
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-4 text-white">
                <p class="mb-0">
                    <i class="fas fa-shield-alt"></i> 
                    Area khusus administrator sistem
                </p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>