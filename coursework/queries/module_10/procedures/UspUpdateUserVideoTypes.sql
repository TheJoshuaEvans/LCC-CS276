USE [RealTimeWW2];

/*
  Procedure that updates the video types associated with a user. Takes a user ID and a comma
  delimited list of video type IDs
*/
DROP PROCEDURE IF EXISTS [UspUpdateUserVideoTypes];
GO
CREATE PROCEDURE [UspUpdateUserVideoTypes]
  @UserId INT,
  @UserVideoTypes VARCHAR(255) = NULL
AS
  IF @UserVideoTypes = '' BEGIN;
    THROW 1025001, 'Cannot remove all video types from a user', 1;
  END;

  -- Split the user video types into a table so we can loop through them
  DECLARE @UserVideoTypesTable TABLE (value INT)
  INSERT INTO @UserVideoTypesTable SELECT * FROM STRING_SPLIT(@UserVideoTypes, ',');

  BEGIN TRANSACTION;
  BEGIN TRY
    -- Delete all the existing tables before adding the new ones
    DELETE FROM [UserVideoTypes] WHERE UserId = @UserId;

    WHILE EXISTS (SELECT * FROM @UserVideoTypesTable) BEGIN
      DECLARE @VideoTypeId INT = (SELECT TOP 1 value FROM @UserVideoTypesTable);
      INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, @VideoTypeId);

      DELETE @UserVideoTypesTable WHERE value = @VideoTypeId;
    END;
  END TRY BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH
  COMMIT TRANSACTION;
GO

GO
PRINT 'Set up'
EXEC [UspCreateUser] 'updateUserVideoTypes@email.com', 'some alias';

GO
PRINT 'Should add many video types to a user'
DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'updateUserVideoTypes@email.com');
EXEC [UspUpdateUserVideoTypes] @UserId, '0,1,2,3';

DECLARE @UserVideoTypeCount INT = (SELECT COUNT(*) FROM [UserVideoTypes] WHERE UserId = @UserId);
IF NOT (@UserVideoTypeCount = 4) BEGIN
  DECLARE @Msg VARCHAR(255) = 
    'Expected 4 video types, got ' + CAST(@UserVideoTypeCount AS VARCHAR(255)) +
    '. Selecting tables...';
  SELECT * FROM [Users] WHERE UserId = @UserId;
  SELECT * FROM [UserVideoTypes] WHERE UserId = @UserId;
  THROW 1337000, @Msg, 1;
END;

GO
PRINT 'Should remove video types from a user'
DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'updateUserVideoTypes@email.com');
EXEC [UspUpdateUserVideoTypes] @UserId, '0';

DECLARE @UserVideoTypeCount INT = (SELECT COUNT(*) FROM [UserVideoTypes] WHERE UserId = @UserId);
IF NOT (@UserVideoTypeCount = 1) BEGIN
  DECLARE @Msg VARCHAR(255) = 
    'Expected 1 video type, got ' + CAST(@UserVideoTypeCount AS VARCHAR(255)) +
    '. Selecting tables...';
  SELECT * FROM [Users] WHERE UserId = @UserId;
  SELECT * FROM [UserVideoTypes] WHERE UserId = @UserId;
  THROW 1337000, @Msg, 1;
END;

GO
PRINT 'Should not be able to remove all video types'
DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'updateUserVideoTypes@email.com');
BEGIN TRY
  EXEC [UspUpdateUserVideoTypes] @UserId, '';
  THROW 1337000, 'Should have thrown', 1;
END TRY BEGIN CATCH
  IF ERROR_NUMBER() != 1025001 BEGIN
    PRINT 'Should have thrown custom error. Throwing original error...';
    THROW;
  END;
END CATCH

-- GO
-- PRINT 'Should be able to add a user with many video types'
-- EXEC [UspUpdateUserVideoTypes] 'createUser@email.com', 'some alias', '0,1,2,3';

-- DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'createUser@email.com');



-- GO
-- PRINT 'Clean up'
-- DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'createUser@email.com');
-- EXEC [UspDeleteUser] @UserId;

-- GO
-- PRINT 'Should be able to add a user with no video types'
-- EXEC [UspUpdateUserVideoTypes] 'createUser@email.com', 'some alias';

-- DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'createUser@email.com');
-- IF @UserId IS NULL BEGIN
--   DECLARE @NullErrMsg VARCHAR(255) = 'Got null User ID - User was not created';
--   THROW 1337000, @NullErrMsg, 1;
-- END;

-- DECLARE @UserVideoTypeCount INT = (SELECT COUNT(*) FROM [UserVideoTypes] WHERE UserId = @UserId);
-- IF NOT (@UserVideoTypeCount = 0) BEGIN
--   DECLARE @Msg VARCHAR(255) = 
--     'Expected 0 video types, got ' + CAST(@UserVideoTypeCount AS VARCHAR(255)) +
--     '. Selecting tables...';
--   SELECT * FROM [Users] WHERE UserId = @UserId;
--   SELECT * FROM [UserVideoTypes] WHERE UserId = @UserId;
--   THROW 1337000, @Msg, 1;
-- END;

GO
PRINT 'Clean up'
DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'updateUserVideoTypes@email.com');
EXEC [UspDeleteUser] @UserId;
