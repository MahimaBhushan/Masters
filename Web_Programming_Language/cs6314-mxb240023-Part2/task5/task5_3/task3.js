$(function () {
    // Autocomplete course search
    var courses = [];
    $(".card-link").each(function () {
        courses.push($(this).text().trim());
    });

    $("#courseSearch").autocomplete({
        source: courses,
        select: function (event, ui) {
            $(".collapse").collapse("hide");
            var selected = ui.item.value.split(" - ")[0];
            var cleanId = selected.replace(/[^a-zA-Z0-9]/g, "");
            var elementId = "course" + cleanId;
            var element = document.getElementById(elementId);

            if (element) {
                $(element).collapse("show");
                element.scrollIntoView({ behavior: "smooth", block: "nearest" });
            } else {
                console.error("Element not found: " + elementId);
            }
        }
    });

    // Add Course via AJAX
    $('#addCourseForm').submit(function (event) {
        event.preventDefault();
        var formData = $(this).serialize();
        $.ajax({
            type: 'POST',
            url: 'task3_addcourse.php',
            data: formData,
            success: function (response) {
                alert('Course Added Successfully');
                $('#addCourseModal').modal('hide');
                location.reload();
            },
            error: function () {
                alert('Error adding course');
            }
        });
    });

    // Update Course via AJAX
    $('#updateCourseForm').submit(function (event) {
        event.preventDefault();
        var formData = $(this).serialize();
        $.ajax({
            type: 'POST',
            url: 'task3_updatecourse.php',
            data: formData,
            dataType: 'json',
            success: function (response) {
                if (response.success) {
                    alert('Course updated successfully');
                    $('#updateCourseModal').modal('hide');
                    location.reload();
                } else {
                    alert('Update failed: ' + response.message);
                }
            },
            error: function () {
                alert('Error updating course');
            }
        });
    });

    // Pre-fill update modal fields
    $('#updateCourseModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        $('#update_id').val(button.data('id'));
        $('#update_course_number').val(button.data('course_number'));
        $('#update_course_title').val(button.data('course_title'));
        $('#update_instructor').val(button.data('instructor'));
        $('#update_time').val(button.data('time'));
        $('#update_location').val(button.data('location'));
    });

    // Delete Course via AJAX (fixed with delegation)
    $(document).on('submit', '.delete-form', function (event) {
        event.preventDefault();
        if (confirm("Are you sure you want to delete this course?")) {
            var form = $(this);
            $.ajax({
                type: 'POST',
                url: 'task3_deletecourse.php',
                data: form.serialize(),
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        alert('Course deleted successfully');
                        console.log("Delete clicked");
                        location.reload();
                    } else {
                        console.log("Delete failed");
                        alert('Delete failed: ' + response.message);
                    }
                },
                error: function () {
                    alert('Error deleting course');
                }
            });
        }
    });
});
