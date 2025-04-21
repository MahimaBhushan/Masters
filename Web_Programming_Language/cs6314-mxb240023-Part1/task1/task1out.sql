-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 18, 2025 at 12:51 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `university_courses`
--

-- --------------------------------------------------------

--
-- Table structure for table `course1`
--

CREATE TABLE `course1` (
  `id` int(11) NOT NULL,
  `year_semester` varchar(255) DEFAULT NULL,
  `course_number` varchar(255) DEFAULT NULL,
  `course_title` text DEFAULT NULL,
  `instructor_name` varchar(255) DEFAULT NULL,
  `instructor_netid` varchar(255) DEFAULT NULL,
  `date_time` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `course1`
--

INSERT INTO `course1` (`id`, `year_semester`, `course_number`, `course_title`, `instructor_name`, `instructor_netid`, `date_time`, `location`, `created_at`, `updated_at`) VALUES
(1, '25S', 'CS 1325.001', 'Introduction to Programming (3 Semester Credit Hours)', 'Miguel Razo Razo', 'mrazora', 'Monday & Wednesday 10:00am - 11:15am', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(2, '25S', 'CS 1325.002', 'Introduction to Programming (3 Semester Credit Hours)', 'Nidhiben Solanki', 'nxs121130', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(3, '25S', 'CS 1337.001', 'Computer Science I (3 Semester Credit Hours)', 'Priya Narayanasami', 'pxn173330', 'Tuesday & Thursday 4:00pm - 5:15pm', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(4, '25S', 'CS 1337.002', 'Computer Science I (3 Semester Credit Hours)', 'Srimathi Srinivasan', 'sxs180206', 'Monday & Wednesday 10:00am - 11:15am', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(5, '25S', 'CS 1337.003', 'Computer Science I (3 Semester Credit Hours)', 'Parisa Darbari', 'dal776869', 'Monday & Wednesday 10:00am - 11:15am', 'ECSW 1.355', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(6, '25S', 'CS 1337.004', 'Computer Science I (3 Semester Credit Hours)', 'Shyam Karrah', 'skarrah', 'Tuesday & Thursday 4:00pm - 5:15pm', 'SLC 2.303', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(7, '25S', 'CS 1337.005', 'Computer Science I (3 Semester Credit Hours)', 'Srimathi Srinivasan', 'sxs180206', 'Monday & Wednesday 11:30am - 12:45pm', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(8, '25S', 'CS 1337.006', 'Computer Science I (3 Semester Credit Hours)', 'Gordon Arnold', 'gxa120930', 'Monday & Wednesday 11:30am - 12:45pm', 'ECSS 2.311', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(9, '25S', 'CS 1337.007', 'Computer Science I (3 Semester Credit Hours)', 'Jason Smith', 'jws130830', 'Tuesday & Thursday 1:00pm - 2:15pm', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(10, '25S', 'CS 1337.008', 'Computer Science I (3 Semester Credit Hours)', 'Aditya Srivastava', 'axs142531', 'Tuesday & Thursday 1:00pm - 2:15pm', 'ECSS 2.306', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(11, '25S', 'CS 1337.009', 'Computer Science I (3 Semester Credit Hours)', 'Shyam Karrah', 'skarrah', 'Tuesday & Thursday 1:00pm - 2:15pm', 'ECSW 1.355', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(12, '25S', 'CS 1337.010', 'Computer Science I (3 Semester Credit Hours)', 'Jason Smith', 'jws130830', 'Tuesday & Thursday 4:00pm - 5:15pm', 'FN 2.102', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(13, '25S', 'CS 1337.0w1', 'Computer Science I (3 Semester Credit Hours)', 'Scott Dollinger', 'smd013000', 'Monday & Wednesday 10:00am - 11:15am', 'No Meeting Room', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(14, '25S', 'CS 1337.0w2', 'Computer Science I (3 Semester Credit Hours)', 'Scott Dollinger', 'smd013000', 'Monday & Wednesday 11:30am - 12:45pm', 'No Meeting Room', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(15, '25S', 'CS 1337.701', 'Computer Science I (Non-Enroll)', 'Simeon Ntafos', 'ntafos', 'None', '', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(16, '25S', 'CS 1436.001', 'Programming Fundamentals (4 Credits)', 'Laurie Thompson', 'lthomp', 'Monday & Wednesday 11:00am - 1:15pm', 'ECSS 2.312', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(17, '25S', 'CS 1436.002', 'Programming Fundamentals (4 Credits)', 'Laurie Thompson', 'lthomp', 'Monday & Wednesday 2:30pm - 4:45pm', 'ECSS 2.312', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(18, '25S', 'CS 1436.003', 'Programming Fundamentals (4 Credits)', 'James Willson', 'jkw053000', 'Tuesday & Thursday 1:00pm - 3:15pm', 'ECSS 2.312', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(19, '25S', 'CS 2305.001', 'Discrete Mathematics for Computing I (3 Semester Credit Hours)', 'Jessica Ouyang', 'jjo190001', 'Tuesday & Thursday 8:30am - 9:45am', 'ECSW 1.315', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(20, '25S', 'CS 2305.002', 'Discrete Mathematics for Computing I (3 Semester Credit Hours)', 'Jason Jue', 'jjue', 'Tuesday & Thursday 8:30am - 9:45am', 'HH 2.402', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(21, '25S', 'CS 2305.004', 'Discrete Mathematics for Computing I (3 Semester Credit Hours)', 'Sergey Bereg', 'sxb027100', 'Monday & Wednesday 2:30pm - 3:45pm', 'SLC 1.102', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(22, '25S', 'CS 2305.005', 'Discrete Mathematics for Computing I (3 Semester Credit Hours)', 'Daniel Gibney', 'djg230002', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSW 1.315', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(23, '25S', 'CS 2336.001', 'Computer Science II (3 Semester Credit Hours)', 'Brian Ricks', 'bwr031000', 'Monday & Wednesday 10:00am - 11:15am', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(24, '25S', 'CS 2336.003', 'Computer Science II (3 Semester Credit Hours)', 'Brian Ricks', 'bwr031000', 'Monday & Wednesday 11:30am - 12:45pm', 'GR 2.530', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(25, '25S', 'CS 2336.005', 'Computer Science II (3 Semester Credit Hours)', 'Jason Smith', 'jws130830', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSS 2.201', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(26, '25S', 'CS 2336.007', 'Computer Science II (3 Semester Credit Hours)', 'Jeyakesavan Veerasamy', 'veerasam', 'Tuesday & Thursday 2:30pm - 3:45pm', 'ECSS 2.201', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(27, '25S', 'CS 2336.008', 'Computer Science II (3 Semester Credit Hours)', 'Aditya Srivastava', 'axs142531', 'Tuesday & Thursday 2:30pm - 3:45pm', 'ECSS 2.203', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(28, '25S', 'CS 2336.501', 'Computer Science II (3 Semester Credit Hours)', 'David Sims', 'dxs190044', 'Tuesday & Thursday 5:30pm - 6:45pm', 'ECSS 2.306', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(29, '25S', 'CS 2337.501', 'Computer Science II (3 Semester Credit Hours)', 'Doug DeGroot', 'dxd180020', 'Tuesday & Thursday 5:30pm - 6:45pm', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(30, '25S', 'CS 2340.001', 'Computer Architecture (3 Semester Credit Hours)', 'Alice Wang', 'axw230018', 'Monday & Wednesday 10:00am - 11:15am', 'JO 4.614', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(31, '25S', 'CS 2340.003', 'Computer Architecture (3 Semester Credit Hours)', 'Alice Wang', 'axw230018', 'Monday & Wednesday 1:00pm - 2:15pm', 'ECSS 2.311', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(32, '25S', 'CS 2340.004', 'Computer Architecture (3 Semester Credit Hours)', 'Yvo Desmedt', 'ygd120030', 'Monday & Wednesday 1:00pm - 2:15pm', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(33, '25S', 'CS 2340.005', 'Computer Architecture (3 Semester Credit Hours)', 'Wafa Jaffal', 'wxj210000', 'Monday & Wednesday 8:30am - 9:45am', 'ECSS 2.311', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(34, '25S', 'CS 2340.006', 'Computer Architecture (3 Semester Credit Hours)', 'Alice Wang', 'axw230018', 'Tuesday & Thursday 2:30pm - 3:45pm', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(35, '25S', 'CS 2340.007', 'Computer Architecture (3 Semester Credit Hours)', 'Wafa Jaffal', 'wxj210000', 'Monday & Wednesday 10:00am - 11:15am', 'ECSS 2.311', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(36, '25S', 'CS 2340.008', 'Computer Architecture (3 Semester Credit Hours)', 'Nhut Nguyen', 'nhutnn', 'Tuesday & Thursday 4:00pm - 5:15pm', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(37, '25S', 'CS 2340.hn1', 'Computer Architecture - CV Honors (3 Semester Credit Hours)', 'Nhut Nguyen', 'nhutnn', 'Tuesday & Thursday 10:00am - 11:15am', 'AD 3.216', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(38, '25S', 'CS 3162.051', 'Professional Responsibility in Computer Science and Software Engineering (1 Semester Credit Hour)', 'John Cole', 'jxc064000', 'Tuesday & Thursday 9:00am - 9:50am', 'FN 2.102', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(39, '25S', 'CS 3162.052', 'Professional Responsibility in Computer Science and Software Engineering (1 Semester Credit Hour)', 'John Cole', 'jxc064000', 'Tuesday & Thursday 8:00am - 8:50am', 'FN 2.102', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(40, '25S', 'CS 3162.091', 'Professional Responsibility in Computer Science and Software Engineering (1 Semester Credit Hour)', 'John Cole', 'jxc064000', 'Tuesday & Thursday 9:00am - 9:50am', 'FN 2.102', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(41, '25S', 'CS 3162.092', 'Professional Responsibility in Computer Science and Software Engineering (1 Semester Credit Hour)', 'John Cole', 'jxc064000', 'Tuesday & Thursday 8:00am - 8:50am', 'FN 2.102', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(42, '25S', 'CS 3341.001', 'Probability and Statistics in Computer Science and Software Engineering (3 Semester Credit Hours)', 'Octavious Smiley', 'oxs230011', 'Monday & Wednesday 11:30am - 12:45pm', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(43, '25S', 'CS 3341.002', 'Probability and Statistics in Computer Science and Software Engineering (3 Semester Credit Hours)', 'Huizhen Guo', 'hxg190020', 'Tuesday & Thursday 2:30pm - 3:45pm', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(44, '25S', 'CS 3341.003', 'Probability and Statistics in Computer Science and Software Engineering (3 Semester Credit Hours)', 'Huizhen Guo', 'hxg190020', 'Tuesday & Thursday 1:00pm - 2:15pm', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(45, '25S', 'CS 3341.004', 'Probability and Statistics in Computer Science and Software Engineering (3 Semester Credit Hours)', 'Huizhen Guo', 'hxg190020', 'Monday & Wednesday 2:30pm - 3:45pm', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(46, '25S', 'CS 3341.005', 'Probability and Statistics in Computer Science and Software Engineering (3 Semester Credit Hours)', 'Shengjie Jiang', 'sxj220069', 'Monday & Wednesday 8:30am - 9:45am', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(47, '25S', 'CS 3341.006', 'Probability and Statistics in Computer Science and Software Engineering (3 Semester Credit Hours)', 'Octavious Smiley', 'oxs230011', 'Monday & Wednesday 4:00pm - 5:15pm', 'HH 2.402', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(48, '25S', 'CS 3341.501', 'Probability and Statistics in Computer Science and Software Engineering (3 Semester Credit Hours)', 'Octavious Smiley', 'oxs230011', 'Monday & Wednesday 5:30pm - 6:45pm', 'ECSW 1.315', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(49, '25S', 'CS 3345.001', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Yvo Desmedt', 'ygd120030', 'Monday & Wednesday 10:00am - 11:15am', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(50, '25S', 'CS 3345.002', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Meghana Satpute', 'mns086000', 'Tuesday & Thursday 1:00pm - 2:15pm', 'ECSS 2.311', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(51, '25S', 'CS 3345.003', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Sridhar Alagar', 'sxa173731', 'Monday & Wednesday 10:00am - 11:15am', 'ECSS 2.306', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(52, '25S', 'CS 3345.005', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Omar Hamdy', 'oxh210004', 'Monday & Wednesday 8:30am - 9:45am', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(53, '25S', 'CS 3345.006', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Sruthi Chappidi', 'sxc105920', 'Monday & Wednesday 8:30am - 9:45am', 'ECSS 2.306', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(54, '25S', 'CS 3345.007', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Meghana Satpute', 'mns086000', 'Monday & Wednesday 10:00am - 11:15am', 'JO 3.601', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(55, '25S', 'CS 3345.008', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Parisa Darbari', 'dal776869', 'Monday & Wednesday 8:30am - 9:45am', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(56, '25S', 'CS 3345.009', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Yi Zhao', 'zhao', 'Tuesday & Thursday 1:00pm - 2:15pm', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(57, '25S', 'CS 3345.501', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Omar Hamdy', 'oxh210004', 'Tuesday & Thursday 5:30pm - 6:45pm', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(58, '25S', 'CS 3345.502', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Ziaullah Khan', 'kkhan', 'Tuesday & Thursday 5:30pm - 6:45pm', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(59, '25S', 'CS 3345.504', 'Data Structures and Introduction to Algorithmic Analysis (3 Semester Credit Hours)', 'Ziaullah Khan', 'kkhan', 'Monday & Wednesday 5:30pm - 6:45pm', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(60, '25S', 'CS 3354.001', 'Software Engineering (3 Semester Credit Hours)', 'Tien Nguyen', 'tnn160630', 'Monday & Wednesday 1:00pm - 2:15pm', 'ECSS 2.306', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(61, '25S', 'CS 3354.002', 'Software Engineering (3 Semester Credit Hours)', 'Srimathi Srinivasan', 'sxs180206', 'Monday & Wednesday 2:30pm - 3:45pm', 'SCI 1.210', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(62, '25S', 'CS 3354.003', 'Software Engineering (3 Semester Credit Hours)', 'Ranran Feng', 'rxf090020', 'Monday & Wednesday 1:00pm - 2:15pm', 'ECSW 1.355', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(63, '25S', 'CS 3354.004', 'Software Engineering (3 Semester Credit Hours)', 'Ranran Feng', 'rxf090020', 'Monday & Wednesday 11:30am - 12:45pm', 'ECSS 2.203', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(64, '25S', 'CS 3354.005', 'Software Engineering (3 Semester Credit Hours)', 'Priya Narayanasami', 'pxn173330', 'Tuesday & Thursday 10:00am - 11:15am', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(65, '25S', 'CS 3354.006', 'Software Engineering (3 Semester Credit Hours)', 'Mehra Nouroz Borazjany', 'mxn143230', 'Monday & Wednesday 2:30pm - 3:45pm', 'ECSW 1.355', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(66, '25S', 'CS 3354.007', 'Software Engineering (3 Semester Credit Hours)', 'Priya Narayanasami', 'pxn173330', 'Tuesday & Thursday 2:30pm - 3:45pm', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(67, '25S', 'CS 3354.008', 'Software Engineering (3 Semester Credit Hours)', 'Sruthi Chappidi', 'sxc105920', 'Tuesday & Thursday 10:00am - 11:15am', 'ECSW 1.355', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(68, '25S', 'CS 3354.010', 'Software Engineering (3 Semester Credit Hours)', 'Sruthi Chappidi', 'sxc105920', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSS 2.203', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(69, '25S', 'CS 3354.hon', 'Software Engineering - Honors (3 Semester Credit Hours)', 'Tien Nguyen', 'tnn160630', 'Tuesday & Thursday 2:30pm - 3:45pm', 'AD 2.216', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(70, '25S', 'CS 3377.001', 'Systems Programming in UNIX and Other Environments (3 Semester Credit Hours)', 'Mohamed Amine Belkoura', 'mxb135330', 'Monday & Wednesday 4:00pm - 5:15pm', 'JO 4.614', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(71, '25S', 'CS 3377.002', 'Systems Programming in UNIX and Other Environments (3 Semester Credit Hours)', 'Richard Min', 'rkm010300', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(72, '25S', 'CS 3377.003', 'Systems Programming in UNIX and Other Environments (3 Semester Credit Hours)', 'Sridhar Alagar', 'sxa173731', 'Monday & Wednesday 4:00pm - 5:15pm', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(73, '25S', 'CS 3377.004', 'Systems Programming in UNIX and Other Environments (3 Semester Credit Hours)', 'Richard Min', 'rkm010300', 'Tuesday & Thursday 8:30am - 9:45am', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(74, '25S', 'CS 3377.005', 'Systems Programming in UNIX and Other Environments (3 Semester Credit Hours)', 'Jeyakesavan Veerasamy', 'veerasam', 'Tuesday & Thursday 8:30am - 9:45am', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(75, '25S', 'CS 3377.006', 'Systems Programming in UNIX and Other Environments (3 Semester Credit Hours)', 'Jeyakesavan Veerasamy', 'veerasam', 'Tuesday & Thursday 11:30am - 12:45pm', 'GR 2.302', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(76, '25S', 'CS 3377.502', 'Systems Programming in UNIX and Other Environments (3 Semester Credit Hours)', 'Mohamed Amine Belkoura', 'mxb135330', 'Monday & Wednesday 5:30pm - 6:45pm', 'JO 4.614', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(77, '25S', 'CS 3377.5w1', 'Systems Programming in UNIX and Other Environments (3 Semester Credit Hours)', 'Scott Dollinger', 'smd013000', 'Monday & Wednesday 5:30pm - 6:45pm', 'No Meeting Room', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(78, '25S', 'CS 4141.101', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-10 Monday 1:00pm - 3:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(79, '25S', 'CS 4141.102', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-11 Tuesday 4:00pm - 6:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(80, '25S', 'CS 4141.103', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-12 Wednesday 4:00pm - 6:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(81, '25S', 'CS 4141.104', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-13 Thursday 4:00pm - 6:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(82, '25S', 'CS 4141.105', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-14 Friday 1:00pm - 3:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(83, '25S', 'CS 4141.106', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-17 Monday 1:00pm - 3:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(84, '25S', 'CS 4141.107', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-18 Tuesday 4:00pm - 6:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(85, '25S', 'CS 4141.108', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-19 Wednesday 4:00pm - 6:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(86, '25S', 'CS 4141.109', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-20 Thursday 4:00pm - 6:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(87, '25S', 'CS 4141.110', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-21 Friday 1:00pm - 3:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(88, '25S', 'CS 4141.111', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-10 Monday 4:00pm - 6:45pm', 'ECSN 3.114', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(89, '25S', 'CS 4141.112', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-11 Tuesday 4:00pm - 6:45pm', 'ECSN 3.114', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(90, '25S', 'CS 4141.113', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-12 Wednesday 4:00pm - 6:45pm', 'ECSN 3.114', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(91, '25S', 'CS 4141.114', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-13 Thursday 4:00pm - 6:45pm', 'ECSN 3.114', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(92, '25S', 'CS 4141.115', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-14 Friday 1:00pm - 3:45pm', 'ECSN 3.114', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(93, '25S', 'CS 4141.116', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-19 Wednesday 4:00pm - 6:45pm', 'ECSN 3.114', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(94, '25S', 'CS 4141.117', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-20 Thursday 4:00pm - 6:45pm', 'ECSN 3.114', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(95, '25S', 'CS 4141.118', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-21 Friday 1:00pm - 3:45pm', 'ECSN 3.114', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(96, '25S', 'CS 4141.601', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-10 Monday 7:00pm - 9:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(97, '25S', 'CS 4141.602', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-11 Tuesday 7:00pm - 9:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(98, '25S', 'CS 4141.603', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-12 Wednesday 7:00pm - 9:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(99, '25S', 'CS 4141.604', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-13 Thursday 7:00pm - 9:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(100, '25S', 'CS 4141.605', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-14 Friday 7:00pm - 9:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(101, '25S', 'CS 4141.606', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-17 Monday 7:00pm - 9:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(102, '25S', 'CS 4141.607', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-18 Tuesday 7:00pm - 9:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(103, '25S', 'CS 4141.608', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-19 Wednesday 7:00pm - 9:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(104, '25S', 'CS 4141.609', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-20 Thursday 7:00pm - 9:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(105, '25S', 'CS 4141.610', 'Digital Systems Laboratory (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-21 Friday 7:00pm - 9:45pm', 'ECSN 3.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(106, '25S', 'CS 4141.ho1', 'Digital Systems Laboratory - Honors (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-17 Monday 1:00pm - 3:45pm', 'ECSN 3.114', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(107, '25S', 'CS 4141.hon', 'Digital Systems Laboratory - Honors (1 Semester Credit Hour)', 'Eric Becker', 'ewb160130', '2025-02-18 Tuesday 4:00pm - 6:45pm', 'ECSN 3.114', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(108, '25S', 'CS 4301.001', 'Special Topics in Computer Science - Combinatorial Optimization (3 Semester Credit Hours)', 'Emily Fox', 'kjf170230', 'Monday & Wednesday 11:30am - 12:45pm', 'ECSW 1.355', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(109, '25S', 'CS 4301.002', 'Special Topics in Computer Science - Adv Programming Languages (3 Semester Credit Hours)', 'Kevin Hamlen', 'kxh060100', 'Tuesday & Thursday 1:00pm - 2:15pm', 'FN 2.202', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(110, '25S', 'CS 4332.001', 'Introduction to Programming Video Games (3 Semester Credit Hours)', 'Rawan Alghofaili', 'rxa230065', 'Tuesday & Thursday 10:00am - 11:15am', 'GR 2.302', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(111, '25S', 'CS 4334.001', 'Numerical Analysis (3 Semester Credit Hours)', 'Saikat Biswas', 'sxb230137', 'Monday & Wednesday 11:30am - 12:45pm', 'AD 2.216', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(112, '25S', 'CS 4337.001', 'Programming Language Paradigms (3 Semester Credit Hours)', 'Yi Zhao', 'zhao', 'Monday & Wednesday 11:30am - 12:45pm', 'ECSS 2.306', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(113, '25S', 'CS 4337.002', 'Programming Language Paradigms (3 Semester Credit Hours)', 'Yi Zhao', 'zhao', 'Monday & Wednesday 2:30pm - 3:45pm', 'GR 2.302', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(114, '25S', 'CS 4337.003', 'Programming Language Paradigms (3 Semester Credit Hours)', 'Gity Karami', 'gxk180009', 'Monday & Wednesday 2:30pm - 3:45pm', 'JO 4.614', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(115, '25S', 'CS 4337.004', 'Programming Language Paradigms (3 Semester Credit Hours)', 'Jalal Omer', 'jso016000', 'Tuesday & Thursday 8:30am - 9:45am', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(116, '25S', 'CS 4337.005', 'Programming Language Paradigms (3 Semester Credit Hours)', 'Elmer Salazar', 'ees101020', 'Tuesday & Thursday 2:30pm - 3:45pm', 'JO 3.601', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(117, '25S', 'CS 4337.006', 'Programming Language Paradigms (3 Semester Credit Hours)', 'Chris Davis', 'cid021000', 'Monday & Wednesday 11:30am - 12:45pm', 'GR 2.302', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(118, '25S', 'CS 4337.007', 'Programming Language Paradigms (3 Semester Credit Hours)', 'Gity Karami', 'gxk180009', 'Tuesday & Thursday 8:30am - 9:45am', 'GR 2.302', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(119, '25S', 'CS 4337.hon', 'Programming Language Paradigms - Honors (3 Semester Credit Hours)', 'Chris Davis', 'cid021000', 'Monday & Wednesday 4:00pm - 5:15pm', 'ECSN 2.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(120, '25S', 'CS 4341.001', 'Digital Logic and Computer Design (3 Semester Credit Hours)', 'Doug DeGroot', 'dxd180020', 'Tuesday & Thursday 1:00pm - 2:15pm', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(121, '25S', 'CS 4341.002', 'Digital Logic and Computer Design (3 Semester Credit Hours)', 'Bingzhe Li', 'bxl230006', 'Tuesday & Thursday 10:00am - 11:15am', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(122, '25S', 'CS 4341.003', 'Digital Logic and Computer Design (3 Semester Credit Hours)', 'Omar Hamdy', 'oxh210004', 'Monday & Wednesday 1:00pm - 2:15pm', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(123, '25S', 'CS 4341.004', 'Digital Logic and Computer Design (3 Semester Credit Hours)', 'Doug DeGroot', 'dxd180020', 'Tuesday & Thursday 10:00am - 11:15am', 'ECSS 2.203', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(124, '25S', 'CS 4341.005', 'Digital Logic and Computer Design (3 Semester Credit Hours)', 'Gity Karami', 'gxk180009', 'Monday & Wednesday 1:00pm - 2:15pm', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(125, '25S', 'CS 4341.006', 'Digital Logic and Computer Design (3 Semester Credit Hours)', 'Eric Becker', 'ewb160130', 'Tuesday & Thursday 1:00pm - 2:15pm', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(126, '25S', 'CS 4341.hon', 'Digital Logic and Computer Design - Honors (3 Semester Credit Hours)', 'Ebru Cankaya', 'exc067000', 'Monday & Wednesday 10:00am - 11:15am', 'PHY 1.103', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(127, '25S', 'CS 4347.001', 'Database Systems (3 Semester Credit Hours)', 'Jalal Omer', 'jso016000', 'Monday & Wednesday 4:00pm - 5:15pm', 'ECSS 2.306', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(128, '25S', 'CS 4347.002', 'Database Systems (3 Semester Credit Hours)', 'Wei Wu', 'wxw020100', 'Monday & Wednesday 2:30pm - 3:45pm', 'ECSS 2.306', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(129, '25S', 'CS 4347.003', 'Database Systems (3 Semester Credit Hours)', 'Jalal Omer', 'jso016000', 'Tuesday & Thursday 11:30am - 12:45pm', 'GR 2.530', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(130, '25S', 'CS 4347.004', 'Database Systems (3 Semester Credit Hours)', 'Pushpa Kumar', 'pkumar', 'Monday & Wednesday 4:00pm - 5:15pm', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(131, '25S', 'CS 4347.005', 'Database Systems (3 Semester Credit Hours)', 'Xinda Wang', 'xxw230005', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(132, '25S', 'CS 4347.006', 'Database Systems (3 Semester Credit Hours)', 'Pushpa Kumar', 'pkumar', 'Monday & Wednesday 2:30pm - 3:45pm', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(133, '25S', 'CS 4347.501', 'Database Systems (3 Semester Credit Hours)', 'Chris Davis', 'cid021000', 'Tuesday & Thursday 5:30pm - 6:45pm', 'GR 2.530', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(134, '25S', 'CS 4347.502', 'Database Systems (3 Semester Credit Hours)', 'Ziaullah Khan', 'kkhan', 'Tuesday & Thursday 7:00pm - 8:15pm', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(135, '25S', 'CS 4348.001', 'Operating Systems Concepts (3 Semester Credit Hours)', 'Erik Peterson', 'eap190004', 'Monday & Wednesday 1:00pm - 2:15pm', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(136, '25S', 'CS 4348.002', 'Operating Systems Concepts (3 Semester Credit Hours)', 'I-Ling Yen', 'ilyen', 'Tuesday & Thursday 4:00pm - 5:15pm', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(137, '25S', 'CS 4348.003', 'Operating Systems Concepts (3 Semester Credit Hours)', 'Elmer Salazar', 'ees101020', 'Tuesday & Thursday 4:00pm - 5:15pm', 'ECSS 2.312', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(138, '25S', 'CS 4348.004', 'Operating Systems Concepts (3 Semester Credit Hours)', 'Neeraj Mittal', 'nxm020100', 'Monday & Wednesday 1:00pm - 2:15pm', 'JO 4.614', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(139, '25S', 'CS 4348.501', 'Operating Systems Concepts (3 Semester Credit Hours)', 'Elmer Salazar', 'ees101020', 'Monday & Wednesday 5:30pm - 6:45pm', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(140, '25S', 'CS 4348.503', 'Operating Systems Concepts (3 Semester Credit Hours)', 'Jonathan Perry', 'jjp160630', 'Tuesday & Thursday 5:30pm - 6:45pm', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(141, '25S', 'CS 4349.001', 'Advanced Algorithm Design and Analysis (3 Semester Credit Hours)', 'James Willson', 'jkw053000', 'Monday & Wednesday 11:30am - 12:45pm', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(142, '25S', 'CS 4349.002', 'Advanced Algorithm Design and Analysis (3 Semester Credit Hours)', 'James Willson', 'jkw053000', 'Monday & Wednesday 8:30am - 9:45am', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(143, '25S', 'CS 4349.003', 'Advanced Algorithm Design and Analysis (3 Semester Credit Hours)', 'Ding Du', 'dxd056000', 'Tuesday & Thursday 4:00pm - 5:15pm', 'ECSW 1.355', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(144, '25S', 'CS 4349.004', 'Advanced Algorithm Design and Analysis (3 Semester Credit Hours)', 'Bhadrachalam Chitturi', 'chalam', 'Tuesday & Thursday 2:30pm - 3:45pm', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(145, '25S', 'CS 4349.005', 'Advanced Algorithm Design and Analysis (3 Semester Credit Hours)', 'Serdar Erbatur', 'sxe190003', 'Tuesday & Thursday 2:30pm - 3:45pm', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(146, '25S', 'CS 4349.006', 'Advanced Algorithm Design and Analysis (3 Semester Credit Hours)', 'Bhadrachalam Chitturi', 'chalam', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSS 2.306', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(147, '25S', 'CS 4349.007', 'Advanced Algorithm Design and Analysis (3 Semester Credit Hours)', 'Parisa Darbari', 'dal776869', 'Monday & Wednesday 4:00pm - 5:15pm', 'ECSS 2.203', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(148, '25S', 'CS 4352.001', 'Introduction to Human-Computer Interaction (3 Semester Credit Hours)', 'Erika Orrick', 'edo042000', 'Monday 4:00pm - 6:45pm', 'CRA 12.110', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(149, '25S', 'CS 4361.001', 'Computer Graphics (3 Semester Credit Hours)', 'Pushpa Kumar', 'pkumar', 'Monday & Wednesday 11:30am - 12:45pm', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(150, '25S', 'CS 4365.001', 'Artificial Intelligence (3 Semester Credit Hours)', 'Sanda Harabagiu', 'sanda', 'Monday & Wednesday 2:30pm - 3:45pm', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(151, '25S', 'CS 4365.002', 'Artificial Intelligence (3 Semester Credit Hours)', 'Yu Chung Ng', 'ycn041000', 'Monday & Wednesday 4:00pm - 5:15pm', 'ECSW 1.355', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(152, '25S', 'CS 4365.003', 'Artificial Intelligence (3 Semester Credit Hours)', 'Vibhav Gogate', 'vxg112130', 'Tuesday & Thursday 8:30am - 9:45am', 'ECSW 1.355', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(153, '25S', 'CS 4365.004', 'Artificial Intelligence (3 Semester Credit Hours)', 'Vlad Birsan', 'vib220000', 'Tuesday & Thursday 4:00pm - 5:15pm', 'SLC 1.102', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(154, '25S', 'CS 4365.501', 'Artificial Intelligence (3 Semester Credit Hours)', 'Haim Schweitzer', 'haim', 'Tuesday & Thursday 5:30pm - 6:45pm', 'GR 2.302', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(155, '25S', 'CS 4365.hon', 'Artificial Intelligence - Honors (3 Semester Credit Hours)', 'Yu Chung Ng', 'ycn041000', 'Monday & Wednesday 5:30pm - 6:45pm', 'ECSN 2.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(156, '25S', 'CS 4375.001', 'Introduction to Machine Learning (3 Semester Credit Hours)', 'Sriraam Natarajan', 'sxn177430', 'Tuesday & Thursday 1:00pm - 2:15pm', 'JO 3.601', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(157, '25S', 'CS 4375.002', 'Introduction to Machine Learning (3 Semester Credit Hours)', 'Feng Chen', 'fxc190007', 'Monday & Wednesday 2:30pm - 3:45pm', 'HH 2.502', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(158, '25S', 'CS 4375.003', 'Introduction to Machine Learning (3 Semester Credit Hours)', 'Rishabh Iyer', 'rki190000', 'Tuesday & Thursday 4:00pm - 5:15pm', 'MC 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(159, '25S', 'CS 4375.004', 'Introduction to Machine Learning (3 Semester Credit Hours)', 'Tahrima Rahman', 'txr110830', 'Tuesday & Thursday 1:00pm - 2:15pm', 'JO 4.614', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(160, '25S', 'CS 4375.501', 'Introduction to Machine Learning (3 Semester Credit Hours)', 'Erick Skorupa Parolin', 'exs172930', 'Tuesday & Thursday 7:00pm - 8:15pm', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(161, '25S', 'CS 4376.001', 'Object-Oriented Design (3 Semester Credit Hours)', 'Mark Paulk', 'mcp130030', 'Tuesday & Thursday 8:30am - 9:45am', 'MC 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(162, '25S', 'CS 4376.002', 'Object-Oriented Design (3 Semester Credit Hours)', 'Mark Paulk', 'mcp130030', 'Tuesday & Thursday 4:00pm - 5:15pm', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(163, '25S', 'CS 4384.001', 'Automata Theory (3 Semester Credit Hours)', 'Bhadrachalam Chitturi', 'chalam', 'Tuesday & Thursday 10:00am - 11:15am', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(164, '25S', 'CS 4384.002', 'Automata Theory (3 Semester Credit Hours)', 'Simeon Ntafos', 'ntafos', 'Monday & Wednesday 4:00pm - 5:15pm', 'GR 3.420', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(165, '25S', 'CS 4384.003', 'Automata Theory (3 Semester Credit Hours)', 'Serdar Erbatur', 'sxe190003', 'Monday & Wednesday 4:00pm - 5:15pm', 'ECSW 1.315', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(166, '25S', 'CS 4384.004', 'Automata Theory (3 Semester Credit Hours)', 'Serdar Erbatur', 'sxe190003', 'Tuesday & Thursday 10:00am - 11:15am', 'MC 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(167, '25S', 'CS 4384.501', 'Automata Theory (3 Semester Credit Hours)', 'Zachary Stallbohm', 'zxs110030', 'Monday & Wednesday 5:30pm - 6:45pm', 'GR 2.302', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(168, '25S', 'CS 4384.502', 'Automata Theory (3 Semester Credit Hours)', 'Simeon Ntafos', 'ntafos', 'Monday & Wednesday 5:30pm - 6:45pm', 'GR 3.420', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(169, '25S', 'CS 4384.hon', 'Automata Theory - Honors (3 Semester Credit Hours)', 'Dung Huynh', 'huynh', 'Tuesday & Thursday 1:00pm - 2:15pm', 'AD 3.216', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(170, '25S', 'CS 4386.501', 'Compiler Design (3 Semester Credit Hours)', 'Neeraj Gupta', 'nkg140130', 'Tuesday & Thursday 5:30pm - 6:45pm', 'ECSS 2.201', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(171, '25S', 'CS 4390.001', 'Computer Networks (3 Semester Credit Hours)', 'Nidhiben Solanki', 'nxs121130', 'Tuesday & Thursday 2:30pm - 3:45pm', 'MC 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(172, '25S', 'CS 4390.002', 'Computer Networks (3 Semester Credit Hours)', 'Zygmunt Haas', 'zjh130030', 'Monday & Wednesday 1:00pm - 2:15pm', 'HH 2.502', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(173, '25S', 'CS 4390.003', 'Computer Networks (3 Semester Credit Hours)', 'Nidhiben Solanki', 'nxs121130', 'Tuesday & Thursday 10:00am - 11:15am', 'ECSS 2.201', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(174, '25S', 'CS 4390.004', 'Computer Networks (3 Semester Credit Hours)', 'Yi Ding', 'yxd230004', 'Tuesday & Thursday 11:30am - 12:45pm', 'CR 1.202', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(175, '25S', 'CS 4390.005', 'Computer Networks (3 Semester Credit Hours)', 'Zygmunt Haas', 'zjh130030', 'Monday & Wednesday 10:00am - 11:15am', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(176, '25S', 'CS 4391.002', 'Introduction to Computer Vision (3 Semester Credit Hours)', 'Ranran Feng', 'rxf090020', 'Monday & Wednesday 10:00am - 11:15am', 'ECSS 2.203', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(177, '25S', 'CS 4393.001', 'Computer and Network Security (3 Semester Credit Hours)', 'Nhut Nguyen', 'nhutnn', 'Tuesday & Thursday 1:00pm - 2:15pm', 'FO 2.208', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(178, '25S', 'CS 4395.002', 'Human Language Technologies (3 Semester Credit Hours)', 'Xinya Du', 'xxd220001', 'Monday & Wednesday 11:30am - 12:45pm', 'ECSW 1.315', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(179, '25S', 'CS 4396.001', 'Networking Laboratory (3 Semester Credit Hours)', 'Kamil Sarac', 'kxs028100', 'Friday 10:00am - 12:45pm', 'ECSW 1.355', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(180, '25S', 'CS 4459.001', 'Cyber Attack and Defense Laboratory (4 Credits)', 'Kangkook Jee', 'kxj190011', 'Tuesday & Thursday 4:00pm - 6:15pm', 'ECSS 2.311', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(181, '25S', 'CS 4475.001', 'Capstone Project (4 Credits)', 'Kemelli Estacio-Hiroms', 'kxe160930', 'Friday 8:30am - 11:15am', 'AD 2.232', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(182, '25S', 'CS 4485.0w1', 'Computer Science Project (4 Credits)', 'Miguel Razo Razo', 'mrazora', 'Tuesday 1:00pm - 2:15pm', 'No Meeting Room', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(183, '25S', 'CS 4v98.001', 'Undergraduate Research in Computer Science (1-9 Credits)', 'Yapeng Tian', 'yxt220013', 'Friday 4:00pm - 6:45pm', 'CB 1.106', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(184, '25S', 'CS 4v98.054', 'Undergraduate Research in Computer Science - Design of Robotics Systems (1-9 Credits)', 'Yonas Tadesse', 'ytt110030', 'None', '', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(185, '25S', 'CS 4v98.094', 'Undergraduate Research in Computer Science - Al and Machine Learning Rsrch (1-9 Credits)', 'Yu Chung Ng', 'ycn041000', 'None', '', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(186, '25S', 'CS 4v98.095', 'Undergraduate Research in Computer Science - Rsrch on Software Traceability (1-9 Credits)', 'None', 'None', 'None', '', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(187, '25S', 'CS 5333.001', 'Discrete Structures (3 Semester Credit Hours)', 'Jorge Cobb', 'jcobb', 'Tuesday & Thursday 2:30pm - 3:45pm', 'AD 3.216', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(188, '25S', 'CS 5343.001', 'Algorithm Analysis and Data Structures (3 Semester Credit Hours)', 'Neeraj Gupta', 'nkg140130', 'Tuesday & Thursday 4:00pm - 5:15pm', 'JO 3.601', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(189, '25S', 'CS 5348.004', 'Operating Systems Concepts (3 Semester Credit Hours)', 'Neeraj Mittal', 'nxm020100', 'Monday & Wednesday 1:00pm - 2:15pm', 'JO 4.614', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(190, '25S', 'CS 5349.003', 'Automata Theory (3 Semester Credit Hours)', 'Serdar Erbatur', 'sxe190003', 'Monday & Wednesday 4:00pm - 5:15pm', 'ECSW 1.315', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(191, '25S', 'CS 5390.003', 'Computer Networks (3 Semester Credit Hours)', 'Nidhiben Solanki', 'nxs121130', 'Tuesday & Thursday 10:00am - 11:15am', 'ECSS 2.201', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(192, '25S', 'CS 5v81.001', 'Special Topics in Computer Science - Sfs Seminar (1 Semester Credit Hour)', 'Kamil Sarac', 'kxs028100', 'Saturday 10:00am - 12:45pm', 'ECSN 2.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(193, '25S', 'CS 6301.001', 'Special Topics in Computer Science - Quantum Computing (3 Semester Credit Hours)', 'Andrew Nemec', 'dal957114', 'Monday & Wednesday 4:00pm - 5:15pm', 'HH 2.502', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(194, '25S', 'CS 6304.001', 'Computer Architecture (3 Semester Credit Hours)', 'Hossein Pedram', 'hxp220048', 'Monday & Wednesday 11:30am - 12:45pm', 'GR 3.606', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(195, '25S', 'CS 6305.501', 'Data Security and Privacy for Practitioners (3 Semester Credit Hours)', 'Ebru Cankaya', 'exc067000', 'Monday 5:30pm - 8:15pm', 'ECSS 2.201', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(196, '25S', 'CS 6307.501', 'Introduction to Big Data Management and Analytics for non CS-Majors (3 Semester Credit Hours)', 'Anurag Nagar', 'axn112530', 'Monday & Wednesday 5:30pm - 6:45pm', 'AD 3.216', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(197, '25S', 'CS 6308.501', 'Cyber Physical Systems and Critical Infrastructure Security for Practitioners (3 Semester Credit Hours)', 'Brian Ricks', 'bwr031000', 'Monday & Wednesday 5:30pm - 6:45pm', 'CR 1.202', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(198, '25S', 'CS 6313.001', 'Statistical Methods for Data Science (3 Semester Credit Hours)', 'Xiwei Tang', 'dal295425', 'Tuesday & Thursday 10:00am - 11:15am', 'ECSS 2.305', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(199, '25S', 'CS 6314.501', 'Web Programming Languages (3 Semester Credit Hours)', 'Richard Min', 'rkm010300', 'Tuesday & Thursday 5:30pm - 6:45pm', 'ECSS 2.412', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(200, '25S', 'CS 6319.001', 'Computational Geometry (3 Semester Credit Hours)', 'Benjamin Raichel', 'bar150630', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSN 2.112', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(201, '25S', 'CS 6320.001', 'Natural Language Processing (3 Semester Credit Hours)', 'Tatiana Erekhinskaya', 'txe110230', 'Tuesday & Thursday 2:30pm - 3:45pm', 'ECSW 1.315', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(202, '25S', 'CS 6320.002', 'Natural Language Processing (3 Semester Credit Hours)', 'Zhiyu Chen', 'zxc230011', 'Monday & Wednesday 2:30pm - 3:45pm', 'AD 3.216', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(203, '25S', 'CS 6322.001', 'Information Retrieval (3 Semester Credit Hours)', 'Sanda Harabagiu', 'sanda', 'Monday & Wednesday 4:00pm - 5:15pm', 'ECSS 2.311', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(204, '25S', 'CS 6324.001', 'Information Security (3 Semester Credit Hours)', 'Chung Hwan Kim', 'cxk200010', 'Monday & Wednesday 4:00pm - 5:15pm', 'GR 2.530', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(205, '25S', 'CS 6334.001', 'Virtual Reality (3 Semester Credit Hours)', 'Jin Ryong Kim', 'jrk200002', 'Monday & Wednesday 11:30am - 12:45pm', 'JO 3.601', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(206, '25S', 'CS 6347.001', 'Statistical Methods in AI and Machine Learning (3 Semester Credit Hours)', 'Nicholas Ruozzi', 'nrr150130', 'Tuesday & Thursday 10:00am - 11:15am', 'GR 2.530', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(207, '25S', 'CS 6348.001', 'Data and Applications Security (3 Semester Credit Hours)', 'Ebru Cankaya', 'exc067000', 'Monday & Wednesday 2:30pm - 3:45pm', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(208, '25S', 'CS 6349.501', 'Network Security (3 Semester Credit Hours)', 'Shuang Hao', 'sxh178730', 'Monday & Friday 5:30pm - 6:45pm', 'SCI 1.210', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(209, '25S', 'CS 6350.001', 'Big Data Management and Analytics (3 Semester Credit Hours)', 'Anurag Nagar', 'axn112530', 'Monday & Wednesday 11:30am - 12:45pm', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(210, '25S', 'CS 6350.002', 'Big Data Management and Analytics (3 Semester Credit Hours)', 'Anurag Nagar', 'axn112530', 'Tuesday & Thursday 4:00pm - 5:15pm', 'ECSS 2.415', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(211, '25S', 'CS 6352.001', 'Performance of Computer Systems and Networks (3 Semester Credit Hours)', 'Jason Jue', 'jjue', 'Tuesday & Thursday 10:00am - 11:15am', 'ECSS 3.910', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(212, '25S', 'CS 6353.001', 'Compiler Construction (3 Semester Credit Hours)', 'Shiyi Wei', 'sxw174630', 'Monday & Wednesday 10:00am - 11:15am', 'FN 2.214', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(213, '25S', 'CS 6356.001', 'Software Maintenance Evolution and Re-Engineering (3 Semester Credit Hours)', 'Shiyi Wei', 'sxw174630', 'Monday & Wednesday 8:30am - 9:45am', 'ECSS 2.203', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(214, '25S', 'CS 6359.001', 'Object-Oriented Analysis and Design (3 Semester Credit Hours)', 'Rym Zalila-Wenkstern', 'rmili', 'Tuesday & Thursday 4:00pm - 5:15pm', 'ECSS 2.201', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(215, '25S', 'CS 6360.002', 'Database Design (3 Semester Credit Hours)', 'Wei Wu', 'wxw020100', 'Monday & Wednesday 1:00pm - 2:15pm', 'JO 3.601', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(216, '25S', 'CS 6361.001', 'Advanced Requirements Engineering (3 Semester Credit Hours)', 'Lawrence Chung', 'chung', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSS 2.312', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(217, '25S', 'CS 6363.001', 'Design and Analysis of Computer Algorithms (3 Semester Credit Hours)', 'Dung Huynh', 'huynh', 'Tuesday & Thursday 10:00am - 11:15am', 'ECSS 2.311', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(218, '25S', 'CS 6363.501', 'Design and Analysis of Computer Algorithms (3 Semester Credit Hours)', 'Sergey Bereg', 'sxb027100', 'Monday & Wednesday 5:30pm - 6:45pm', 'ECSS 2.203', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(219, '25S', 'CS 6363.502', 'Design and Analysis of Computer Algorithms (3 Semester Credit Hours)', 'Ding Du', 'dxd056000', 'Tuesday & Thursday 5:30pm - 6:45pm', 'ECSS 2.203', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(220, '25S', 'CS 6364.001', 'Artificial Intelligence (3 Semester Credit Hours)', 'Haim Schweitzer', 'haim', 'Tuesday & Thursday 4:00pm - 5:15pm', 'GR 3.420', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(221, '25S', 'CS 6366.001', 'Computer Graphics (3 Semester Credit Hours)', 'Xiaohu Guo', 'xxg061000', 'Monday & Wednesday 10:00am - 11:15am', 'CR 1.202', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(222, '25S', 'CS 6367.001', 'Software Testing Validation and Verification (3 Semester Credit Hours)', 'Mehra Nouroz Borazjany', 'mxn143230', 'Tuesday & Thursday 2:30pm - 3:45pm', 'ECSS 2.306', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(223, '25S', 'CS 6371.002', 'Advanced Programming Languages - Adv Programming Languages (3 Semester Credit Hours)', 'Kevin Hamlen', 'kxh060100', 'Tuesday & Thursday 1:00pm - 2:15pm', 'FN 2.202', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(224, '25S', 'CS 6375.001', 'Machine Learning (3 Semester Credit Hours)', 'Wei Yang', 'wxy180002', 'Monday & Wednesday 2:30pm - 3:45pm', 'ECSW 1.365', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(225, '25S', 'CS 6375.002', 'Machine Learning (3 Semester Credit Hours)', 'Crystal Maung', 'ktm016100', 'Saturday 11:00am - 1:45pm', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(226, '25S', 'CS 6378.001', 'Advanced Operating Systems (3 Semester Credit Hours)', 'Ravi Prakash', 'ravip', 'Tuesday & Thursday 8:30am - 9:45am', 'GR 2.530', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(227, '25S', 'CS 6384.001', 'Computer Vision (3 Semester Credit Hours)', 'Yapeng Tian', 'yxt220013', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSS 2.410', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(228, '25S', 'CS 6384.003', 'Computer Vision (3 Semester Credit Hours)', 'Yunhui Guo', 'yxg220013', 'Tuesday & Thursday 11:30am - 12:45pm', 'ECSS 3.910', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(229, '25S', 'CS 6396.001', 'Real-Time Systems (3 Semester Credit Hours)', 'Farokh Bastani', 'bastani', 'Tuesday & Thursday 10:00am - 11:15am', 'SLC 1.204', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(230, '25S', 'CS 6v81.082', 'Independent Study in Computer Science (1-9 Credits)', 'Jin Ryong Kim', 'jrk200002', 'None', '', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(231, '25S', 'CS 6v81.099', 'Independent Study in Computer Science (1-9 Credits)', 'Chung Hwan Kim', 'cxk200010', 'None', '', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(232, '25S', 'CS 6v98.099', 'Thesis (3-9 Credits)', 'Chung Hwan Kim', 'cxk200010', 'None', '', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(233, '25S', 'CS 7301.001', 'Recent Advances in Computing - Recent Advances in Networking (3 Semester Credit Hours)', 'Ravi Prakash', 'ravip', 'Tuesday & Thursday 1:00pm - 2:15pm', 'AD 2.232', '2025-03-17 23:36:57', '2025-03-17 23:36:57');
INSERT INTO `course1` (`id`, `year_semester`, `course_number`, `course_title`, `instructor_name`, `instructor_netid`, `date_time`, `location`, `created_at`, `updated_at`) VALUES
(234, '25S', 'CS 7301.501', 'Recent Advances in Computing - Trustworthy Ai and Application (3 Semester Credit Hours)', 'Latifur Khan', 'lkhan', 'Tuesday & Thursday 5:30pm - 6:45pm', 'CR 1.202', '2025-03-17 23:36:57', '2025-03-17 23:36:57'),
(235, '25S', 'CS 8v99.059', 'Dissertation (1-9 Credits)', 'Yu Xiang', 'yxx210005', 'None', '', '2025-03-17 23:36:57', '2025-03-17 23:36:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course1`
--
ALTER TABLE `course1`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `course1`
--
ALTER TABLE `course1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=236;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
