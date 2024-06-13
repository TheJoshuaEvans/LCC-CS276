USE [RealTimeWW2];

-- REQUIRES
-- procedures/UspDeleteUserResources.sql

/*
  Deletes a user along with any other resources associated with that user
*/
DROP PROCEDURE IF EXISTS [UspDeleteUser];
GO
CREATE PROCEDURE [UspDeleteUser] @UserId INT = NULL AS
  BEGIN TRANSACTION
  BEGIN TRY
    EXEC [UspDeleteUserResources] @UserId;
    DELETE FROM [Users] WHERE UserId = @UserId;
  END TRY BEGIN CATCH
    ROLLBACK TRANSACTION
    THROW
  END CATCH
  COMMIT TRANSACTION
GO

GO
PRINT 'Should be able to delete a user with playlists and video types attached'
INSERT INTO [Users] (UserEmail, UserAlias) VALUES ('delete@user.test', 'Deletion Test');
DECLARE @UserId INT = @@IDENTITY;

INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 0);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 1);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 2);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (@UserId, 3);
INSERT INTO [UserPlaylists] (UserId, PlaylistId, UserPlaylistStartYear) VALUES (@UserId, 0, 2024);
INSERT INTO [UserPlaylists] (UserId, PlaylistId, UserPlaylistStartYear) VALUES (@UserId, 1, 2024);

EXEC [UspDeleteUser] @UserId;

DECLARE @MatchingUserCount INT = (SELECT COUNT(*) FROM [Users] WHERE UserId = @UserId);
IF NOT (@MatchingUserCount = 0) BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected user to be deleted. Selecting bad user and data...';
  SELECT * FROM [Users] WHERE UserId = @UserId;
  SELECT * FROM [UserVideoTypes] WHERE UserId = @UserId;
  SELECT * FROM [UserPlaylists] WHERE UserId = @UserId;
  THROW 1337000, @Msg, 1;
END;
