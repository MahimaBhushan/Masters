<?php
header("Content-Type: application/json");
$conn = new mysqli("localhost", "root", "", "university_courses");

if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed."]);
    exit;
}

// Retrieve and validate POST data
$id = isset($_POST["id"]) ? intval($_POST["id"]) : 0;
$course_number = $_POST["course_number"] ?? '';
$course_title = $_POST["course_title"] ?? '';
$instructor = $_POST["instructor_name"] ?? '';
$date_time = $_POST["date_time"] ?? '';
$location = $_POST["location"] ?? '';

if ($id && $course_number && $course_title && $instructor && $date_time && $location) {
    $stmt = $conn->prepare("UPDATE course1 SET course_number=?, course_title=?, instructor_name=?, date_time=?, location=? WHERE id=?");
    $stmt->bind_param("sssssi", $course_number, $course_title, $instructor, $date_time, $location, $id);
    $stmt->execute();

    if ($stmt->affected_rows > 0) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false, "message" => "No changes made or invalid course ID."]);
    }

    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Incomplete or invalid data."]);
}

$conn->close();
?>
