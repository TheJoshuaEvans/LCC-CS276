USE [RealTimeWW2];

-- REQUIRES
-- procedures/UspDeleteUser.sql

/*
  Replacement trigger that fires when deleting users. Will cause an error to be thrown if more
  than one user is being deleted at a time, and will automatically delete any resources
  associated with the user
*/
DROP TRIGGER IF EXISTS [OnDeleteUser];
GO
CREATE TRIGGER [OnDeleteUser] ON [Users] INSTEAD OF DELETE AS
  DECLARE @ToDeleteCount INT = (SELECT COUNT(*) FROM [deleted])
  IF @ToDeleteCount > 1 BEGIN
    DECLARE @Msg VARCHAR(255) = 
      'Cannot delete more than 1 user at a time. Attempting to delete ' + 
      CAST(@ToDeleteCount AS VARCHAR(20)) + ' users.';
    THROW 1025000, @Msg, 1;
  END;

  DECLARE @UserId INT = (SELECT UserId FROM [deleted]);
  EXEC [UspDeleteUserResources] @UserId;
  DELETE FROM [Users] WHERE UserId = @UserId;
GO

GO
PRINT 'Should be able to delete a user with playlists and video types attached'
INSERT INTO [Users] (UserEmail, UserAlias) VALUES ('deleteTrigger@user.test', 'Deletion Trigger Test');
DECLARE @UserId INT = @@IDENTITY;

INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 0);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 1);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 2);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 3);
INSERT INTO [UserPlaylists] (UserId, PlaylistId, UserPlaylistStartYear) VALUES (@UserId, 0, 2024);
INSERT INTO [UserPlaylists] (UserId, PlaylistId, UserPlaylistStartYear) VALUES (@UserId, 1, 2024);

DELETE FROM [Users] WHERE UserId = @UserId;

DECLARE @MatchingUserCount INT = (SELECT COUNT(*) FROM [Users] WHERE UserId = @UserId);
IF NOT (@MatchingUserCount = 0) BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected user to be deleted. Selecting bad user and data...';
  SELECT * FROM [Users] WHERE UserId = @UserId;
  SELECT * FROM [UserVideoTypes] WHERE UserId = @UserId;
  SELECT * FROM [UserPlaylists] WHERE UserId = @UserId;
  THROW 1337000, @Msg, 1;
END;

GO
PRINT 'Should not be able to delete multiple users at once'
BEGIN TRY
  DELETE FROM [Users];
  THROW 1337000, 'Should have thrown an error', 1;
END TRY BEGIN CATCH
  IF ERROR_NUMBER() != 1025000 BEGIN
    PRINT 'Should have thrown custom error, throwing original error...';
    THROW
  END;
END CATCH

GO
PRINT 'Clean up';
DELETE [Users] WHERE UserEmail = 'onUpdateUser@email.com';
DELETE [Users] WHERE UserEmail = 'test@email.com';
