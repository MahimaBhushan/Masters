<?php
session_start();
if (!isset($_SESSION["userid"]) || $_SESSION["user_type"] !== "admin") {
    header("Location: login.php");
    exit;
}

$conn = new mysqli("localhost", "root", "", "university_courses");

$result = $conn->query("SELECT * FROM userlog ORDER BY login_datetime DESC");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login/Logout Logs</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f4f4;
            margin: 0;
        }

        .header {
            background-color: #004225;
            color: white;
            text-align: center;
            padding: 20px;
            position: relative;
        }

        .logout-btn {
            position: absolute;
            right: 20px;
            top: 20px;
            background-color: #b94600;
            color: white;
            padding: 8px 14px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }

        .container {
            width: 90%;
            max-width: 900px;
            margin: 40px auto;
        }

        h2 {
            color: #b94600;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #004225;
            color: white;
        }

        .back {
            text-align: right;
            margin-top: 20px;
        }

        .back a {
            text-decoration: none;
            color: #b94600;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Course Management System - Admin Logs</h1>
    <a href="logout.php" class="logout-btn">Logout</a>
</div>

<div class="container">
    <h2>User Login/Logout Activity</h2>

    <table>
        <tr>
            <th>User ID</th>
            <th>Login Time</th>
            <th>Logout Time</th>
            <th>Session ID</th>
        </tr>

        <?php while ($row = $result->fetch_assoc()): ?>
        <tr>
            <td><?= htmlspecialchars($row['userid']) ?></td>
            <td><?= htmlspecialchars($row['login_datetime']) ?></td>
            <td><?= $row['logout_datetime'] ?? '<i>Still logged in</i>' ?></td>
            <td><?= htmlspecialchars($row['session_id']) ?></td>
        </tr>
        <?php endwhile; ?>
    </table>

    <div class="back">
        <a href="admin_home.php">← Back to Admin Home</a>
    </div>
</div>

</body>
</html>
