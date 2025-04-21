<?php
session_start();
if (!isset($_SESSION["userid"])) {
    header("Location: login.php");
    exit;
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Course Management - UT Dallas</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="task3.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<!-- Header with Logout -->
<header class="utd-header d-flex justify-content-between align-items-center px-4 py-3">
    <div class="text-left">
        <img src="images/utd-logo.png" alt="UT Dallas Logo" height="100">
    </div>
    <h2 class="text-white text-center flex-grow-1 m-0">Course Management System</h2>
    <div class="text-right">
        <a href="../logout.php" class="btn btn-danger btn-sm">Logout</a>
    </div>
</header>

<!-- Navigation -->
<nav class="navbar navbar-expand-md navbar-dark bg-utd-green">
    <a class="navbar-brand" href="#">UTD CMS</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbar">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Courses</a></li>
            <li class="nav-item"><a class="nav-link" href="#addCourseModal" data-toggle="modal">Add Course</a></li>
        </ul>
    </div>
</nav>

<!-- Main Content -->
<main class="container my-4">
    <input type="text" id="courseSearch" class="form-control" placeholder="Search courses...">

    <div id="coursesAccordion" class="mt-3">
        <?php
        $conn = new mysqli("localhost", "root", "", "university_courses");
        $result = $conn->query("SELECT * FROM course1");
        while($row = $result->fetch_assoc()):
        ?>
        <div class="card mb-1">
            <div class="card-header bg-utd-orange d-flex justify-content-between align-items-center">
                <a class="card-link text-white" data-toggle="collapse" href="#course<?= preg_replace('/[^a-zA-Z0-9]/', '', $row['course_number']) ?>">
                    <?= htmlspecialchars($row['course_number']) ?> - <?= htmlspecialchars($row['course_title']) ?>
                </a>
                <div>
                    <!-- Update Button -->
                    <button class="btn btn-success btn-sm"
                        data-toggle="modal"
                        data-target="#updateCourseModal"
                        data-id="<?= $row['id'] ?>"
                        data-course_number="<?= htmlspecialchars($row['course_number']) ?>"
                        data-course_title="<?= htmlspecialchars($row['course_title']) ?>"
                        data-instructor="<?= htmlspecialchars($row['instructor_name']) ?>"
                        data-time="<?= htmlspecialchars($row['date_time']) ?>"
                        data-location="<?= htmlspecialchars($row['location']) ?>">
                        ✏️
                    </button>

                    <!-- Delete Button (AJAX) -->
                    <form class="delete-form" method="POST" style="display:inline;">
                        <input type="hidden" name="id" value="<?= $row['id'] ?>">
                        <button type="submit" class="btn btn-danger btn-sm">🗑️</button>
                    </form>
                </div>
            </div>
            <div id="course<?= preg_replace('/[^a-zA-Z0-9]/', '', $row['course_number']) ?>" class="collapse">
                <div class="card-body">
                    <strong>Instructor:</strong> <?= htmlspecialchars($row['instructor_name']) ?><br>
                    <strong>Time:</strong> <?= htmlspecialchars($row['date_time']) ?><br>
                    <strong>Location:</strong> <?= htmlspecialchars($row['location']) ?>
                </div>
            </div>
        </div>
        <?php endwhile; $conn->close(); ?>
    </div>
</main>

<!-- Add Course Modal -->
<div class="modal fade" id="addCourseModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-utd-orange text-white">
                <h4 class="modal-title">Add New Course</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form id="addCourseForm" method="POST">
                    <input type="text" name="course_number" placeholder="Course Number" required class="form-control mb-2">
                    <input type="text" name="course_title" placeholder="Course Title" required class="form-control mb-2">
                    <input type="text" name="instructor_name" placeholder="Instructor" required class="form-control mb-2">
                    <input type="text" name="date_time" placeholder="Date/Time" required class="form-control mb-2">
                    <input type="text" name="location" placeholder="Location" required class="form-control mb-2">
                    <button type="submit" class="btn bg-utd-green text-white">Add Course</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Update Course Modal -->
<div class="modal fade" id="updateCourseModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-warning text-dark">
                <h4 class="modal-title">Update Course</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form id="updateCourseForm" method="POST">
                    <input type="hidden" name="id" id="update_id">
                    <input type="text" name="course_number" id="update_course_number" class="form-control mb-2" required>
                    <input type="text" name="course_title" id="update_course_title" class="form-control mb-2" required>
                    <input type="text" name="instructor_name" id="update_instructor" class="form-control mb-2" required>
                    <input type="text" name="date_time" id="update_time" class="form-control mb-2" required>
                    <input type="text" name="location" id="update_location" class="form-control mb-2" required>
                    <button type="submit" class="btn btn-warning text-white">Update Course</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="text-center py-3 bg-dark text-white">
    © 2025 The University of Texas at Dallas
</footer>

<!-- Load External JS -->
<script src="task3.js"></script>

</body>
</html>
