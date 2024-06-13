USE [RealTimeWW2];

-- REQUIRES
-- procedures/UspUpdateUserVideoTypes.sql

/*
  Procedure that can be used to create a new user at the same time as their video types, since
  the default behavior will be subscribing to all the video types.
*/
DROP PROCEDURE IF EXISTS [UspCreateUser];
GO
CREATE PROCEDURE [UspCreateUser]
  @UserEmail VARCHAR(320),
  @UserAlias VARCHAR(1024),
  @UserVideoTypes VARCHAR(255) = NULL
AS
  BEGIN TRANSACTION
  BEGIN TRY
    -- First insert the user
    INSERT INTO [Users] (UserEmail, UserAlias) VALUES (@UserEmail, @UserAlias);
    DECLARE @UserId INT = @@IDENTITY;
    
    -- Only add user video types if we were given video types to add
    IF @UserVideoTypes IS NOT NULL BEGIN
      EXEC [UspUpdateUserVideoTypes] @UserId, @UserVideoTypes;
    END;
  END TRY BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH
  COMMIT TRANSACTION;
GO

GO
PRINT 'Should be able to add a user with many video types'
EXEC [UspCreateUser] 'createUser@email.com', 'some alias', '0,1,2,3';

DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'createUser@email.com');

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
PRINT 'Clean up'
DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'createUser@email.com');
EXEC [UspDeleteUser] @UserId;

GO
PRINT 'Should be able to add a user with no video types'
EXEC [UspCreateUser] 'createUser@email.com', 'some alias';

DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'createUser@email.com');
IF @UserId IS NULL BEGIN
  DECLARE @NullErrMsg VARCHAR(255) = 'Got null User ID - User was not created';
  THROW 1337000, @NullErrMsg, 1;
END;

DECLARE @UserVideoTypeCount INT = (SELECT COUNT(*) FROM [UserVideoTypes] WHERE UserId = @UserId);
IF NOT (@UserVideoTypeCount = 0) BEGIN
  DECLARE @Msg VARCHAR(255) = 
    'Expected 0 video types, got ' + CAST(@UserVideoTypeCount AS VARCHAR(255)) +
    '. Selecting tables...';
  SELECT * FROM [Users] WHERE UserId = @UserId;
  SELECT * FROM [UserVideoTypes] WHERE UserId = @UserId;
  THROW 1337000, @Msg, 1;
END;

GO
PRINT 'Clean up'
DECLARE @UserId INT = (SELECT UserId FROM [Users] WHERE UserEmail = 'createUser@email.com');
EXEC [UspDeleteUser] @UserId;

