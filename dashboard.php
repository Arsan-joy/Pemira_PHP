<?php
require_once 'config/database.php';
require_once 'includes/session.php';
require_once 'includes/functions.php';

if (!is_voter_logged_in()) {
    header('Location: index.php'); exit;
}

$voter_id  = (int)$_SESSION['voter_id'];
$has_voted = has_user_voted($voter_id);

$kandidat_kahim = get_candidates_by_position('kahim');
$kandidat_senat = get_candidates_by_position('senat');

$stmt = pdo()->prepare("SELECT * FROM voters WHERE id = :id LIMIT 1");
$stmt->execute([':id' => $voter_id]);
$voter = $stmt->fetch();
if (!$voter) { logout(); header('Location: index.php'); exit; }
?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard Pemilih - Pemira HMTA</title>
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
            padding-bottom: 50px;
        }
        
        .navbar-custom {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            padding: 15px 0;
        }
        
        .navbar-custom .navbar-brand {
            color: white !important;
            font-weight: 700;
            font-size: 1.5rem;
        }
        
        .navbar-custom .nav-link {
            color: rgba(255,255,255,0.9) !important;
            font-weight: 500;
            margin: 0 10px;
            transition: all 0.3s;
        }
        
        .navbar-custom .nav-link:hover {
            color: var(--secondary-color) !important;
        }
        
        .user-info {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-top: 30px;
            border-left: 5px solid var(--accent-color);
        }
        
        .voting-status {
            padding: 20px;
            border-radius: 15px;
            margin-top: 20px;
            text-align: center;
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .status-not-voted {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            color: #92400e;
            border: 2px solid #fbbf24;
        }
        
        .status-voted {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
            border: 2px solid var(--success-color);
        }
        
        .section-title {
            text-align: center;
            margin: 50px 0 30px 0;
            position: relative;
        }
        
        .section-title h2 {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2.5rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        
        .section-title::after {
            content: '';
            display: block;
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            margin: 15px auto;
            border-radius: 2px;
        }
        
        .candidate-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.4s;
            margin-bottom: 30px;
            border: 3px solid transparent;
            height: 100%;
        }
        
        .candidate-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }
        
        .candidate-card.selected {
            border-color: var(--success-color);
            box-shadow: 0 0 0 5px rgba(16, 185, 129, 0.2);
        }
        
        .candidate-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            color: white;
            padding: 20px;
            text-align: center;
            position: relative;
        }
        
        .candidate-number {
            position: absolute;
            top: 10px;
            left: 10px;
            background: var(--secondary-color);
            color: var(--primary-color);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .candidate-photo {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid white;
            object-fit: cover;
            margin: 20px auto;
            display: block;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        
        .candidate-name {
            font-size: 1.5rem;
            font-weight: 700;
            margin-top: 15px;
        }
        
        .candidate-body {
            padding: 25px;
        }
        
        .candidate-section {
            margin-bottom: 20px;
        }
        
        .candidate-section h5 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .candidate-section p {
            color: #4b5563;
            line-height: 1.8;
            text-align: justify;
            white-space: pre-line;
        }
        
        .btn-select {
            width: 100%;
            padding: 15px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.1rem;
            border: none;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .btn-select-kahim {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            color: white;
        }
        
        .btn-select-senat {
            background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%);
            color: white;
        }
        
        .btn-select:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        
        .btn-select.selected {
            background: var(--success-color) !important;
        }
        
        .btn-select:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .submit-section {
            background: white;
            border-radius: 20px;
            padding: 40px;
            margin-top: 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .btn-submit-vote {
            background: linear-gradient(135deg, var(--success-color) 0%, #059669 100%);
            color: white;
            padding: 18px 60px;
            border-radius: 15px;
            font-weight: 700;
            font-size: 1.3rem;
            border: none;
            transition: all 0.3s;
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.3);
        }
        
        .btn-submit-vote:hover:not(:disabled) {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(16, 185, 129, 0.4);
        }
        
        .btn-submit-vote:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .alert-info-custom {
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            border: 2px solid var(--accent-color);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .badge-custom {
            padding: 8px 15px;
            border-radius: 8px;
            font-weight: 600;
        }
        
        @media (max-width: 768px) {
            .section-title h2 {
                font-size: 1.8rem;
            }
            
            .candidate-card {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-vote-yea"></i> PEMIRA HIMATEP
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.php">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.php">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- User Info -->
        <div class="user-info">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h4 style="color: var(--primary-color); margin-bottom: 10px;">
                        <i class="fas fa-user-circle"></i> Selamat Datang!
                    </h4>
                    <p class="mb-1"><strong>Nama:</strong> <?php echo htmlspecialchars($voter['nama_lengkap']); ?></p>
                    <p class="mb-1"><strong>NIM:</strong> <?php echo htmlspecialchars($voter['nim']); ?></p>
                    <p class="mb-0"><strong>Prodi:</strong> <?php echo htmlspecialchars($voter['prodi']); ?></p>
                </div>
                <div class="col-md-4 text-end">
                    <?php if ($has_voted): ?>
                        <span class="badge badge-custom bg-success">
                            <i class="fas fa-check-circle"></i> Sudah Memilih
                        </span>
                        <p class="text-muted small mt-2 mb-0">
                            <i class="far fa-clock"></i> 
                            <?php echo date('d/m/Y H:i', strtotime($voter['voted_at'])); ?>
                        </p>
                    <?php else: ?>
                        <span class="badge badge-custom bg-warning text-dark">
                            <i class="fas fa-hourglass-half"></i> Belum Memilih
                        </span>
                    <?php endif; ?>
                </div>
            </div>
        </div>

        <!-- Voting Status -->
        <?php if ($has_voted): ?>
            <div class="voting-status status-voted">
                <i class="fas fa-check-circle fa-3x mb-3"></i>
                <h4>Terima Kasih Telah Berpartisipasi!</h4>
                <p class="mb-0">Suara Anda telah tersimpan dengan aman</p>
            </div>
        <?php else: ?>
            <div class="voting-status status-not-voted">
                <i class="fas fa-info-circle fa-2x mb-3"></i>
                <p class="mb-0">Silakan pilih 1 Kandidat Kepala Himpunan dan 1 Kandidat Senat</p>
            </div>
        <?php endif; ?>

        <?php if (!$has_voted): ?>
            <form id="votingForm" method="POST" action="confirmation.php">
                <!-- Alert Info -->
                <div class="alert-info-custom mt-4">
                    <h5 style="color: var(--primary-color);">
                        <i class="fas fa-exclamation-triangle"></i> Petunjuk Voting:
                    </h5>
                    <ul class="mb-0" style="color: #1e40af;">
                        <li>Pilih <strong>1 kandidat Kepala Himpunan</strong></li>
                        <li>Pilih <strong>1 kandidat Senat</strong></li>
                        <li>Anda hanya dapat memilih <strong>sekali</strong></li>
                        <li>Pastikan pilihan Anda sudah benar sebelum submit</li>
                    </ul>
                </div>

                <!-- Kandidat Kepala Himpunan -->
                <div class="section-title">
                    <h2><i class="fas fa-crown"></i> Kandidat Kepala Himpunan</h2>
                </div>

                <div class="row">
                    <?php foreach ($kandidat_kahim as $kandidat): ?>
                        <div class="col-md-6">
                            <div class="candidate-card" id="card-kahim-<?php echo $kandidat['id']; ?>">
                                <div class="candidate-header">
                                    <div class="candidate-number"><?php echo $kandidat['nomor_urut']; ?></div>
                                    <img src="assets/images/candidates/<?php echo htmlspecialchars($kandidat['foto']); ?>" 
                                         alt="<?php echo htmlspecialchars($kandidat['nama']); ?>" 
                                         class="candidate-photo"
                                         onerror="this.src='assets/images/candidates/default.jpg'">
                                    <div class="candidate-name"><?php echo htmlspecialchars($kandidat['nama']); ?></div>
                                </div>
                                <div class="candidate-body">
                                    <div class="candidate-section">
                                        <h5><i class="fas fa-bullseye"></i> Visi & Misi</h5>
                                        <p><?php echo htmlspecialchars($kandidat['visi_misi']); ?></p>
                                    </div>
                                    <div class="candidate-section">
                                        <h5><i class="fas fa-project-diagram"></i> Grand Design Organisasi</h5>
                                        <p><?php echo htmlspecialchars($kandidat['grand_design']); ?></p>
                                    </div>
                                    <button type="button" class="btn btn-select btn-select-kahim" 
                                            onclick="selectKandidat('kahim', <?php echo $kandidat['id']; ?>)">
                                        <i class="fas fa-hand-pointer"></i> PILIH KANDIDAT INI
                                    </button>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>

                <!-- Kandidat Senat -->
                <div class="section-title">
                    <h2><i class="fas fa-users"></i> Kandidat Senat</h2>
                </div>

                <div class="row">
                    <?php foreach ($kandidat_senat as $kandidat): ?>
                        <div class="col-md-4">
                            <div class="candidate-card" id="card-senat-<?php echo $kandidat['id']; ?>">
                                <div class="candidate-header">
                                    <div class="candidate-number"><?php echo $kandidat['nomor_urut']; ?></div>
                                    <img src="assets/images/candidates/<?php echo htmlspecialchars($kandidat['foto']); ?>" 
                                         alt="<?php echo htmlspecialchars($kandidat['nama']); ?>" 
                                         class="candidate-photo"
                                         onerror="this.src='assets/images/candidates/default.jpg'">
                                    <div class="candidate-name"><?php echo htmlspecialchars($kandidat['nama']); ?></div>
                                </div>
                                <div class="candidate-body">
                                    <div class="candidate-section">
                                        <h5><i class="fas fa-bullseye"></i> Visi & Misi</h5>
                                        <p><?php echo htmlspecialchars($kandidat['visi_misi']); ?></p>
                                    </div>
                                    <div class="candidate-section">
                                        <h5><i class="fas fa-project-diagram"></i> Grand Design</h5>
                                        <p><?php echo htmlspecialchars($kandidat['grand_design']); ?></p>
                                    </div>
                                    <button type="button" class="btn btn-select btn-select-senat" 
                                            onclick="selectKandidat('senat', <?php echo $kandidat['id']; ?>)">
                                        <i class="fas fa-hand-pointer"></i> PILIH KANDIDAT INI
                                    </button>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>

                <!-- Hidden Inputs -->
                <input type="hidden" name="kahim_id" id="kahim_id" value="">
                <input type="hidden" name="senat_id" id="senat_id" value="">

                <!-- Submit Section -->
                <div class="submit-section">
                    <h3 style="color: var(--primary-color); margin-bottom: 20px;">
                        <i class="fas fa-paper-plane"></i> Submit Pilihan Anda
                    </h3>
                    <p class="text-muted mb-4">
                        Pastikan Anda sudah memilih 1 Kandidat Kepala Himpunan dan 1 Kandidat Senat
                    </p>
                    <div id="selection-summary" class="mb-4"></div>
                    <button type="submit" class="btn btn-submit-vote" id="btnSubmit" disabled>
                        <i class="fas fa-check-double"></i> SUBMIT PILIHAN
                    </button>
                </div>
            </form>
        <?php else: ?>
            <div class="text-center mt-5">
                <img src="assets/images/voted-success.svg" alt="Success" style="max-width: 300px;" 
                     onerror="this.style.display='none'">
                <p class="text-muted mt-3">Anda dapat melihat informasi akun Anda di halaman ini</p>
            </div>
        <?php endif; ?>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let selectedKahim = null;
        let selectedSenat = null;

        function selectKandidat(posisi, id) {
            if (posisi === 'kahim') {
                // Reset previous selection
                document.querySelectorAll('.candidate-card[id^="card-kahim-"]').forEach(card => {
                    card.classList.remove('selected');
                    card.querySelector('.btn-select').classList.remove('selected');
                    card.querySelector('.btn-select').innerHTML = '<i class="fas fa-hand-pointer"></i> PILIH KANDIDAT INI';
                });
                
                // Set new selection
                selectedKahim = id;
                document.getElementById('kahim_id').value = id;
                const card = document.getElementById('card-kahim-' + id);
                card.classList.add('selected');
                const btn = card.querySelector('.btn-select');
                btn.classList.add('selected');
                btn.innerHTML = '<i class="fas fa-check-circle"></i> TERPILIH';
            } else {
                // Reset previous selection
                document.querySelectorAll('.candidate-card[id^="card-senat-"]').forEach(card => {
                    card.classList.remove('selected');
                    card.querySelector('.btn-select').classList.remove('selected');
                    card.querySelector('.btn-select').innerHTML = '<i class="fas fa-hand-pointer"></i> PILIH KANDIDAT INI';
                });
                
                // Set new selection
                selectedSenat = id;
                document.getElementById('senat_id').value = id;
                const card = document.getElementById('card-senat-' + id);
                card.classList.add('selected');
                const btn = card.querySelector('.btn-select');
                btn.classList.add('selected');
                btn.innerHTML = '<i class="fas fa-check-circle"></i> TERPILIH';
            }
            
            updateSummary();
            checkSubmitButton();
        }

        function updateSummary() {
            let summary = '<div class="alert alert-info">';
            summary += '<h5><i class="fas fa-clipboard-check"></i> Pilihan Anda:</h5>';
            summary += '<ul class="mb-0">';
            
            if (selectedKahim) {
                const kahimCard = document.getElementById('card-kahim-' + selectedKahim);
                const kahimName = kahimCard.querySelector('.candidate-name').textContent;
                summary += '<li><strong>Kepala Himpunan:</strong> ' + kahimName + ' <i class="fas fa-check-circle text-success"></i></li>';
            } else {
                summary += '<li><strong>Kepala Himpunan:</strong> <span class="text-danger">Belum dipilih</span></li>';
            }
            
            if (selectedSenat) {
                const senatCard = document.getElementById('card-senat-' + selectedSenat);
                const senatName = senatCard.querySelector('.candidate-name').textContent;
                summary += '<li><strong>Senat:</strong> ' + senatName + ' <i class="fas fa-check-circle text-success"></i></li>';
            } else {
                summary += '<li><strong>Senat:</strong> <span class="text-danger">Belum dipilih</span></li>';
            }
            
            summary += '</ul></div>';
            document.getElementById('selection-summary').innerHTML = summary;
        }

        function checkSubmitButton() {
            const btnSubmit = document.getElementById('btnSubmit');
            if (selectedKahim && selectedSenat) {
                btnSubmit.disabled = false;
            } else {
                btnSubmit.disabled = true;
            }
        }

        // Form validation
        document.getElementById('votingForm')?.addEventListener('submit', function(e) {
            if (!selectedKahim || !selectedSenat) {
                e.preventDefault();
                alert('Mohon pilih 1 Kandidat Kepala Himpunan dan 1 Kandidat Senat!');
                return false;
            }
        });

        // Initial check
        updateSummary();
    </script>
</body>
</html>