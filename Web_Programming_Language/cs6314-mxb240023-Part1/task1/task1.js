// Define the function to be called on button click


function downloadSQLFile(sqlData) {
    const blob = new Blob([sqlData], { type: 'text/plain' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'task1.sql';
    document.body.appendChild(a);
    a.click();
    setTimeout(() => {
        document.body.removeChild(a);
        window.URL.revokeObjectURL(url);  
    }, 0);
}
 
function extractCourses() {
    console.log("Extract Courses button clicked!");
    let sqlCommands = [];
    let createTableSQL = `
    CREATE TABLE IF NOT EXISTS course1 (
        id INT AUTO_INCREMENT PRIMARY KEY,
        year_semester VARCHAR(255),
        course_number VARCHAR(255),
        course_title TEXT,
        instructor_name VARCHAR(255),
        instructor_netid VARCHAR(255),
        date_time VARCHAR(255),
        location VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    `;
     // Add the create table statement at the beginning of the commands list
     sqlCommands.push(createTableSQL);
    for (let i = 1; i <= 235; i++) {
        let row = document.querySelector("#r-" + i);
        if (!row) continue; // Skip if the row doesn't exist

        let yearSemester = row.querySelector("td:nth-child(1)") ? row.querySelector("td:nth-child(1)").innerText.trim().split("\n")[0] : 'None';
        let courseNumber = row.querySelector("td:nth-child(2) a") ? row.querySelector("td:nth-child(2) a").innerText.trim() : 'None';
        let courseTitle = row.querySelector("td:nth-child(4)") ? row.querySelector("td:nth-child(4)").innerText.trim() : 'None';
        let instructor = row.querySelector("td:nth-child(5) a") ? row.querySelector("td:nth-child(5) a").innerText.trim() : 'None';
        let instructorNetID = row.querySelector("td:nth-child(5) a") ? row.querySelector("td:nth-child(5) a").getAttribute("href").split('/').pop() : 'None';

        let scheduleElem = row.querySelector(".clstbl__resultrow__schedule");
        let dateTime = scheduleElem ? scheduleElem.innerText.trim().replace("\n", " ") : 'None';

        let location = row.querySelector(".clstbl__resultrow__location") ? row.querySelector(".clstbl__resultrow__location").innerText.trim() : 'None';

        let sql = `INSERT INTO course1 (year_semester, course_number, course_title, instructor_name, instructor_netid, date_time, location, created_at, updated_at) VALUES ('${yearSemester}', '${courseNumber}', '${courseTitle}', '${instructor}', '${instructorNetID}', '${dateTime}', '${location}', NOW(), NOW());`;
        sqlCommands.push(sql);

    }
    downloadSQLFile(sqlCommands.join('\n'));
}
 