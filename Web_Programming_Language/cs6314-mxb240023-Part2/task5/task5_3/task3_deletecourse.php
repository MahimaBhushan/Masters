<?php
header("Content-Type: application/json");
$conn = new mysqli("localhost", "root", "", "university_courses");

if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed."]);
    exit;
}

$id = isset($_POST["id"]) ? intval($_POST["id"]) : 0;

if ($id) {
    $stmt = $conn->prepare("DELETE FROM course1 WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();

    if ($stmt->affected_rows > 0) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false, "message" => "Invalid course ID or already deleted."]);
    }

    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Invalid request."]);
}

$conn->close();
?>
