
CREATE DATABASE MyCollege;

USE MyCollege;

CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseNumber INT,
    CourseDescription VARCHAR(50) NOT NULL,
    CourseUnits INT NOT NULL,
    DepartmentID INT NOT NULL,
    InstructorID INT NOT NULL
);

CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(40)
);

CREATE TABLE Instructors (
    InstructorID INT AUTO_INCREMENT PRIMARY KEY,
    LastName VARCHAR(25) NOT NULL,
    FirstName VARCHAR(25),
    Status CHAR(1) NOT NULL,
    DepartmentChairman BOOLEAN NOT NULL,
    HireDate DATE,
    AnnualSalary DECIMAL(10,2) NOT NULL,
    DepartmentID INT NOT NULL
);

CREATE TABLE StudentCourses (
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    PRIMARY KEY (StudentID, CourseID)
);

CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    LastName VARCHAR(25) NOT NULL,
    FirstName VARCHAR(25) NOT NULL,
    EnrollmentDate DATETIME NOT NULL,
    GraduationDate DATE
);

CREATE TABLE Tuition (
    PartTimeCost DECIMAL(10,2) NOT NULL,
    FullTimeCost DECIMAL(10,2) NOT NULL,
    PerUnitCost DECIMAL(10,2) NOT NULL
);

INSERT INTO Courses (CourseNumber, CourseDescription, CourseUnits, DepartmentID, InstructorID) VALUES
(36598, 'Beginning Accounting', 3, 1, 1),
(48926, 'Abstract Algebra', 3, 4, 5),
(14862, 'Primary Education', 3, 2, 8);


INSERT INTO Departments (DepartmentName) VALUES
('Business'),
('Education'),
('English');


INSERT INTO Instructors (LastName, FirstName, Status, DepartmentChairman, HireDate, AnnualSalary, DepartmentID) VALUES
('Brown', 'Billy', 'F', 1, '2016-01-10', 77500.00, 1),
('Thomas', 'William', 'P', 0, '2016-03-30', 38500.00, 3),
('Amundsen', 'Rachel', 'F', 1, '2016-06-05', 79000.00, 6);


INSERT INTO StudentCourses (StudentID, CourseID) VALUES
(5, 10),
(5, 12),
(5, 15);


INSERT INTO Students (LastName, FirstName, EnrollmentDate, GraduationDate) VALUES
('Howard', 'Amber', '2015-12-18 16:44:26', '2019-12-14'),
('White', 'George', '2015-12-20 11:12:26', '2019-12-14'),
('MacNamara', 'Tony', '2015-12-21 09:21:55', '2019-05-07');

