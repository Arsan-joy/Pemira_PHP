<?php
require_once 'config/database.php';
require_once 'includes/session.php';
require_once 'includes/functions.php';

if (!is_voter_logged_in()) { header('Location: index.php'); exit; }

$voter_id = (int)$_SESSION['voter_id'];
if (has_user_voted($voter_id)) { header('Location: dashboard.php'); exit; }

if ($_SERVER['REQUEST_METHOD'] !== 'POST') { header('Location: dashboard.php'); exit; }

$kahim_id = (int)($_POST['kahim_id'] ?? 0);
$senat_id = (int)($_POST['senat_id'] ?? 0);

$st = pdo()->prepare("SELECT * FROM candidates WHERE id = :id AND posisi = 'kahim' LIMIT 1");
$st->execute([':id' => $kahim_id]);
$kandidat_kahim = $st->fetch();

$st = pdo()->prepare("SELECT * FROM candidates WHERE id = :id AND posisi = 'senat' LIMIT 1");
$st->execute([':id' => $senat_id]);
$kandidat_senat = $st->fetch();

if (!$kandidat_kahim || !$kandidat_senat) { header('Location: dashboard.php'); exit; }

if (($_POST['confirm'] ?? '') === 'yes') {
    $pdo = pdo();
    try {
        $pdo->beginTransaction();

        $ins = $pdo->prepare("INSERT INTO votes (voter_id, candidate_id, posisi) VALUES (:v, :c, :p)");
        $ins->execute([':v' => $voter_id, ':c' => (int)$kandidat_kahim['id'], ':p' => 'kahim']);
        $ins->execute([':v' => $voter_id, ':c' => (int)$kandidat_senat['id'], ':p' => 'senat']);

        $upd = $pdo->prepare("UPDATE voters SET has_voted = 1, voted_at = NOW() WHERE id = :id");
        $upd->execute([':id' => $voter_id]);

        log_activity('voter', $voter_id, $_SESSION['voter_username'], 
            "Melakukan voting - Kahim: {$kandidat_kahim['nama']}, Senat: {$kandidat_senat['nama']}");

        $pdo->commit();
        header('Location: success.php'); exit;
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        $error = 'Terjadi kesalahan saat menyimpan vote. Silakan coba lagi.';
    }
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Konfirmasi Pilihan - Pemira HIMATEP</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #1e3a8a;
            --secondary-color: #fbbf24;
            --accent-color: #0ea5e9;
            --success-color: #10b981;
            --danger-color: #ef4444;
        }
        
        body {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 30px 0;
        }
        
        .confirmation-container {
            max-width: 900px;
            margin: 0 auto;
        }
        
        .confirmation-card {
            background: white;
            border-radius: 25px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
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
        
        .confirmation-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }
        
        .confirmation-header i {
            font-size: 70px;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }
        
        .confirmation-header h2 {
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .confirmation-body {
            padding: 40px;
        }
        
        .warning-box {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            border: 3px solid var(--secondary-color);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .warning-box i {
            font-size: 50px;
            color: #92400e;
            margin-bottom: 15px;
        }
        
        .warning-box h4 {
            color: #92400e;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .warning-box p {
            color: #78350f;
            margin-bottom: 0;
            font-size: 1.1rem;
        }
        
        .candidate-confirm-box {
            background: #f8fafc;
            border: 2px solid #e2e8f0;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
        }
        
        .candidate-confirm-box h5 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--accent-color);
        }
        
        .candidate-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .candidate-photo-small {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 4px solid var(--accent-color);
            object-fit: cover;
        }
        
        .candidate-details h4 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .candidate-details p {
            margin-bottom: 5px;
            color: #64748b;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn-custom {
            flex: 1;
            padding: 18px;
            border-radius: 15px;
            font-weight: 700;
            font-size: 1.2rem;
            border: none;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-confirm {
            background: linear-gradient(135deg, var(--success-color) 0%, #059669 100%);
            color: white;
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.3);
        }
        
        .btn-confirm:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(16, 185, 129, 0.4);
        }
        
        .btn-cancel {
            background: linear-gradient(135deg, #64748b 0%, #475569 100%);
            color: white;
            box-shadow: 0 10px 25px rgba(100, 116, 139, 0.3);
        }
        
        .btn-cancel:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(100, 116, 139, 0.4);
        }
        
        @media (max-width: 768px) {
            .action-buttons {
                flex-direction: column;
            }
            
            .candidate-info {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="confirmation-container">
            <div class="confirmation-card">
                <div class="confirmation-header">
                    <i class="fas fa-clipboard-check"></i>
                    <h2>KONFIRMASI PILIHAN ANDA</h2>
                    <p>Pastikan pilihan Anda sudah benar sebelum submit</p>
                </div>
                
                <div class="confirmation-body">
                    <?php if (isset($error)): ?>
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle"></i> <?php echo $error; ?>
                        </div>
                    <?php endif; ?>
                    
                    <div class="warning-box">
                        <i class="fas fa-exclamation-triangle"></i>
                        <h4>PERHATIAN!</h4>
                        <p>Setelah Anda menekan tombol "KONFIRMASI & SUBMIT", pilihan Anda tidak dapat diubah lagi.</p>
                    </div>
                    
                    <!-- Pilihan Kahim -->
                    <div class="candidate-confirm-box">
                        <h5><i class="fas fa-crown"></i> PILIHAN KEPALA HIMPUNAN</h5>
                        <div class="candidate-info">
                            <img src="assets/images/candidates/<?php echo htmlspecialchars($kandidat_kahim['foto']); ?>" 
                                 alt="<?php echo htmlspecialchars($kandidat_kahim['nama']); ?>" 
                                 class="candidate-photo-small"
                                 onerror="this.src='assets/images/candidates/default.jpg'">
                            <div class="candidate-details">
                                <h4><?php echo htmlspecialchars($kandidat_kahim['nama']); ?></h4>
                                <p><strong>Nomor Urut:</strong> <?php echo $kandidat_kahim['nomor_urut']; ?></p>
                                <p><strong>Posisi:</strong> Kepala Himpunan</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pilihan Senat -->
                    <div class="candidate-confirm-box">
                        <h5><i class="fas fa-users"></i> PILIHAN SENAT</h5>
                        <div class="candidate-info">
                            <img src="assets/images/candidates/<?php echo htmlspecialchars($kandidat_senat['foto']); ?>" 
                                 alt="<?php echo htmlspecialchars($kandidat_senat['nama']); ?>" 
                                 class="candidate-photo-small"
                                 onerror="this.src='assets/images/candidates/default.jpg'">
                            <div class="candidate-details">
                                <h4><?php echo htmlspecialchars($kandidat_senat['nama']); ?></h4>
                                <p><strong>Nomor Urut:</strong> <?php echo $kandidat_senat['nomor_urut']; ?></p>
                                <p><strong>Posisi:</strong> Senat</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <form method="POST" action="" id="confirmForm">
                        <input type="hidden" name="kahim_id" value="<?php echo $kahim_id; ?>">
                        <input type="hidden" name="senat_id" value="<?php echo $senat_id; ?>">
                        <input type="hidden" name="confirm" value="yes">
                        
                        <div class="action-buttons">
                            <button type="button" class="btn-custom btn-cancel" onclick="window.history.back()">
                                <i class="fas fa-times-circle"></i> KEMBALI & UBAH
                            </button>
                            <button type="submit" class="btn-custom btn-confirm" id="btnConfirm">
                                <i class="fas fa-check-circle"></i> KONFIRMASI & SUBMIT
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('confirmForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (confirm('Apakah Anda yakin dengan pilihan ini?\n\nSetelah konfirmasi, pilihan tidak dapat diubah lagi!')) {
                document.getElementById('btnConfirm').disabled = true;
                document.getElementById('btnConfirm').innerHTML = '<i class="fas fa-spinner fa-spin"></i> Menyimpan...';
                this.submit();
            }
        });
    </script>
</body>
</html>