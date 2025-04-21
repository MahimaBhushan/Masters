<?php
session_start();
if (!isset($_SESSION["userid"]) || $_SESSION["user_type"] !== "admin") {
    header("Location: login.php");
    exit;
}

$conn = new mysqli("localhost", "root", "", "university_courses");

// Add / Update / Delete user logic
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $userid = $_POST["userid"];
    $password = !empty($_POST["password"]) ? password_hash($_POST["password"], PASSWORD_DEFAULT) : null;
    $user_type = $_POST["user_type"];
    $user_status = $_POST["user_status"];
    $fname = $_POST["first_name"];
    $lname = $_POST["last_name"];
    $email = $_POST["email"];

    if (isset($_POST["add"])) {
        $stmt = $conn->prepare("INSERT INTO user (userid, password, user_type, user_status, first_name, last_name, email) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssss", $userid, $password, $user_type, $user_status, $fname, $lname, $email);
        $stmt->execute();
    }

    if (isset($_POST["update"])) {
        if ($password) {
            $stmt = $conn->prepare("UPDATE user SET password=?, user_type=?, user_status=?, first_name=?, last_name=?, email=? WHERE userid=?");
            $stmt->bind_param("sssssss", $password, $user_type, $user_status, $fname, $lname, $email, $userid);
        } else {
            $stmt = $conn->prepare("UPDATE user SET user_type=?, user_status=?, first_name=?, last_name=?, email=? WHERE userid=?");
            $stmt->bind_param("ssssss", $user_type, $user_status, $fname, $lname, $email, $userid);
        }
        $stmt->execute();
    }

    if (isset($_POST["delete"])) {
        $stmt = $conn->prepare("DELETE FROM user WHERE userid = ?");
        $stmt->bind_param("s", $userid);
        $stmt->execute();
    }
}

$result = $conn->query("SELECT * FROM user");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f5f5f5;
            margin: 0;
        }

        .header {
            background-color: #004225;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .container {
            margin: 40px auto;
            width: 90%;
            max-width: 900px;
        }

        h2 {
            color: #b94600;
            text-align: center;
        }

        form {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        input, select, button {
            width: calc(100% - 20px);
            margin: 10px;
            padding: 10px;
            font-size: 14px;
        }

        button {
            background-color: #b94600;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: #933600;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #004225;
            color: white;
        }

        .logout {
            text-align: right;
            margin: 20px 0;
        }

        .logout a {
            color: #b94600;
            text-decoration: none;
            font-weight: bold;
        }

    </style>
</head>
<body>

<div class="header">
    <h1>Admin Panel - Manage Users</h1>
</div>

<div class="container">
    <form method="POST">
        <h2>Add / Update / Delete User</h2>
        <input type="text" name="userid" placeholder="User ID" required>
        <input type="password" name="password" placeholder="Password (leave blank to keep existing)">
        <input type="text" name="first_name" placeholder="First Name">
        <input type="text" name="last_name" placeholder="Last Name">
        <input type="email" name="email" placeholder="Email">
        <select name="user_type">
            <option value="user">User</option>
            <option value="admin">Admin</option>
        </select>
        <select name="user_status">
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
            <option value="revoked">Revoked</option>
            <option value="deleted">Deleted</option>
        </select>
        <div>
            <button name="add">Add User</button>
            <button name="update">Update User</button>
            <button name="delete">Delete User</button>
        </div>
    </form>

    <h2>All Users</h2>
    <table>
        <tr>
            <th>User ID</th>
            <th>Name</th>
            <th>User Type</th>
            <th>Status</th>
            <th>Email</th>
        </tr>
        <?php while($row = $result->fetch_assoc()): ?>
        <tr>
            <td><?= htmlspecialchars($row['userid']) ?></td>
            <td><?= htmlspecialchars($row['first_name'] . ' ' . $row['last_name']) ?></td>
            <td><?= htmlspecialchars($row['user_type']) ?></td>
            <td><?= htmlspecialchars($row['user_status']) ?></td>
            <td><?= htmlspecialchars($row['email']) ?></td>
        </tr>
        <?php endwhile; ?>
    </table>

    <div class="logout">
        <a href="logout.php">Logout</a>
    </div>
</div>

</body>
</html>
