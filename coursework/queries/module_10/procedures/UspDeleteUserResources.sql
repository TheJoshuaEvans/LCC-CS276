USE [RealTimeWW2];

/*
  Deletes all resources associated with a user, but not the user itself
*/
DROP PROCEDURE IF EXISTS [UspDeleteUserResources];
GO
CREATE PROCEDURE [UspDeleteUserResources] @UserId INT = NULL AS
  BEGIN TRANSACTION
  BEGIN TRY
    DELETE FROM [Emails] WHERE UserId = @UserId;
    DELETE FROM [UserVideoTypes] WHERE UserId = @UserId;
    DELETE FROM [UserPlaylists] WHERE UserId = @UserId;
  END TRY BEGIN CATCH
    ROLLBACK TRANSACTION
    THROW
  END CATCH
  COMMIT TRANSACTION
GO

GO
PRINT 'Should be able to delete data of a user with playlists and video types attached'
INSERT INTO [Users] (UserEmail, UserAlias) VALUES ('deleteResources@user.test', 'Resource Deletion Test');
DECLARE @UserId INT = @@IDENTITY;

INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 0);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 1);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 2);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 3);
INSERT INTO [UserPlaylists] (UserId, PlaylistId, UserPlaylistStartYear) VALUES (@UserId, 0, 2024);
INSERT INTO [UserPlaylists] (UserId, PlaylistId, UserPlaylistStartYear) VALUES (@UserId, 1, 2024);

EXEC [UspDeleteUserResources] @UserId;

DECLARE @MatchingUserCount INT = (SELECT COUNT(*) FROM [Users] WHERE UserId = @UserId);
IF NOT (@MatchingUserCount = 1) BEGIN
  DECLARE @NoUserMsg VARCHAR(255) = 'Expected user to still exist. Selecting bad user and data...';
  SELECT * FROM [Users] WHERE UserId = @UserId;
  SELECT * FROM [UserVideoTypes] WHERE UserId = @UserId;
  SELECT * FROM [UserPlaylists] WHERE UserId = @UserId;
  THROW 1337000, @NoUserMsg, 1;
END;

DECLARE @MatchingResourceCount INT = 
  (SELECT COUNT(*) FROM [UserVideoTypes] WHERE UserId = @UserId) + 
  (SELECT COUNT(*) FROM [UserPlaylists] WHERE UserId = @UserId)
IF NOT (@MatchingResourceCount = 0) BEGIN
  DECLARE @Msg VARCHAR(255) = 'User resources still exist. Selecting bad user and data...';
  SELECT * FROM [Users] WHERE UserId = @UserId;
  SELECT * FROM [UserVideoTypes] WHERE UserId = @UserId;
  SELECT * FROM [UserPlaylists] WHERE UserId = @UserId;
  THROW 1337000, @Msg, 1;
END;

GO
PRINT 'Clean up'
DELETE FROM [Users] WHERE UserEmail = 'deleteResources@user.test';
