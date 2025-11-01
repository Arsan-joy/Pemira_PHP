<?php
/**
 * Admin - Hasil Voting (admin/results.php) - versi realtime via API
 *
 * Halaman ini tetap menyediakan export CSV via ?export=csv (server-side)
 * dan menggunakan endpoint api/results.php untuk polling data realtime.
 */

require_once '../config/database.php';
require_once '../includes/session.php';
require_once '../includes/functions.php';

// Cek login admin
if (!is_admin_logged_in()) {
    header("Location: index.php");
    exit();
}

// Ambil hasil awal untuk export CSV server-side
$results = get_voting_results();
$stats = get_voting_statistics();

// Export CSV (sama seperti versi sebelumnya)
if (isset($_GET['export']) && $_GET['export'] === 'csv') {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename=hasil_pemira_' . date('Y-m-d_His') . '.csv');

    $output = fopen('php://output', 'w');
    fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF)); // UTF-8 BOM

    fputcsv($output, ['HASIL PEMIRA HIMATEP - ' . date('d/m/Y H:i:s')]);
    fputcsv($output, []);

    // Kahim
    fputcsv($output, ['KEPALA HIMPUNAN']);
    fputcsv($output, ['No', 'Nama Kandidat', 'Nomor Urut', 'Total Suara', 'Persentase']);

    $total_kahim = 0;
    foreach ($results['kahim'] as $c) {
        $total_kahim += $c['total_votes'];
    }
    $no = 1;
    foreach ($results['kahim'] as $candidate) {
        $percentage = $total_kahim > 0 ? ($candidate['total_votes'] / $total_kahim) * 100 : 0;
        fputcsv($output, [
            $no++,
            $candidate['nama'],
            $candidate['nomor_urut'],
            $candidate['total_votes'],
            number_format($percentage, 2) . '%'
        ]);
    }

    fputcsv($output, []);
    // Senat
    fputcsv($output, ['SENAT']);
    fputcsv($output, ['No', 'Nama Kandidat', 'Nomor Urut', 'Total Suara', 'Persentase']);

    $total_senat = 0;
    foreach ($results['senat'] as $c) {
        $total_senat += $c['total_votes'];
    }
    $no = 1;
    foreach ($results['senat'] as $candidate) {
        $percentage = $total_senat > 0 ? ($candidate['total_votes'] / $total_senat) * 100 : 0;
        fputcsv($output, [
            $no++,
            $candidate['nama'],
            $candidate['nomor_urut'],
            $candidate['total_votes'],
            number_format($percentage, 2) . '%'
        ]);
    }

    fputcsv($output, []);
    fputcsv($output, ['STATISTIK']);
    fputcsv($output, ['Total Pemilih', $stats['total_voters']]);
    fputcsv($output, ['Sudah Memilih', $stats['voted']]);
    fputcsv($output, ['Belum Memilih', $stats['not_voted']]);
    fputcsv($output, ['Partisipasi', number_format($stats['participation'], 2) . '%']);

    fclose($output);
    exit();
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Hasil Voting - Admin Pemira (Realtime)</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <i class="fas fa-vote-yea" style="font-size: 42px; color: #fbbf24;"></i>
            <h4>PEMIRA HMTA</h4>
            <p>Admin Panel</p>
        </div>
        <div class="sidebar-menu">
            <a href="dashboard.php"><i class="fas fa-home"></i> Dashboard</a>
            <a href="candidates.php"><i class="fas fa-users"></i> Kelola Kandidat</a>
            <a href="voters.php"><i class="fas fa-user-check"></i> Kelola Pemilih</a>
            <a href="results.php" class="active"><i class="fas fa-chart-bar"></i> Hasil Voting</a>
            <a href="logs.php"><i class="fas fa-history"></i> Log Aktivitas</a>
            <a href="logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <h2><i class="fas fa-chart-bar"></i> Hasil Voting Real-time</h2>
            <div class="d-flex gap-2">
                <a href="results.php?export=csv" class="btn btn-sm btn-primary">
                    <i class="fas fa-download"></i> Export CSV
                </a>
                <button id="btnRefresh" class="btn btn-sm btn-secondary">
                    <i class="fas fa-refresh"></i> Refresh
                </button>
            </div>
        </div>

        <div class="content-card">
            <h5><i class="fas fa-chart-pie"></i> Statistik Partisipasi</h5>
            <div class="row text-center g-3" id="statsArea">
                <!-- Area statistik akan diisi via JS dari API -->
                <div class="col-md-3">
                    <div class="p-3 bg-white rounded shadow-sm">
                        <div class="text-muted">Total Pemilih</div>
                        <div class="fs-4 fw-bold" id="stat_total_voters"><?php echo $stats['total_voters']; ?></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="p-3 bg-white rounded shadow-sm">
                        <div class="text-muted">Sudah Memilih</div>
                        <div class="fs-4 fw-bold text-success" id="stat_voted"><?php echo $stats['voted']; ?></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="p-3 bg-white rounded shadow-sm">
                        <div class="text-muted">Belum Memilih</div>
                        <div class="fs-4 fw-bold text-warning" id="stat_not_voted"><?php echo $stats['not_voted']; ?></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="p-3 bg-white rounded shadow-sm">
                        <div class="text-muted">Partisipasi</div>
                        <div class="fs-4 fw-bold" id="stat_participation"><?php echo number_format($stats['participation'], 1); ?>%</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts -->
        <div class="row">
            <div class="col-md-6">
                <div class="content-card">
                    <h5><i class="fas fa-crown"></i> Kepala Himpunan</h5>
                    <canvas id="chartKahim" height="220"></canvas>
                </div>
            </div>

            <div class="col-md-6">
                <div class="content-card">
                    <h5><i class="fas fa-users"></i> Senat</h5>
                    <canvas id="chartSenat" height="220"></canvas>
                </div>
            </div>
        </div>

        <!-- Detail Table -->
        <div class="content-card mt-3">
            <h5><i class="fas fa-list"></i> Daftar Perolehan Suara</h5>

            <div class="table-responsive">
                <table class="table table-hover table-custom" id="resultsTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Nama Kandidat</th>
                            <th>Posisi</th>
                            <th>Nomor Urut</th>
                            <th>Total Suara</th>
                            <th>Persentase</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Isi baris tabel akan di-update via JS -->
                        <?php
                        // Tampilkan initial snapshot (server-side) for first render
                        $i = 1;
                        foreach ($results['kahim'] as $c):
                            $total_kahim = 0;
                            foreach ($results['kahim'] as $x) $total_kahim += $x['total_votes'];
                            $pct = $total_kahim > 0 ? ($c['total_votes'] / $total_kahim) * 100 : 0;
                        ?>
                            <tr>
                                <td><?php echo $i++; ?></td>
                                <td><?php echo htmlspecialchars($c['nama']); ?></td>
                                <td>Kahim</td>
                                <td><?php echo $c['nomor_urut']; ?></td>
                                <td class="cell-votes"><?php echo $c['total_votes']; ?></td>
                                <td class="cell-pct"><?php echo number_format($pct, 2); ?>%</td>
                            </tr>
                        <?php endforeach; ?>

                        <?php
                        foreach ($results['senat'] as $c):
                            $total_senat = 0;
                            foreach ($results['senat'] as $x) $total_senat += $x['total_votes'];
                            $pct = $total_senat > 0 ? ($c['total_votes'] / $total_senat) * 100 : 0;
                        ?>
                            <tr>
                                <td><?php echo $i++; ?></td>
                                <td><?php echo htmlspecialchars($c['nama']); ?></td>
                                <td>Senat</td>
                                <td><?php echo $c['nomor_urut']; ?></td>
                                <td class="cell-votes"><?php echo $c['total_votes']; ?></td>
                                <td class="cell-pct"><?php echo number_format($pct, 2); ?>%</td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script src="../assets/js/chart-updates.js"></script>
    <script>
    // Client-side: polling API and updating charts & table
    const API_URL = '../api/results.php';
    let chartKahim = null;
    let chartSenat = null;

    function generateColors(n) {
        const palette = [
            '#1f77b4','#ff7f0e','#2ca02c','#d62728','#9467bd','#8c564b',
            '#e377c2','#7f7f7f','#bcbd22','#17becf'
        ];
        const colors = [];
        for (let i = 0; i < n; i++) colors.push(palette[i % palette.length]);
        return colors;
    }

    function createBarChart(ctx, labels, data, colors) {
        return new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Jumlah Suara',
                    data: data,
                    backgroundColor: colors,
                    borderColor: colors,
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.parsed.y + ' suara';
                            }
                        }
                    }
                },
                scales: {
                    x: { ticks: { maxRotation: 45, minRotation: 0 } },
                    y: { beginAtZero: true, precision: 0 }
                }
            }
        });
    }

    async function fetchResults() {
        try {
            const res = await fetch(API_URL, { credentials: 'same-origin' });
            if (!res.ok) {
                if (res.status === 401) {
                    console.warn('Session admin invalid. Silakan login kembali.');
                }
                throw new Error('Network response not ok');
            }
            return await res.json();
        } catch (err) {
            console.error('fetchResults error:', err);
            return null;
        }
    }

    function updateStats(stats) {
        document.getElementById('stat_total_voters').textContent = stats.total_voters;
        document.getElementById('stat_voted').textContent = stats.voted;
        document.getElementById('stat_not_voted').textContent = stats.not_voted;
        document.getElementById('stat_participation').textContent = parseFloat(stats.participation).toFixed(1) + '%';
    }

    function updateTable(kahim, senat) {
        const tbody = document.querySelector('#resultsTable tbody');
        tbody.innerHTML = '';
        let idx = 1;
        // Kahim
        const totalKahim = kahim.reduce((s, c) => s + c.total_votes, 0);
        kahim.forEach(c => {
            const pct = totalKahim > 0 ? (c.total_votes / totalKahim) * 100 : 0;
            const tr = document.createElement('tr');
            tr.innerHTML = `<td>${idx++}</td>
                            <td>${escapeHtml(c.nama)}</td>
                            <td>Kahim</td>
                            <td>${c.nomor_urut}</td>
                            <td class="cell-votes">${c.total_votes}</td>
                            <td class="cell-pct">${pct.toFixed(2)}%</td>`;
            tbody.appendChild(tr);
        });
        // Senat
        const totalSenat = senat.reduce((s, c) => s + c.total_votes, 0);
        senat.forEach(c => {
            const pct = totalSenat > 0 ? (c.total_votes / totalSenat) * 100 : 0;
            const tr = document.createElement('tr');
            tr.innerHTML = `<td>${idx++}</td>
                            <td>${escapeHtml(c.nama)}</td>
                            <td>Senat</td>
                            <td>${c.nomor_urut}</td>
                            <td class="cell-votes">${c.total_votes}</td>
                            <td class="cell-pct">${pct.toFixed(2)}%</td>`;
            tbody.appendChild(tr);
        });
    }

    function escapeHtml(text) {
        if (!text) return '';
        return text.replace(/[&<>"'`=\/]/g, function (s) {
            return ({
                '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;',
                "'": '&#39;', '/': '&#x2F;', '`': '&#x60;', '=': '&#x3D;'
            })[s];
        });
    }

    async function refreshAll() {
        const data = await fetchResults();
        if (!data) return;
        // Update stats
        updateStats(data.stats);

        // Update charts
        const kahimLabels = data.kahim.map(c => `${c.nama} (No.${c.nomor_urut})`);
        const kahimData = data.kahim.map(c => c.total_votes);
        const senatLabels = data.senat.map(c => `${c.nama} (No.${c.nomor_urut})`);
        const senatData = data.senat.map(c => c.total_votes);

        const kahimColors = generateColors(kahimData.length);
        const senatColors = generateColors(senatData.length);

        if (!chartKahim) {
            chartKahim = createBarChart(document.getElementById('chartKahim').getContext('2d'), kahimLabels, kahimData, kahimColors);
        } else {
            chartKahim.data.labels = kahimLabels;
            chartKahim.data.datasets[0].data = kahimData;
            chartKahim.data.datasets[0].backgroundColor = kahimColors;
            chartKahim.update();
        }

        if (!chartSenat) {
            chartSenat = createBarChart(document.getElementById('chartSenat').getContext('2d'), senatLabels, senatData, senatColors);
        } else {
            chartSenat.data.labels = senatLabels;
            chartSenat.data.datasets[0].data = senatData;
            chartSenat.data.datasets[0].backgroundColor = senatColors;
            chartSenat.update();
        }

        // Update table
        updateTable(data.kahim, data.senat);
    }

    document.addEventListener('DOMContentLoaded', function() {
        // Initial load
        refreshAll();

        // Polling interval (10s)
        const POLL_INTERVAL = 10000;
        setInterval(refreshAll, POLL_INTERVAL);

        // Manual refresh button
        document.getElementById('btnRefresh').addEventListener('click', function() {
            refreshAll();
        });
    });
    </script>

    <script src="../assets/js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>