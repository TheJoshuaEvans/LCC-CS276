-- Practice activity 5 part 2

USE MyCollege;

DECLARE @StudentID INT;
DECLARE @CourseID INT;

SET @CourseID = 12;

BEGIN TRY
  BEGIN TRAN

  INSERT Students VALUES ('Smith', 'John', GETDATE(), NULL);

  SET @StudentID = @@IDENTITY;

  INSERT StudentCourses VALUES (@StudentID, @CourseID);

  COMMIT TRAN
END TRY
BEGIN CATCH
  PRINT 'Rolling back transaction';
  ROLLBACK TRAN
END CATCH
