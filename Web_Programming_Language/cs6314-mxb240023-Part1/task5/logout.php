<?php
session_start();
$conn = new mysqli("localhost", "root", "", "university_courses");

// Get current user and session info
$userid = $_SESSION["userid"] ?? null;
$session_id = $_SESSION["session_id"] ?? null;

// If user is logged in, update the logout time
if ($userid && $session_id) {
    $stmt = $conn->prepare("UPDATE userlog SET logout_datetime = NOW() WHERE userid = ? AND session_id = ?");
    $stmt->bind_param("ss", $userid, $session_id);
    $stmt->execute();
}

// Clear session variables and destroy the session
session_unset();
session_destroy();

// Redirect to login page with logout success message
header("Location: login.php?logout=success");
exit;
?>
