<?php
/**
 * Helper Functions (versi PDO)
 */

function log_activity(string $user_type, int $user_id, string $username, string $activity): void {
    $sql = "INSERT INTO activity_logs (user_type, user_id, username, activity, ip_address)
            VALUES (:user_type, :user_id, :username, :activity, :ip)";
    pdo()->prepare($sql)->execute([
        ':user_type' => $user_type,
        ':user_id'   => $user_id,
        ':username'  => $username,
        ':activity'  => $activity,
        ':ip'        => client_ip(),
    ]);
}

function get_candidates_by_position(string $posisi): array {
    $stmt = pdo()->prepare("SELECT * FROM candidates WHERE posisi = :posisi ORDER BY nomor_urut ASC");
    $stmt->execute([':posisi' => $posisi]);
    return $stmt->fetchAll();
}

function has_user_voted(int $voter_id): bool {
    $stmt = pdo()->prepare("SELECT has_voted FROM voters WHERE id = :id");
    $stmt->execute([':id' => $voter_id]);
    $val = $stmt->fetchColumn();
    return (int)$val === 1;
}

function get_voting_results(): array {
    $results = ['kahim' => [], 'senat' => []];

    $sql = "SELECT c.id, c.nama, c.foto, c.nomor_urut, COUNT(v.id) as total_votes
            FROM candidates c
            LEFT JOIN votes v ON c.id = v.candidate_id
            WHERE c.posisi = :posisi
            GROUP BY c.id
            ORDER BY c.nomor_urut ASC";

    $st = pdo()->prepare($sql);
    $st->execute([':posisi' => 'kahim']);
    $results['kahim'] = $st->fetchAll();

    $st->execute([':posisi' => 'senat']);
    $results['senat'] = $st->fetchAll();

    return $results;
}

function get_voting_statistics(): array {
    $stats = [];

    $stats['total_voters'] = (int) pdo()->query("SELECT COUNT(*) FROM voters")->fetchColumn();
    $stats['voted']        = (int) pdo()->query("SELECT COUNT(*) FROM voters WHERE has_voted = 1")->fetchColumn();
    $stats['not_voted']    = $stats['total_voters'] - $stats['voted'];
    $stats['participation']= $stats['total_voters'] > 0 ? ($stats['voted'] / $stats['total_voters']) * 100 : 0.0;
    $stats['total_candidates'] = (int) pdo()->query("SELECT COUNT(*) FROM candidates")->fetchColumn();
    $stats['total_votes']  = (int) pdo()->query("SELECT COUNT(*) FROM votes")->fetchColumn();

    return $stats;
}

function format_tanggal(string $date): string {
    $bulan = [
        1 => 'Januari','Februari','Maret','April','Mei','Juni',
             'Juli','Agustus','September','Oktober','November','Desember'
    ];
    $ts = strtotime($date);
    if (!$ts) return $date;
    $m = (int)date('n', $ts);
    return date('j', $ts) . ' ' . $bulan[$m] . ' ' . date('Y', $ts);
}

function generate_csrf_token(): string {
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function validate_csrf_token(?string $token): bool {
    return isset($_SESSION['csrf_token']) && is_string($token) && hash_equals($_SESSION['csrf_token'], $token);
}