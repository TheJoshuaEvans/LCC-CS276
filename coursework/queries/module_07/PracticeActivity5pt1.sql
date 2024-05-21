-- Practice Activity 5 part 1

USE MyCollege;

DECLARE @StudentID INT;
SET @StudentID = 10; -- Our target for deletion

BEGIN TRY
  BEGIN TRAN

  DELETE StudentCourses WHERE StudentID = @StudentID;
  DELETE Students WHERE StudentID = @StudentID;

  COMMIT TRAN;
END TRY
BEGIN CATCH
  ROLLBACK TRAN;
END CATCH

-- Alternate without scope bleed...
-- DECLARE @StudentID INT;
SET @StudentID = 10; -- Our target for deletion
BEGIN TRAN
  BEGIN TRY

    DELETE StudentCourses WHERE StudentID = @StudentID;
    DELETE Students WHERE StudentID = @StudentID;

    COMMIT TRAN;
  END TRY
  BEGIN CATCH
    ROLLBACK TRAN;
  END CATCH


