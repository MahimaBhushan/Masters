<?php
$conn = new mysqli("localhost", "root", "", "university_courses"); // Adjust as per your database configuration

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Prepare the SQL statement to prevent SQL injection
$stmt = $conn->prepare("INSERT INTO course1 (course_number, course_title, instructor_name, date_time, location) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("sssss", $course_number, $course_title, $instructor_name, $date_time, $location);

// Set parameters from POST data
$course_number = $_POST['course_number'];
$course_title = $_POST['course_title'];
$instructor_name = $_POST['instructor_name'];
$date_time = $_POST['date_time'];
$location = $_POST['location'];

// Execute the prepared statement
$stmt->execute();

echo "New course added successfully";

$stmt->close();
$conn->close();
?>
