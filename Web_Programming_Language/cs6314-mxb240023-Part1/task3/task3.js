$(function() {
    var courses = [];
    $(".card-link").each(function() {
        courses.push($(this).text().trim());
    });

    $("#courseSearch").autocomplete({
        source: courses,
        select: function(event, ui) {
            $(".collapse").collapse('hide');
            var selected = ui.item.value.split(' - ')[0];
            var cleanId = selected.replace(/[^a-zA-Z0-9]/g, ''); // Cleaning up the ID
            var elementId = "course" + cleanId;
            var element = document.getElementById(elementId);
            
            console.log('Selected ID:', selected);  // Debug: Log selected ID
            console.log('Clean ID:', cleanId);      // Debug: Log cleaned ID
            console.log('Element ID:', elementId);  // Debug: Log full element ID
            console.log('Element:', element);       // Debug: Log the element

            if (element) {
                $(element).collapse('show');
                element.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            } else {
                console.error('Element not found: ' + elementId);
            }
        }
    });

    $('#addCourseForm').submit(function(event) {
        event.preventDefault(); 
        var formData = $(this).serialize(); 
        $.ajax({
            type: 'POST',
            url: 'task3_addcourse.php',
            data: formData,
            success: function(response) {
                alert('Course Added Successfully');
                $('#addCourseModal').modal('hide');
                location.reload();
            },
            error: function() {
                alert('Error adding course');
            }
        });
    });
});
