<?php
require_once '../config/database.php';
require_once '../includes/session.php';
require_once '../includes/functions.php';

if (!is_admin_logged_in()) { header('Location: index.php'); exit; }

$filter_user = clean_input($_GET['user'] ?? '');
$filter_type = clean_input($_GET['type'] ?? '');
$from_date   = clean_input($_GET['from'] ?? '');
$to_date     = clean_input($_GET['to'] ?? '');

$where = [];
$params = [];

if ($filter_user !== '') {
    $where[] = "username LIKE :user";
    $params[':user'] = '%' . $filter_user . '%';
}
if ($filter_type !== '' && in_array($filter_type, ['voter','admin'], true)) {
    $where[] = "user_type = :type";
    $params[':type'] = $filter_type;
}
if ($from_date !== '') {
    $where[] = "DATE(created_at) >= :fromd";
    $params[':fromd'] = $from_date;
}
if ($to_date !== '') {
    $where[] = "DATE(created_at) <= :tod";
    $params[':tod'] = $to_date;
}

$sql = "SELECT * FROM activity_logs";
if ($where) $sql .= ' WHERE ' . implode(' AND ', $where);
$sql .= " ORDER BY created_at DESC LIMIT 1000";

// Export CSV
if (isset($_GET['export']) && $_GET['export'] === 'csv') {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename=activity_logs_' . date('Ymd_His') . '.csv');

    $out = fopen('php://output', 'w');
    fprintf($out, chr(0xEF).chr(0xBB).chr(0xBF));
    fputcsv($out, ['Waktu','User Type','User ID','Username','Aktivitas','IP Address']);

    $st = pdo()->prepare($sql);
    $st->execute($params);
    while ($r = $st->fetch()) {
        fputcsv($out, [$r['created_at'],$r['user_type'],$r['user_id'],$r['username'],$r['activity'],$r['ip_address']]);
    }
    fclose($out);
    exit;
}

$st = pdo()->prepare($sql);
$st->execute($params);
$logs = $st->fetchAll();
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Log Aktivitas - Admin Pemira</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-vote-yea" style="font-size: 42px; color: #fbbf24;"></i>
            <h4>PEMIRA HIMATEP</h4>
            <p>Admin Panel</p>
        </div>
        <div class="sidebar-menu">
            <a href="dashboard.php"><i class="fas fa-home"></i> Dashboard</a>
            <a href="candidates.php"><i class="fas fa-users"></i> Kelola Kandidat</a>
            <a href="voters.php"><i class="fas fa-user-check"></i> Kelola Pemilih</a>
            <a href="results.php"><i class="fas fa-chart-bar"></i> Hasil Voting</a>
            <a href="logs.php" class="active"><i class="fas fa-history"></i> Log Aktivitas</a>
            <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <h2><i class="fas fa-history"></i> Log Aktivitas</h2>
            <div>
                <a href="?export=csv&<?php echo http_build_query($_GET); ?>" class="btn btn-sm btn-primary">
                    <i class="fas fa-download"></i> Export CSV
                </a>
            </div>
        </div>

        <div class="content-card">
            <form class="row g-3 mb-4" method="GET" action="logs.php">
                <div class="col-md-3">
                    <input type="text" name="user" class="form-control" placeholder="Cari username..." value="<?php echo htmlspecialchars($filter_user); ?>">
                </div>
                <div class="col-md-2">
                    <select name="type" class="form-select">
                        <option value="">Semua Tipe</option>
                        <option value="voter" <?php if ($filter_type=='voter') echo 'selected'; ?>>Voter</option>
                        <option value="admin" <?php if ($filter_type=='admin') echo 'selected'; ?>>Admin</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <input type="date" name="from" class="form-control" value="<?php echo htmlspecialchars($from_date); ?>">
                </div>
                <div class="col-md-2">
                    <input type="date" name="to" class="form-control" value="<?php echo htmlspecialchars($to_date); ?>">
                </div>
                <div class="col-md-3 text-end">
                    <button type="submit" class="btn btn-success"><i class="fas fa-filter"></i> Filter</button>
                    <a href="logs.php" class="btn btn-secondary"><i class="fas fa-redo"></i> Reset</a>
                </div>
            </form>

            <div class="table-responsive">
                <table class="table table-hover table-custom">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Waktu</th>
                            <th>User Type</th>
                            <th>Username</th>
                            <th>Aktivitas</th>
                            <th>IP Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (count($logs) === 0): ?>
                            <tr><td colspan="6" class="text-center">Tidak ada log yang ditemukan</td></tr>
                        <?php else: foreach ($logs as $i => $log): ?>
                            <tr>
                                <td><?php echo $i + 1; ?></td>
                                <td><?php echo date('d/m/Y H:i:s', strtotime($log['created_at'])); ?></td>
                                <td><?php echo htmlspecialchars($log['user_type']); ?></td>
                                <td><?php echo htmlspecialchars($log['username']); ?></td>
                                <td><?php echo htmlspecialchars($log['activity']); ?></td>
                                <td><code><?php echo htmlspecialchars($log['ip_address']); ?></code></td>
                            </tr>
                        <?php endforeach; endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>