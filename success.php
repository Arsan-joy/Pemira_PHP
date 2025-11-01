<?php
require_once 'config/database.php';
require_once 'includes/session.php';

// Cek login
if (!is_voter_logged_in()) {
    header("Location: index.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voting Berhasil - Pemira HIMATEP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #1e3a8a;
            --success-color: #10b981;
        }
        
        body {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .success-container {
            max-width: 600px;
            margin: 0 auto;
            text-align: center;
        }
        
        .success-card {
            background: white;
            border-radius: 25px;
            padding: 50px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            animation: successPop 0.6s ease-out;
        }
        
        @keyframes successPop {
            0% {
                opacity: 0;
                transform: scale(0.8);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }
        
        .success-icon {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, var(--success-color) 0%, #059669 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            animation: checkmark 0.8s ease-out 0.3s both;
        }
        
        @keyframes checkmark {
            0% {
                transform: scale(0) rotate(45deg);
            }
            100% {
                transform: scale(1) rotate(0deg);
            }
        }
        
        .success-icon i {
            font-size: 60px;
            color: white;
        }
        
        h2 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 20px;
        }
        
        .success-message {
            color: #64748b;
            font-size: 1.1rem;
            margin-bottom: 30px;
            line-height: 1.8;
        }
        
        .btn-dashboard {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0ea5e9 100%);
            color: white;
            padding: 15px 40px;
            border-radius: 12px;
            font-weight: 700;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        
        .btn-dashboard:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(30, 58, 138, 0.3);
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-container">
            <div class="success-card">
                <div class="success-icon">
                    <i class="fas fa-check"></i>
                </div>
                
                <h2>VOTING BERHASIL!</h2>
                
                <div class="success-message">
                    <p>
                        <strong>Terima kasih atas partisipasi Anda!</strong>
                    </p>
                    <p>
                        Suara Anda telah berhasil tersimpan dengan aman.<br>
                        Anda telah berkontribusi dalam menentukan pemimpin<br>
                        Himpunan Mahasiswa Teknik Pertambangan.
                    </p>
                    <p class="text-muted">
                        <i class="fas fa-lock"></i> 
                        Pilihan Anda dijaga kerahasiaannya
                    </p>
                </div>
                
                <a href="dashboard.php" class="btn-dashboard">
                    <i class="fas fa-home"></i> KEMBALI KE DASHBOARD
                </a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Redirect otomatis setelah 10 detik
        setTimeout(function() {
            window.location.href = 'dashboard.php';
        }, 10000);
    </script>
</body>
</html>