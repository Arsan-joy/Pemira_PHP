<?php
declare(strict_types=1);

/**
 * Koneksi Database (PDO)
 * - Menggunakan prepared statements (ATTR_EMULATE_PREPARES = false)
 * - Error mode EXCEPTION
 * - Default fetch mode ASSOC
 */

define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
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

/**
 * Helper untuk dapatkan PDO instance
 */
function pdo(): PDO {
    global $pdo;
    return $pdo;
}

/**
 * Sanitasi input dasar (non-SQL)
 * Gunakan prepared statements untuk SQL; fungsi ini hanya trimming/filter ringan.
 */
function clean_input(?string $val): string {
    return trim((string)$val);
}

/**
 * Escape untuk output HTML
 */
function h(?string $val): string {
    return htmlspecialchars((string)$val, ENT_QUOTES, 'UTF-8');
}

/**
 * Dapatkan IP Address
 */
function client_ip(): string {
    return $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
}