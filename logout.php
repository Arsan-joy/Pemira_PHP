<?php
require_once 'includes/session.php';
require_once 'config/database.php';
require_once 'includes/functions.php';

if (is_voter_logged_in()) {
    log_activity('voter', $_SESSION['voter_id'], $_SESSION['voter_username'], 'Logout');
}

logout();
header("Location: index.php");
exit();
?>