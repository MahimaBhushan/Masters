<?php
$conn = new mysqli("localhost", "root", "", "university_courses");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$stmt = $conn->prepare("INSERT INTO course1 (course_number, course_title, instructor_name, date_time, location) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("sssss", $course_number, $course_title, $instructor_name, $date_time, $location);

$course_number = $_POST['course_number'];
$course_title = $_POST['course_title'];
$instructor_name = $_POST['instructor_name'];
$date_time = $_POST['date_time'];
$location = $_POST['location'];

$stmt->execute();

header("Location: task3.php"); // redirect after success

$stmt->close();
$conn->close();
?>
