/*
	Author: Joshua Evans
	Description:  Practice Activity 1 - Examples
*/

-- WORKING WITH FUNCTIONS AND DATA TYPES
/*
1. Write a SELECT statement that returns these columns from the Instructors table:
	The monthly salary (AnnualSalary column divided by 12)
	A column that uses the CAST function to return the monthly salary with 1 digit to the right of the decimal point
	A column that uses the CONVERT function to return the monthly salary as an integer
	A column that uses the CAST function to return the monthly salary as an integer
*/
SELECT
	AnnualSalary / 12 AS MonthlySalary,
	CAST(AnnualSalary / 12 AS decimal(9, 1)) AS SalaryFormat,
	CONVERT(int, AnnualSalary / 12) AS SalaryConvert,
	CAST(AnnualSalary / 12 AS int) AS SalaryCast
FROM Instructors;

/*
2. Write a SELECT statement that returns these columns from the Students table:
	The EnrollmentDate column
	A column that uses the CAST function to return the EnrollmentDate column with tits date only (year, month, and day)
	A column that uses the CAST function to return the EnrollmentDate column with its full time only (hours, minutes, seconds, and milliseconds)
	A column that uses the CONVERT function to return the EnrollmentDate column with just the year and month
*/
SELECT
	EnrollmentDate,
	CAST(EnrollmentDate AS DATE) AS DateEnrolled,
	CAST(EnrollmentDate AS TIME) AS TimeEnrolled,
	CONVERT(CHAR(7), EnrollmentDate, 0) AS EnrolledChar7,
	(CAST(YEAR(EnrollmentDate) AS VARCHAR) + '-' + RIGHT('0' + CAST(MONTH(EnrollmentDate) AS VARCHAR), 2)) AS YearMonthEnrolled
FROM Students;

/*
3. Write a SELECT statement that returns these columns from the Students table:
	A column that uses the CONVERT function to return the EnrollmentDate column in this format:
		MM/DD/YYY. In other words, use 2-digit months and days and a 4 digit year and separate each date component with slashes
	A column that uses the CONVERT function to reutrn the EnrollmentDate column with the date,
		and the hours, and minutes on a 12-hour clock with an am/pm indicator
	A column that uses the CONVERT function to return the EnrollmentDate column with just the time in a 24-hour format, including milliseconds
	A column that uses the CONVERT function to return just the month and day
*/
SELECT
	EnrollmentDate,
	CONVERT(VARCHAR, EnrollmentDate, 1) AS DateEnrolledConverted,
	CONVERT(VARCHAR, EnrollmentDate, 100) AS AMPM,
	CONVERT(VARCHAR, EnrollmentDate, 14) AS TimeEnrolled,
	CONVERT(CHAR(7), EnrollmentDate, 0) AS EnrolledChar7
FROM Students

-- WORKING WITH FUNCTIONS
/*
4. Write a SELECT statement that returns these columns from the Instructors table:
	The AnnualSalary column
	A column named MonthlySalary
	A column named MonthlySalaryRounded using the ROUND function to round to the nearest 2 decimals
*/
SELECT
	AnnualSalary,
	AnnualSalary / 12 AS MonthlySalary,
	ROUND(AnnualSalary / 12, 2) AS MonthlySalaryRounded
FROM Instructors

/*
5. Write a SELECT statement for the Students table:
	The EnrollmentDate column
	The 4 Digit year that is stored in the EnrollmentDate
	The day of the month in EnrollmentDate
	The result of adding 4 years to the EnrollmentDate, using CAST so only the year is returned
*/
SELECT
	EnrollmentDate,
	YEAR(EnrollmentDate) AS EnrollmentYear,
	DAY(EnrollmentDate) AS EnrollmentDay,
	CAST(DateADD(YEAR, 4, EnrollmentDate) AS CHAR(4)) AS GraduationYear,
	YEAR(DateADD(YEAR, 4, EnrollmentDate)) AS GraduationYearNoCast
FROM Students;

/*
6. SELECT that returns:
	DepartmentName from Departments
	CourseNumber from Courses
	FirstName from Instructors
	LastName from Instructors
	Add a column that includes the first three characters from the DepartmentName column in uppercase,
		concatenated with the CourseNumber column, the first character of the FirstName column if this column
		isn't null or an empty string otherwise, and the LastName column.
		For this to work, CourseNumber needs to be cast into CHAR
*/
SELECT
	DepartmentName,
	CourseNumber,
	FirstName,
	LastName,
	UPPER(LEFT(DepartmentName, 3)) +
		CAST(CourseNumber AS CHAR(5)) +
		IIF(FirstName IS NOT NULL, LEFT(FirstName, 1), '') +
		LastName AS CourseCods
FROM 
	Departments d
	JOIN Courses c ON d.DepartmentID = c.DepartmentID
	JOIN Instructors i ON i.InstructorID = c.InstructorID
