<?php
session_start();
$conn = new mysqli("localhost", "root", "", "university_courses");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (!isset($_SESSION["login_attempts"])) {
    $_SESSION["login_attempts"] = [];
}

$errorMsg = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $userid = $_POST["userid"];
    $password = $_POST["password"];

    $stmt = $conn->prepare("SELECT * FROM user WHERE userid = ?");
    $stmt->bind_param("s", $userid);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();

        if ($user["user_status"] !== 'active') {
            $errorMsg = "Your account is currently " . $user["user_status"] . ". Please contact admin.";
        } else {
            if (password_verify($password, $user["password"])) {
                $_SESSION["login_attempts"][$userid] = 0;
                $_SESSION["userid"] = $userid;
                $_SESSION["user_type"] = $user["user_type"];
                $_SESSION["session_id"] = session_id();

                $stmtLog = $conn->prepare("INSERT INTO userlog (userid, session_id) VALUES (?, ?)");
                $stmtLog->bind_param("ss", $userid, $_SESSION["session_id"]);
                $stmtLog->execute();

                if ($user["user_type"] == "admin") {
                    header("Location: admin_home.php");
                } else {
                    header("Location: task5_3/task3.php");
                }
                exit;

            } else {
                $_SESSION["login_attempts"][$userid] = ($_SESSION["login_attempts"][$userid] ?? 0) + 1;

                if ($_SESSION["login_attempts"][$userid] >= 3) {
                    $conn->query("UPDATE user SET user_status = 'revoked' WHERE userid = '$userid'");
                    $errorMsg = "Account revoked due to too many failed attempts.";
                } else {
                    $errorMsg = "Incorrect password. Attempt " . $_SESSION["login_attempts"][$userid] . " of 3.";
                }
            }
        }
    } else {
        $errorMsg = "User ID not found.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Course Management System</title>
    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", sans-serif;
            background-color: #f7f7f7;
        }

        .header {
            background-color: #154734; /* UTD Green */
            padding: 30px 0;
            text-align: center;
        }

        .utd-logo {
            width: 120px; /* increased width */
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }


        .header img {
            width: 150px;
        }

        .header h1 {
            margin: 10px 0 0 0;
            font-size: 24px;
            color:rgb(255, 255, 255);
        }

        .login-container {
            margin: 50px auto;
            width: 400px;
            background-color: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        .login-container h2 {
            text-align: center;
            color: #004225;
            margin-bottom: 25px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #b94600;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #933600;
        }

        .error {
            color: #c0392b;
            background: #fcecec;
            padding: 10px;
            border: 1px solid #e74c3c;
            border-radius: 4px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="header">
    <img src="images/utd-logo.png" alt="UT Dallas Logo" height="140">
    <h1>Course Management System</h1>
</div>

<div class="login-container">
    <h2>Login</h2>

    <?php if ($errorMsg): ?>
        <div class="error"><?= $errorMsg ?></div>
    <?php endif; ?>

    <form method="POST">
        <label for="userid">User ID:</label>
        <input type="text" name="userid" required>

        <label for="password">Password:</label>
        <input type="password" name="password" required>

        <button type="submit">Login</button>
    </form>
</div>


</body>
</html>
