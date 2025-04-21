// ADD TEST CASES
function addTestCase1() {
    document.querySelector('[name=course_number]').value = 'CS6314';
    document.querySelector('[name=course_title]').value = 'Web Programming';
    document.querySelector('[name=instructor_name]').value = 'Richard Min';
    document.querySelector('[name=date_time]').value = 'Tue & Thu 5:30pm - 6:45pm';
    document.querySelector('[name=location]').value = 'ECSS 2.412';
    document.querySelector('[name=add]').click();
}

function addTestCase2() {
    document.querySelector('[name=course_number]').value = 'CS6363';
    document.querySelector('[name=course_title]').value = 'Algorithms';
    document.querySelector('[name=instructor_name]').value = 'Dung Huynh';
    document.querySelector('[name=date_time]').value = 'Tue & Thu 10:00pm - 11:15pm';
    document.querySelector('[name=location]').value = 'ECSS 2.305';
    document.querySelector('[name=add]').click();
}

function addTestCase3() {
    document.querySelector('[name=course_number]').value = 'CS6360';
    document.querySelector('[name=course_title]').value = 'DB Design';
    document.querySelector('[name=instructor_name]').value = 'Wei Wu';
    document.querySelector('[name=date_time]').value = 'Mon & Wed 1:00am - 2:15am';
    document.querySelector('[name=location]').value = 'JO 6.301';
    document.querySelector('[name=add]').click();
}

// UPDATE TEST CASES
//change the course title to 'Web Programming Language' from 'Web Programming'
function updateTestCase1() {
    document.querySelector('[name=course_number]').value = 'CS6314';
    document.querySelector('[name=course_title]').value = 'Web Programming Language';
    document.querySelector('[name=instructor_name]').value = 'Richard Min';
    document.querySelector('[name=date_time]').value = 'Tue & Thu 5:30pm - 6:45pm';
    document.querySelector('[name=location]').value = 'ECSS 2.412';
    document.querySelector('[name=update]').click();
}
//change the course title to 'Design and Analysis of Algorithms' from 'Algorithms'
function updateTestCase2() {
    document.querySelector('[name=course_number]').value = 'CS6363';
    document.querySelector('[name=course_title]').value = 'Design and Analysis of Algorithms';
    document.querySelector('[name=instructor_name]').value = 'Dung Huynh';
    document.querySelector('[name=date_time]').value = 'Tue & Thu 10:00pm - 11:15pm';
    document.querySelector('[name=location]').value = 'ECSS 2.305';
    document.querySelector('[name=update]').click();
}

//change the location to 2.416 from 2.412
function updateTestCase3() {
    document.querySelector('[name=course_number]').value = 'CS 6314.501';
    document.querySelector('[name=course_title]').value = 'Web Programming Languages (3 Semester Credit Hours)';
    document.querySelector('[name=instructor_name]').value = 'Richard Min';
    document.querySelector('[name=date_time]').value = 'Tuesday & Thursday 5:30pm - 6:45pm';
    document.querySelector('[name=location]').value = 'ECSS 2.416';
    document.querySelector('[name=update]').click();
}

// DELETE TEST CASES
function deleteTestCase1() {
    document.querySelector('[name=course_number]').value = 'CS6314';
    document.querySelector('[name=delete]').click();
}

function deleteTestCase2() {
    document.querySelector('[name=course_number]').value = 'CS6363';
    document.querySelector('[name=delete]').click();
}

function deleteTestCase3() {
    document.querySelector('[name=course_number]').value = 'CS6360';
    document.querySelector('[name=delete]').click();
}