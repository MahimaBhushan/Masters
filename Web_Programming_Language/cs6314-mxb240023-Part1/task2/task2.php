<?php
$conn = new mysqli("localhost", "root", "", "university_courses");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Add course
if (isset($_POST['add'])) {
    $stmt = $conn->prepare("INSERT INTO course1 (course_number, course_title, instructor_name, date_time, location) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssss", $_POST['course_number'], $_POST['course_title'], $_POST['instructor_name'], $_POST['date_time'], $_POST['location']);
    $stmt->execute();
}

// Update course
if (isset($_POST['update'])) {
    $stmt = $conn->prepare("UPDATE course1 SET course_title=?, instructor_name=?, date_time=?, location=? WHERE course_number=?");
    $stmt->bind_param("sssss", $_POST['course_title'], $_POST['instructor_name'], $_POST['date_time'], $_POST['location'], $_POST['course_number']);
    $stmt->execute();
}

// Delete course
if (isset($_POST['delete'])) {
    $stmt = $conn->prepare("DELETE FROM course1 WHERE course_number=?");
    $stmt->bind_param("s", $_POST['course_number']);
    $stmt->execute();
}

// Display courses
$result = $conn->query("SELECT * FROM course1");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Task 2 - Courses Management</title>
    <script src="task2.js"></script>
</head>
<body>
    <h2>Courses:</h2>
    <table border="1">
        <tr>
            <th>Course Number</th>
            <th>Title</th>
            <th>Instructor</th>
            <th>Date/Time</th>
            <th>Location</th>
        </tr>
        <?php while($row = $result->fetch_assoc()): ?>
        <tr>
            <td><?= htmlspecialchars($row['course_number']) ?></td>
            <td><?= htmlspecialchars($row['course_title']) ?></td>
            <td><?= htmlspecialchars($row['instructor_name']) ?></td>
            <td><?= htmlspecialchars($row['date_time']) ?></td>
            <td><?= htmlspecialchars($row['location']) ?></td>
        </tr>
        <?php endwhile; ?>
    </table>

    <h2>Add / Update / Delete Course</h2>
    <form method="POST">
        Course Number: <input type="text" name="course_number" required><br>
        Title: <input type="text" name="course_title"><br>
        Instructor: <input type="text" name="instructor_name"><br>
        Date/Time: <input type="text" name="date_time"><br>
        Location: <input type="text" name="location"><br><br>

        <button name="add">Add</button>
        <button name="update">Update</button>
        <button name="delete">Delete</button>
    </form>

    <h2>Test Cases (via JavaScript)</h2>
    <button onclick="addTestCase1()">Add Test Case 1</button>
    <button onclick="addTestCase2()">Add Test Case 2</button>
    <button onclick="addTestCase3()">Add Test Case 3</button>
    <button onclick="updateTestCase1()">Update Test Case 1</button>
    <button onclick="updateTestCase2()">Update Test Case 2</button>
    <button onclick="updateTestCase3()">Update Test Case 3</button>
    <button onclick="deleteTestCase1()">Delete Test Case 1</button>
    <button onclick="deleteTestCase2()">Delete Test Case 2</button>
    <button onclick="deleteTestCase3()">Delete Test Case 3</button>
</body>
</html>

<?php
$conn->close();
?>
