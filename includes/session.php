<?php
/**
 * Session Management (tetap, tidak bergantung DB layer)
 */

ini_set('session.cookie_httponly', '1');
ini_set('session.use_only_cookies', '1');
ini_set('session.cookie_secure', '0'); // ganti '1' jika HTTPS

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['initiated'])) {
    session_regenerate_id(true);
    $_SESSION['initiated'] = true;
}

function is_voter_logged_in(): bool {
    return !empty($_SESSION['voter_logged_in']);
}

function is_admin_logged_in(): bool {
    return !empty($_SESSION['admin_logged_in']);
}

function logout(): void {
    $_SESSION = [];
    if (ini_get("session.use_cookies")) {
        $p = session_get_cookie_params();
        setcookie(session_name(), '', time() - 42000, $p['path'], $p['domain'], $p['secure'], $p['httponly']);
    }
    session_destroy();
}

function prevent_session_fixation(): void {
    if (!isset($_SESSION['created'])) {
        $_SESSION['created'] = time();
    } elseif (time() - $_SESSION['created'] > 1800) {
        session_regenerate_id(true);
        $_SESSION['created'] = time();
    }
}
prevent_session_fixation();