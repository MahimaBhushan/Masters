CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userid VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    user_type ENUM('admin', 'user') NOT NULL,
    user_status ENUM('active', 'inactive', 'revoked', 'deleted') NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    create_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_update_datetime DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE userlog (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userid VARCHAR(50),
    login_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    logout_datetime DATETIME,
    session_id VARCHAR(255)
);