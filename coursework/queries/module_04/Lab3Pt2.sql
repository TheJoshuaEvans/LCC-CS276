USE MurachCollege;

-- SECTION 1: Create a view
DROP VIEW IF EXISTS DepartmentInstructors;
GO
CREATE VIEW DepartmentInstructors(
  DepartmentName,
  LastName, FirstName, Status, AnnualSalary
) AS
SELECT
  DepartmentName,
  LastName, FirstName, Status, AnnualSalary
FROM Instructors, Departments
WHERE Instructors.DepartmentID = Departments.DepartmentID;
GO

-- SECTION 2: Select from the view
SELECT * FROM DepartmentInstructors
WHERE DepartmentName = 'English';
GO

-- SECTION 3: Update the view and verify
SELECT * FROM DepartmentInstructors
WHERE DepartmentName = 'English';

UPDATE DepartmentInstructors
SET AnnualSalary = AnnualSalary * 1.1
WHERE DepartmentName = 'English';

SELECT * FROM DepartmentInstructors
WHERE DepartmentName = 'English';
GO

-- SECTION 4: Create another view
DROP VIEW IF EXISTS StudentCoursesMin;
GO
CREATE VIEW StudentCoursesMin(
  FirstName, LastName,
  CourseNumber, CourseDescription, CourseUnits
) AS
SELECT
  FirstName, LastName,
  CourseNumber, CourseDescription, CourseUnits
FROM Students, Courses, StudentCourses
WHERE
  StudentCourses.CourseID = Courses.CourseID AND
  StudentCourses.StudentID = Students.StudentID;
GO

-- SECTION 5: Select form the view
SELECT DISTINCT CourseDescription, LastName, FirstName  
FROM StudentCoursesMin
WHERE StudentCoursesMin.CourseUnits = 3
ORDER BY LastName ASC, FirstName ASC

-- SECTION 6: Create a student course summary
DROP VIEW IF EXISTS StudentCoursesSummary;
GO
CREATE VIEW StudentCoursesSummary AS
SELECT
  FirstName, LastName,
  (
    SELECT COUNT(*)
    FROM StudentCoursesMin as InnerStudentCourseMin
    WHERE
      OuterStudentCoursesMin.FirstName = InnerStudentCourseMin.FirstName AND
      OuterStudentCoursesMin.LastName = InnerStudentCourseMin.LastName
  ) AS CourseCount,
  (
    SELECT SUM(InnerStudentCourseMin.CourseUnits)
    FROM StudentCoursesMin as InnerStudentCourseMin
    WHERE
      OuterStudentCoursesMin.FirstName = InnerStudentCourseMin.FirstName AND
      OuterStudentCoursesMin.LastName = InnerStudentCourseMin.LastName
  ) AS UnitsTotal
FROM StudentCoursesMin AS OuterStudentCoursesMin
GROUP BY LastName, FirstName
GO

SELECT * FROM StudentCoursesMin;
SELECT * FROM StudentCoursesSummary;
