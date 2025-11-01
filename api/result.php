<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../includes/session.php';
require_once __DIR__ . '/../includes/functions.php';

header('Content-Type: application/json; charset=utf-8');

if (!is_admin_logged_in()) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']); exit;
}

$results = get_voting_results();
$stats   = get_voting_statistics();

$kahim = array_map(function($c){
    return [
        'id'          => (int)$c['id'],
        'nama'        => $c['nama'],
        'nomor_urut'  => (int)$c['nomor_urut'],
        'foto'        => $c['foto'],
        'total_votes' => (int)$c['total_votes'],
    ];
}, $results['kahim']);

$senat = array_map(function($c){
    return [
        'id'          => (int)$c['id'],
        'nama'        => $c['nama'],
        'nomor_urut'  => (int)$c['nomor_urut'],
        'foto'        => $c['foto'],
        'total_votes' => (int)$c['total_votes'],
    ];
}, $results['senat']);

echo json_encode([
    'kahim' => $kahim,
    'senat' => $senat,
    'stats' => [
        'total_voters'  => (int)$stats['total_voters'],
        'voted'         => (int)$stats['voted'],
        'not_voted'     => (int)$stats['not_voted'],
        'participation' => (float)$stats['participation'],
        'total_votes'   => (int)$stats['total_votes'],
    ],
    'timestamp' => date('c')
], JSON_UNESCAPED_UNICODE);