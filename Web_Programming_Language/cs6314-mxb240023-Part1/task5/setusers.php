<?php
$conn = new mysqli("localhost", "root", "", "university_courses");
// Check connection
if ($conn->connect_error) die("Connection failed: " . $conn->connect_error);

// Pre-hash passwords
$admin_pass = password_hash("admin1", PASSWORD_DEFAULT);
$user_pass = password_hash("user2", PASSWORD_DEFAULT);

// Insert users
$conn->query("INSERT INTO user (userid, password, user_type, user_status, first_name, last_name, email, create_datetime) 
VALUES ('admin1', '$admin_pass', 'admin', 'active', 'Admin', 'Name1', 'admin1@utdallas.edu', '2025-03-10 15:30:00')");

$conn->query("INSERT INTO user (userid, password, user_type, user_status, first_name, last_name, email, create_datetime) 
VALUES ('user2', '$user_pass', 'user', 'active', 'User', 'Name2', 'user2@utdallas.edu', '2025-03-11 09:10:01')");

echo "Initial users added!";
?>