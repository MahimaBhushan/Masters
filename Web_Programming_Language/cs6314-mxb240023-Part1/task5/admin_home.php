<?php
session_start();
if (!isset($_SESSION["userid"]) || $_SESSION["user_type"] !== "admin") {
    header("Location: login.php");
    exit;
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Home</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f8f9fa;
        }

        .header {
            background-color: #004225;
            color: white;
            padding: 30px;
            text-align: center;
        }

        .container {
            max-width: 600px;
            margin: 60px auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        h2 {
            color: #b94600;
            margin-bottom: 30px;
        }

        .btn {
            display: block;
            margin: 15px auto;
            padding: 14px 25px;
            width: 80%;
            font-size: 16px;
            background-color: #b94600;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #933600;
        }

        .logout {
            margin-top: 30px;
        }

        .logout a {
            text-decoration: none;
            color: #004225;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Course Management System</h1>
</div>

<div class="container">
    <h2>Welcome, Admin</h2>

    <a class="btn" href="admin_dashboard.php">➤ Manage Users</a>
    <a class="btn" href="view_logs.php">📄 View Login/Logout Logs</a>

    <div class="logout">
        <a href="logout.php">🚪 Logout</a>
    </div>
</div>

</body>
</html>