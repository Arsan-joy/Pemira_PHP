<?php
require_once '../config/database.php';
require_once '../includes/session.php';
require_once '../includes/functions.php';

if (!is_admin_logged_in()) { header('Location: index.php'); exit; }

$stats   = get_voting_statistics();
$results = get_voting_results();

$recent_logs = pdo()->query("SELECT * FROM activity_logs ORDER BY created_at DESC LIMIT 10");
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Pemira HMTA </title>
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
        
        .admin-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .admin-avatar {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, var(--purple-color), #a78bfa);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-left: 5px solid;
            transition: transform 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .stat-card.blue { border-left-color: var(--accent-color); }
        .stat-card.green { border-left-color: var(--success-color); }
        .stat-card.yellow { border-left-color: var(--secondary-color); }
        .stat-card.purple { border-left-color: var(--purple-color); }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            margin-bottom: 15px;
        }
        
        .stat-card.blue .stat-icon { background: linear-gradient(135deg, var(--accent-color), #0284c7); }
        .stat-card.green .stat-icon { background: linear-gradient(135deg, var(--success-color), #059669); }
        .stat-card.yellow .stat-icon { background: linear-gradient(135deg, var(--secondary-color), #f59e0b); }
        .stat-card.purple .stat-icon { background: linear-gradient(135deg, var(--purple-color), #a78bfa); }
        
        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin: 10px 0;
        }
        
        .stat-label {
            color: #64748b;
            font-size: 0.95rem;
            font-weight: 500;
        }
        
        .content-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        
        .content-card h5 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .progress-custom {
            height: 30px;
            border-radius: 10px;
            background: #e2e8f0;
            overflow: hidden;
            margin-bottom: 15px;
        }
        
        .progress-bar-custom {
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            transition: width 0.5s ease;
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
        
        .badge-custom {
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-vote-yea" style="font-size: 50px; color: var(--secondary-color);"></i>
            <h4>PEMIRA HMTA
            <p>Admin Panel</p>
        </div>
        <div class="sidebar-menu">
            <a href="dashboard.php" class="active">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a href="candidates.php">
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
        <!-- Top Bar -->
        <div class="top-bar">
            <h2><i class="fas fa-chart-line"></i> Dashboard</h2>
            <div class="admin-info">
                <div>
                    <div class="fw-bold"><?php echo htmlspecialchars($_SESSION['admin_name']); ?></div>
                    <small class="text-muted">Administrator</small>
                </div>
                <div class="admin-avatar">
                    <i class="fas fa-user-shield"></i>
                </div>
            </div>
        </div>

        <!-- Statistics -->
        <div class="stats-grid">
            <div class="stat-card blue">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-value"><?php echo $stats['total_voters']; ?></div>
                <div class="stat-label">Total Pemilih</div>
            </div>
            
            <div class="stat-card green">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-value"><?php echo $stats['voted']; ?></div>
                <div class="stat-label">Sudah Memilih</div>
            </div>
            
            <div class="stat-card yellow">
                <div class="stat-icon">
                    <i class="fas fa-hourglass-half"></i>
                </div>
                <div class="stat-value"><?php echo $stats['not_voted']; ?></div>
                <div class="stat-label">Belum Memilih</div>
            </div>
            
            <div class="stat-card purple">
                <div class="stat-icon">
                    <i class="fas fa-percentage"></i>
                </div>
                <div class="stat-value"><?php echo number_format($stats['participation'], 1); ?>%</div>
                <div class="stat-label">Partisipasi</div>
            </div>
        </div>

        <!-- Participation Progress -->
        <div class="content-card">
            <h5><i class="fas fa-chart-pie"></i> Tingkat Partisipasi</h5>
            <div class="progress-custom">
                <div class="progress-bar-custom" style="width: <?php echo $stats['participation']; ?>%; background: linear-gradient(90deg, var(--success-color), #059669);">
                    <?php echo number_format($stats['participation'], 1); ?>% (<?php echo $stats['voted']; ?> dari <?php echo $stats['total_voters']; ?> pemilih)
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Quick Results Kahim -->
            <div class="col-md-6">
                <div class="content-card">
                    <h5><i class="fas fa-crown"></i> Perolehan Suara Kepala Himpunan</h5>
                    <?php 
                    $total_kahim_votes = 0;
                    foreach ($results['kahim'] as $candidate) {
                        $total_kahim_votes += $candidate['total_votes'];
                    }
                    
                    foreach ($results['kahim'] as $candidate): 
                        $percentage = $total_kahim_votes > 0 ? ($candidate['total_votes'] / $total_kahim_votes) * 100 : 0;
                    ?>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="fw-bold"><?php echo htmlspecialchars($candidate['nama']); ?></span>
                                <span class="badge bg-primary"><?php echo $candidate['total_votes']; ?> suara</span>
                            </div>
                            <div class="progress-custom" style="height: 25px;">
                                <div class="progress-bar-custom" style="width: <?php echo $percentage; ?>%; background: linear-gradient(90deg, var(--primary-color), var(--accent-color));">
                                    <?php echo number_format($percentage, 1); ?>%
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>

            <!-- Quick Results Senat -->
            <div class="col-md-6">
                <div class="content-card">
                    <h5><i class="fas fa-users"></i> Perolehan Suara Senat (Top 5)</h5>
                    <?php 
                    $total_senat_votes = 0;
                    foreach ($results['senat'] as $candidate) {
                        $total_senat_votes += $candidate['total_votes'];
                    }
                    
                    $count = 0;
                    foreach ($results['senat'] as $candidate): 
                        if ($count >= 5) break;
                        $percentage = $total_senat_votes > 0 ? ($candidate['total_votes'] / $total_senat_votes) * 100 : 0;
                    ?>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="fw-bold"><?php echo htmlspecialchars($candidate['nama']); ?></span>
                                <span class="badge bg-success"><?php echo $candidate['total_votes']; ?> suara</span>
                            </div>
                            <div class="progress-custom" style="height: 25px;">
                                <div class="progress-bar-custom" style="width: <?php echo $percentage; ?>%; background: linear-gradient(90deg, var(--purple-color), #a78bfa);">
                                    <?php echo number_format($percentage, 1); ?>%
                                </div>
                            </div>
                        </div>
                    <?php 
                        $count++;
                    endforeach; 
                    ?>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="content-card">
            <h5><i class="fas fa-history"></i> Aktivitas Terbaru</h5>
            <div class="table-responsive">
                <table class="table table-custom">
                    <thead>
                        <tr>
                            <th>Waktu</th>
                            <th>User Type</th>
                            <th>Username</th>
                            <th>Aktivitas</th>
                            <th>IP Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($log = $recent_logs->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo date('d/m/Y H:i:s', strtotime($log['created_at'])); ?></td>
                                <td>
                                    <?php if ($log['user_type'] == 'admin'): ?>
                                        <span class="badge-custom bg-danger">
                                            <i class="fas fa-user-shield"></i> Admin
                                        </span>
                                    <?php else: ?>
                                        <span class="badge-custom bg-primary">
                                            <i class="fas fa-user"></i> Voter
                                        </span>
                                    <?php endif; ?>
                                </td>
                                <td><?php echo htmlspecialchars($log['username']); ?></td>
                                <td><?php echo htmlspecialchars($log['activity']); ?></td>
                                <td><code><?php echo htmlspecialchars($log['ip_address']); ?></code></td>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto refresh setiap 30 detik
        setTimeout(function() {
            location.reload();
        }, 30000);
    </script>
</body>
</html>