-- Based of the ERD found here:
-- https://lucid.app/documents/view/0c5c4c4f-23c9-40cc-ac58-064ccffd53d5

USE master;
GO

-- These lines can cause problems when performing development since the IDE creates a connection
-- to the database to help with auto-complete
DROP DATABASE IF EXISTS RealTimeWW2;
CREATE DATABASE RealTimeWW2; 
GO

USE [RealTimeWW2];

-- Because of the complex relationship between tables, it's best to delete them all up front
-- then create them together
DROP TABLE IF EXISTS [Emails];
DROP TABLE IF EXISTS [ConfigSets];
DROP TABLE IF EXISTS [UserVideoTypes];
DROP TABLE IF EXISTS [UserPlaylists];
DROP TABLE IF EXISTS [Users];
DROP TABLE IF EXISTS [BlockedUsers];
DROP TABLE IF EXISTS [PlaylistVideos];
DROP TABLE IF EXISTS [Playlists];
DROP TABLE IF EXISTS [Videos];
DROP TABLE IF EXISTS [VideoTypes];
DROP TABLE IF EXISTS [HistoricDates];

/* All the dates of the war with content, starting with 1939-09-01 */
CREATE TABLE [HistoricDates](
  -- The actual date
  HistoricDate DATE NOT NULL PRIMARY KEY,
  -- Note that gives some context for the historic date
  HistoricDateNote TEXT NULL
);

/* Static values used by the system to perform various actions */
CREATE TABLE [ConfigSets](
  -- ID of the config set. 0 is the "main" config
  ConfigSetId INT NOT NULL IDENTITY(0,1) PRIMARY KEY,
  -- URL of the header image used in the generated emails
  EmailHeaderImageLink VARCHAR(1024) NOT NULL,
  -- Secret passphrase used to generate the unsubscribe key for users
  UnsubscribeLinkSecret VARCHAR(255) NOT NULL,
  -- Secret passphrase used to generate the login key 
  UserLoginSecret VARCHAR(255) NOT NULL,
);

/*
  Takes an email address string and returns 1 if it is likely to be valid and 0 if it
  is invalid. Used as a constraint on all email fields
*/
DROP FUNCTION IF EXISTS IsEmailValid;
GO
CREATE FUNCTION IsEmailValid(@Email VARCHAR(320)) RETURNS BIT AS
BEGIN
  DECLARE @EmailLength INT = LEN(@Email);
  DECLARE @AtSymbolIndex INT = CHARINDEX('@', @Email);
  DECLARE @LastDotSymbolIndex INT = @EmailLength - CHARINDEX('.', REVERSE(@Email)) + 1;

  -- Check for missing characters
  IF @EmailLength = 0 BEGIN RETURN 'FALSE' END;
  IF @AtSymbolIndex = 0 BEGIN RETURN 'FALSE' END;

  -- Because of how we got the last symbol index, a value higher than the length of
  -- the email address indicates nothing was found
  IF @LastDotSymbolIndex > @EmailLength BEGIN RETURN 'FALSE' END;

  -- Check for character ordering
  -- Is there anything before the @ symbol?
  IF @AtSymbolIndex = 1 BEGIN RETURN 'FALSE' END;

  -- Is there anything after the @ symbol?
  IF @AtSymbolIndex = @EmailLength BEGIN RETURN 'FALSE' END;

  -- Is The @ symbol before the last dot?
  IF @AtSymbolIndex > @LastDotSymbolIndex BEGIN RETURN 'FALSE' END;

  -- Is there anything after the last dot?
  IF @LastDotSymbolIndex = @EmailLength BEGIN RETURN 'FALSE' END;

  RETURN 'TRUE';
END;
GO

/*
  List of users that have specifically requested not to receive emails from the service (not
  just unsubscribed). Attempting to create a user with a blocked user email will cause an error
*/
CREATE TABLE [BlockedUsers](
  -- Email address that has been blocked
  BlockedUserEmail VARCHAR(320) NOT NULL PRIMARY KEY CHECK (dbo.IsEmailValid(BlockedUserEmail) = 1)
);

/*
  Function that is used to identify if an email is blocked. Returns 1 if the email is blocked and
  0 otherwise. Used in a constraint on user emails
*/
DROP FUNCTION IF EXISTS IsEmailBlocked;
GO
CREATE FUNCTION IsEmailBlocked(@Email VARCHAR(320)) RETURNS INT AS
BEGIN
  RETURN (SELECT COUNT(*) FROM [BlockedUsers] WHERE BlockedUserEmail = @Email);
END;
GO

/* Users that have subscribed to the service */
CREATE TABLE [Users](
  -- Unique ID of the user
	UserId INT IDENTITY(0,1) NOT NULL PRIMARY KEY,
  -- The user's email address. Must be unique
  UserEmail VARCHAR(320) NOT NULL UNIQUE CHECK (
    dbo.IsEmailBlocked(UserEmail) = 0 AND dbo.IsEmailValid(UserEmail) = 1
  ),
  -- Name the user wishes to be called in their emails
  UserAlias VARCHAR(1024) NOT NULL,
  -- Key used in the unsubscribe link in the user's emails. Generated using the user's email
  -- address and the secret from the config set
  UserUnsubscribeKey VARCHAR(64) NOT NULL, 
  -- If the user is enabled and should receive emails. Default is 1 (TRUE)
  UserEnabled BIT NOT NULL DEFAULT 'TRUE'
);

/*
  Videos are split into playlists that span a certain period of time and focus on specific
  topics. Most commonly used will be the "main" playlist that includes all videos, but other
  playlists will be available for things like "the siege of Berlin" or "Stalingrad". These
  playlists aren't necessarily related to the playlists on the YouTube channel
*/
CREATE TABLE [Playlists](
  -- Unique ID of the playlist
  PlaylistId INT IDENTITY(0,1) NOT NULL PRIMARY KEY,
  -- Human friendly name of the playlist
  PlaylistName VARCHAR(255) NOT NULL,
  -- Short human friendly description of the playlist
  PlaylistDescription TEXT NOT NULL
);

/*
  Every video has a single "type" the corresponds to the series the video is a part of. Examples
  include the main weekly series, War Against Humanity, Spies in Ties, Out of the Foxholes, etc
*/
CREATE TABLE [VideoTypes](
  -- Unique ID of the video type
  VideoTypeId INT IDENTITY(0,1) NOT NULL PRIMARY KEY,
  -- Human friendly name of the video type
  VideoTypeName VARCHAR(255) NOT NULL,
  -- Short human friendly description of the video type
  VideoTypeDescription TEXT NOT NULL
);

/*
  Every video that is part of the World War 2 in real time project. This doesn't include special
  announcements or other time sensitive content that is no longer relevant
*/
CREATE TABLE [Videos](
  -- Unique ID for the video
  VideoId INT IDENTITY(0,1) NOT NULL PRIMARY KEY,
  -- Link to YouTube where the video can be found
  VideoUrl VARCHAR(255) NOT NULL UNIQUE,
  -- Name of the video on YouTube
  VideoName VARCHAR(255) NOT NULL,
  -- The video's description on YouTube, without the copied elements
  VideoDescription TEXT,
  -- ID of the video type associated with this video
  VideoTypeId INT NOT NULL,
  -- Historic date the video is meant to take place on
  VideoHistoricDate DATE NOT NULL,
  FOREIGN KEY (VideoTypeId) REFERENCES [VideoTypes](VideoTypeId),
  FOREIGN KEY (VideoHistoricDate) REFERENCES [HistoricDates](HistoricDate)
);

/* Join table connecting playlists to videos */
CREATE TABLE [PlaylistVideos](
  -- ID of the playlist
  PlaylistId INT NOT NULL,
  -- ID of the video
  VideoId INT NOT NULL,
  PRIMARY KEY (VideoId, PlaylistId),
  FOREIGN KEY (VideoId) REFERENCES [Videos](VideoId),
  FOREIGN KEY (PlaylistId) REFERENCES [Playlists](PlaylistId)
);

/* Join table that connects users to the video types they wish to receive emails about */
CREATE TABLE [UserVideoTypes](
  -- ID of the video type the user subscribed to
  VideoTypeId INT NOT NULL,
  -- ID of the user subscribed to this type 
  UserId INT NOT NULL,
  PRIMARY KEY (UserId, VideoTypeId),
  FOREIGN KEY (UserId) REFERENCES [Users](UserId),
  FOREIGN KEY (VideoTypeId) REFERENCES [VideoTypes](VideoTypeId)
)

/* Playlists that a user has subscribed to */
CREATE TABLE [UserPlaylists](
  -- ID of the playlist being subscribed to
  PlaylistId INT NOT NULL,
  -- ID of the subscribed user
  UserId INT NOT NULL,
  -- The year the user subscribed to the playlist. Normalized to the start of the war, not the
  -- first video of the playlist
  UserPlaylistStartYear INT NOT NULL,
  PRIMARY KEY (UserId, PlaylistId),
  FOREIGN KEY (UserId) REFERENCES [Users](UserId),
  FOREIGN KEY (PlaylistId) REFERENCES [Playlists](PlaylistId)
);

/* The emails that are generated for distribution */
CREATE TABLE [Emails](
  -- ID of the user the email is sent to
  UserId INT NOT NULL,
  -- Historic date associated with the email
  EmailHistoricDate DATE NOT NULL,
  -- Date (not including time) the email was generated
  EmailDate DATE NOT NULL,
  -- Subject of the email
  EmailSubject TEXT NOT NULL,
  -- HTML Body of the email
  EmailBody TEXT NOT NULL,
  PRIMARY KEY (UserId, EmailHistoricDate, EmailDate),
  FOREIGN KEY (UserId) REFERENCES [Users](UserId),
  FOREIGN KEY (EmailHistoricDate) REFERENCES [HistoricDates](HistoricDate),
);
GO

-- ----------------- FUNCTIONS ----------------- --
/*
  Takes a user email and uses secret in the indicated config set to generate the user's
  login key. This is done by generating the SHA 256 hash of the user's email address, plus
  the secret from the config set as a salt
*/
DROP FUNCTION IF EXISTS CalculateUserLoginKey;
GO
CREATE FUNCTION CalculateUserLoginKey(@UserEmail VARCHAR(320), @ConfigSetId INT = 0) 
RETURNS VARCHAR(64) AS
BEGIN
  DECLARE @LoginLinkSecret VARCHAR(255) = (
    SELECT UserLoginSecret FROM ConfigSets WHERE ConfigSetId = @ConfigSetId
  );
  DECLARE @Result VARCHAR(64) = CONVERT(
    VARCHAR(64), HASHBYTES('SHA2_256', @UserEmail + @LoginLinkSecret), 2
  );
  RETURN @Result;
END;
GO

/*
  Takes a user email and uses secret in the indicated config set to generate the user's
  unsubscribe key. This is done by generating the SHA 256 hash of the user's email address, plus
  the secret from the config set as a salt
*/
DROP FUNCTION IF EXISTS CalculateUserUnsubscribeKey;
GO
CREATE FUNCTION CalculateUserUnsubscribeKey(@UserEmail VARCHAR(320), @ConfigSetId INT = 0) 
RETURNS VARCHAR(64) AS
BEGIN
  DECLARE @UnsubscribeLinkSecret VARCHAR(255) = (
    SELECT UnsubscribeLinkSecret FROM ConfigSets WHERE ConfigSetId = @ConfigSetId
  );
  DECLARE @Result VARCHAR(64) = CONVERT(
    VARCHAR(64), HASHBYTES('SHA2_256', @UserEmail + @UnsubscribeLinkSecret), 2
  );
  RETURN @Result;
END;
GO

/*
  Takes the current date and a starting year, and returns a matching historic date. Leap years
  are ignored, so any time a leap day would be returned, the previous day is returned instead
*/
DROP FUNCTION IF EXISTS GetHistoricDate;
GO
CREATE FUNCTION GetHistoricDate(@CurrentDate DATE, @StartYear INT) RETURNS DATE AS
BEGIN
  DECLARE @CurrentYear INT = DATEPART(YEAR, @CurrentDAte);
  DECLARE @CurrentMonth INT = DATEPART(MONTH, @CurrentDAte);
  DECLARE @CurrentDay INT = DATEPART(DAY, @CurrentDAte);

  -- If the input date is a leap day, make it the previous day
  IF @CurrentMonth = 2 AND @CurrentDay = 29 BEGIN
    SET @CurrentDay = 28;
  END;

  DECLARE @HistoricDate DATE = DATEFROMPARTS(
    1939 + (@CurrentYear - @StartYear), @CurrentMonth, @CurrentDay
  );
  RETURN @HistoricDate;
END;
GO

-- ----------------- PROCEDURES ----------------- --
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

    -- In each loop, take the top item from the video types table variable, add it to the real
    -- table, then delete the table type we just added from the table variable. Keep going until
    -- there are no more items to process
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

-- ----------------- TRIGGERS ----------------- --
DROP TRIGGER IF EXISTS [OnInsertUser];
GO
/*
  Replacement trigger that fires when inserting users. This trigger will automatically generate
  the `UserUnsubscribeKey` value for the new item, making it no longer required when creating
  new values
*/
CREATE TRIGGER [OnInsertUser] ON [Users] INSTEAD OF INSERT AS
  INSERT INTO [Users] (UserEmail, UserAlias, UserUnsubscribeKey, UserEnabled)
    SELECT 
      [inserted].UserEmail,
      [inserted].UserAlias,
      dbo.CalculateUserUnsubscribeKey([inserted].UserEmail, default),
      [inserted].UserEnabled
    FROM [inserted];
GO

/*
  Replacement trigger that fires when updating users. This trigger will automatically generate
  the `UserUnsubscribeKey` value for the item
*/
DROP TRIGGER IF EXISTS [OnUpdateUser];
GO
CREATE TRIGGER [OnUpdateUser] ON [Users] INSTEAD OF UPDATE AS
  UPDATE [Users] SET
    UserEmail = [inserted].UserEmail,
    UserAlias = [inserted].UserAlias,
    UserUnsubscribeKey = dbo.CalculateUserUnsubscribeKey([inserted].UserEmail, default),
    UserEnabled = [inserted].UserEnabled
  FROM [Users] JOIN [inserted]
  ON [Users].UserId = [inserted].UserId
GO

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


-- ----------------- INSERTS ----------------- --

SET IDENTITY_INSERT [ConfigSets] ON;
INSERT INTO [ConfigSets] (ConfigSetId, EmailHeaderImageLink, UnsubscribeLinkSecret, UserLoginSecret) VALUES (
  0,
  'https://yt3.googleusercontent.com/ytc/AIdro_ntBfc7SOI3SmH0bOy_tyjaCY_g57TSNrGgEnH_Fp6H3w=s176-c-k-c0x00ffffff-no-rj',
  'k8m1lQmwQa45DtK?5NuUJuLhXH?Ec5e?iu@pnJev',
  'b4JTG6P!Ms6DYbG3i3ArpJCjb3#TjFiFKspReJEo'
);

-- Set up some initial historic dates. A date must be present for every video, but dates with no
-- content do not need to be defined
INSERT INTO [HistoricDates] (HistoricDate, HistoricDateNote) VALUES ('1939-09-01', 'The very first day of the war');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-09-08');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-09-15');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-09-22');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-09-29');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-10-06');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-10-13');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-10-20');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-10-27');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-11-03');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-11-10');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-11-17');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-11-24');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-12-01');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-12-08');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-12-15');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-12-22');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1939-12-29');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1940-01-05');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1940-01-12');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1940-01-19');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1940-01-26');
INSERT INTO [HistoricDates] (HistoricDate, HistoricDateNote) VALUES ('1940-01-28', 'The first special episode that breaks the weekly pattern is today');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1940-02-02');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1940-02-09');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1940-02-16');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1940-02-23');
INSERT INTO [HistoricDates] (HistoricDate, HistoricDateNote) VALUES ('1940-02-28', 'This day marks the first episode of Out of the Foxholes');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1940-03-02');
INSERT INTO [HistoricDates] (HistoricDate, HistoricDateNote) VALUES ('1940-03-05', 'Today is the first episode of War Against Humanity, a brutal, but extremely important series');
INSERT INTO [HistoricDates] (HistoricDate) VALUES ('1940-03-09')
GO

-- Add some video types
INSERT INTO [VideoTypes] (VideoTypeName, VideoTypeDescription) VALUES ('Weekly Episodes', 'The main weekly series which originally aired every Saturday');
INSERT INTO [VideoTypes] (VideoTypeName, VideoTypeDescription) VALUES ('War Against Humanity', 'A deep dive into the atrocities committed on all sides during this war');
INSERT INTO [VideoTypes] (VideoTypeName, VideoTypeDescription) VALUES ('Special Episodes', 'One-off special episodes about various different topics');
INSERT INTO [VideoTypes] (VideoTypeName, VideoTypeDescription) VALUES ('Out of the Foxholes', 'Q&A Episodes in which audience questions are addressed');
GO

-- Add some videos of various types
INSERT INTO [Videos] (VideoUrl, VideoName, VideoDescription, VideoTypeId, VideoHistoricDate) VALUES
  (
    'https://youtu.be/2b7GY4BSUmU',
    '001 -The Polish-German War - WW2 - September 1, 1939 [IMPROVED]',
    'When Germany invades Poland on September 1, 1939, the world is already at the brink of a new world war…',
    0,
    '1939-09-01'
  );
INSERT INTO [Videos] (VideoUrl, VideoName, VideoDescription, VideoTypeId, VideoHistoricDate) VALUES
  (
    'https://youtu.be/sVPLeZ_Vpw8',
    '002 - World War Two Begins - WW2 - September 8, 1939 [IMPROVED]',
    'The German-Polish war is the match that ignites the flames that finally burn British Prime Minister Neville Chamberlain''s appeasement efforts to the ground.',
    0,
    '1939-09-08'
  );
INSERT INTO [Videos] (VideoUrl, VideoName, VideoDescription, VideoTypeId, VideoHistoricDate) VALUES
  (
    'https://youtu.be/dHd-2eD0ejU',
    '003 - Poland on Her Own - WW2 - September 15, 1939 [IMPROVED]',
    'When the Wehrmacht and the SS continue devastating Poland and her people in the first weeks of September, her last chance is her western allies.',
    0,
    '1939-09-15'
  );
INSERT INTO [Videos] (VideoUrl, VideoName, VideoDescription, VideoTypeId, VideoHistoricDate) VALUES
  (
    'https://youtu.be/8vjBp-qyNVE',
    '004 - The Russians are Coming! - The Soviet Invasion of Poland - WW2 -September 22, 1939 [IMPROVED]',
    'When the USSR crushes the plans of the Allies for Poland and the Japanese plans in China in the same week, it is Germany that benefits.',
    0,
    '1939-09-22'
  );
INSERT INTO [Videos] (VideoUrl, VideoName, VideoDescription, VideoTypeId, VideoHistoricDate) VALUES
  (
    'https://youtu.be/OOPiUaakSXM',
    '005 - Poland is Crushed - WW2 - 29 September, 1939 [IMPROVED]',
    'Facing two enemies at once, Poland finds itself in a crushing vice after less than a month of war and the Polish forces must flee their own country to live to fight another day.',
    0,
    '1939-09-29'
  );
INSERT INTO [Videos] (VideoUrl, VideoName, VideoDescription, VideoTypeId, VideoHistoricDate) VALUES
  (
    'https://youtu.be/k1gR6LrR5P4',
    '006 - Poland Falls and China Rises - WW2 - October 6, 1939 [IMPROVED]',
    'In the West, the sun sets on Poland as the last forces surrender, but her defenders are already regrouping abroad. In the East, the sun rises on China as Japan meets yet another defeat',
    0,
    '1939-10-06'
  );


-- Skip ahead to some different episode types...
INSERT INTO [Videos] (VideoUrl, VideoName, VideoDescription, VideoTypeId, VideoHistoricDate) VALUES
  (
    'https://youtu.be/Etfhio8vrXE',
    'The T-26 and Tank Warfare in Finland and China - WORLD WAR TWO Special',
    'The T-26 tank was one of the most frequently used tanks during the first battles of World War Two. It saw action in the Soviet Union, Finland and China. In our first collaborative video with the Tank Museum in Bovington, UK, David Willey and David Fletcher talk about the development, production and action of the this tank. Check out the Tank Talk about the T-26 to hear David Fletcher explain some more about the T-26 on The Tank Museum YouTube Channel',
    2,
    '1940-01-28'
  );
INSERT INTO [Videos] (VideoUrl, VideoName, VideoDescription, VideoTypeId, VideoHistoricDate) VALUES
  (
    'https://youtu.be/LSQUkgK2XP8',
    'Rommel, German Press and Polish Resistance - WW2 - OOTF 001',
    'This is the very first episode of Out of the Foxholes, in which we answer questions from the community. In this first edition, we''ll talk about the early-war career of Erwin Rommel, German Press on the Invasion of Poland and the birth of Polish resistance movements after the German occupation in 1939',
    3,
    '1940-02-28'
  );
INSERT INTO [Videos] (VideoUrl, VideoName, VideoDescription, VideoTypeId, VideoHistoricDate) VALUES
  (
    'https://youtu.be/gd5YhhNcC44',
    'Outbreak of the War Against Humanity - WW2 - War Against Humanity 001 - 5 March 1940',
    'When the Second World War breaks out, it is at first largely a war between one side of totalitarian aggressors against a portion of the democratic countries of the world defending other totalitarian states. From the first day of the war in Poland, as it already is in China, this will be a war against humanity',
    1,
    '1940-03-05'
  );
GO

-- Add and fill out a couple playlists
INSERT INTO [Playlists] (PlaylistName, PlaylistDescription) VALUES ('All Videos', 'Every single video, in real-time order');
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (0, 0);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (0, 1);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (0, 2);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (0, 3);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (0, 4);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (0, 5);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (0, 6);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (0, 7);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (0, 8);
INSERT INTO [Playlists] (PlaylistName, PlaylistDescription) VALUES ('The Annihilation of Poland', 'The short-lived but valiant resistance of the Poles against Nazi Germany AND Soviet Russia');
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (1, 0);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (1, 1);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (1, 2);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (1, 3);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (1, 4);
INSERT INTO [PlaylistVideos] (PlaylistId, VideoId) VALUES (1, 5);
GO

-- Add a couple of users. In reality the UserUnsubscribeKey will be automatically generated by a trigger whenever a user is added
INSERT INTO [Users] (UserEmail, UserAlias) VALUES ('thejoshuaevans@gmail.com', 'Joshe Personal Email');
INSERT INTO [Users] (UserEmail, UserAlias) VALUES ('evansjj@my.lanecc.edu', 'Joshe School Email');
GO

-- Add the video user types. School joshe doesn't want to get WAH videos
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (0, 0);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (0, 1);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (0, 2);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (0, 3);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (1, 0);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (1, 2);
INSERT INTO [UserVideoTypes] (UserId, VideoTypeId) VALUES (1, 3);
GO

-- Add the user playlists. School joshe is only interested in the initial Polish military resistance
INSERT INTO [UserPlaylists] (UserId, PlaylistId, UserPlaylistStartYear) VALUES (0, 0, 2024);
INSERT INTO [UserPlaylists] (UserId, PlaylistId, UserPlaylistStartYear) VALUES (1, 1, 2024);
GO
