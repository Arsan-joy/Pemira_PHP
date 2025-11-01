<?php
/**
 * Admin Logout
 * Sistem Pemira HIMATEP
 */

require_once '../includes/session.php';
require_once '../config/database.php';
require_once '../includes/functions.php';

// Log aktivitas logout jika admin sudah login
if (is_admin_logged_in()) {
    log_activity('admin', $_SESSION['admin_id'], $_SESSION['admin_username'], 'Logout dari admin panel');
}

// Hapus session dan logout
logout();

// Redirect ke halaman login admin
header("Location: index.php");
exit();
?>