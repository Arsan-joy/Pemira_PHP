<?php
declare(strict_types=1);

/**
 * Koneksi Database (PDO)
 */

define('DB_HOST', 'localhost');
define('DB_USER', 'root');  // Ganti dengan user database
define('DB_PASS', '');  // Ganti dengan password user database
define('DB_NAME', 'pemira_himatepa');

$dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4';

try {
    $pdo = new PDO($dsn, DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ]);
} catch (Throwable $e) {
    http_response_code(500);
    die('Database connection failed.');
}

function pdo(): PDO {
    global $pdo;
    return $pdo;
}

function clean_input(?string $val): string {
    return trim((string)$val);
}

function h(?string $val): string {
    return htmlspecialchars((string)$val, ENT_QUOTES, 'UTF-8');
}

function client_ip(): string {
    return $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
}