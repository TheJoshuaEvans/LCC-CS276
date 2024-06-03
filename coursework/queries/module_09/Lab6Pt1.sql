-- Based of the ERD found here:
-- https://lucid.app/documents/view/0c5c4c4f-23c9-40cc-ac58-064ccffd53d5

--Prompt:
-- [X] SQL Create Database Statement
-- [X] SQL Create Table Statements. Make sure to include constraints, primary, and foreign keys 
-- [X] SQL Create Indexes
-- [ ] SQL Create Insert Statements
USE master;
GO

-- TODO: Uncomment before submitting
-- DROP DATABASE IF EXISTS RealTimeWW2;
-- CREATE DATABASE RealTimeWW2; 
GO

USE [RealTimeWW2];

-- Because of the complex relationship between tables, it's best to delete them all up front
-- then create them together
DROP TABLE IF EXISTS [Emails];
DROP TABLE IF EXISTS [HistoricDates];
DROP TABLE IF EXISTS [ConfigSets];
DROP TABLE IF EXISTS [UserVideoTypes];
DROP TABLE IF EXISTS [UserPlaylists];
DROP TABLE IF EXISTS [Users];
DROP TABLE IF EXISTS [BlockedUsers];
DROP TABLE IF EXISTS [PlaylistVideos];
DROP TABLE IF EXISTS [Playlists];
DROP TABLE IF EXISTS [Videos];
DROP TABLE IF EXISTS [VideoTypes];

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
  UnsubscribeLinkSecret VARCHAR(255) NOT NULL
)

/* Users that have subscribed to the service */
CREATE TABLE [Users](
  -- Unique ID of the user
	UserId INT IDENTITY(0,1) NOT NULL PRIMARY KEY,
  -- The user's email address. Must be unique
  UserEmail VARCHAR(320) NOT NULL UNIQUE,
  -- Name the user wishes to be called in their emails
  UserAlias VARCHAR(1024) NOT NULL,
  -- Key used in the unsubscribe link in the user's emails. Generated using the user's email
  -- address and the secret from the config set
  UserUnsubscribeKey VARCHAR(1024) NOT NULL
);

/*
  List of users that have specifically requested not to receive emails from the service (not
  just unsubscribed). Attempting to create a user with a blocked user email will cause an error
*/
CREATE TABLE [BlockedUsers](
  -- Email address that has been blocked
  BlockedUserEmail VARCHAR(320) NOT NULL PRIMARY KEY
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
  VideoUrl VARCHAR(255) NOT NULL,
  -- Name of the video on YouTube
  VideoName VARCHAR(255) NOT NULL,
  -- The video's description on YouTube, without the copied elements
  VideoDescription TEXT,
  -- ID of the video type associated with this video
  VideoTypeId INT NOT NULL,
  FOREIGN KEY (VideoTypeId) REFERENCES [VideoTypes](VideoTypeId)
);

/* Join table connecting playlists to videos */
CREATE TABLE [PlaylistVideos](
  -- ID of the video
  VideoId INT NOT NULL,
  -- ID of the playlist
  PlaylistId INT NOT NULL,
  PRIMARY KEY (VideoId, PlaylistId),
  FOREIGN KEY (VideoId) REFERENCES [Videos](VideoId),
  FOREIGN KEY (PlaylistId) REFERENCES [Playlists](PlaylistId)
);

/* Join table that connects users to the video types they wish to receive emails about */
CREATE TABLE [UserVideoTypes](
  -- ID of the user subscribed to this type 
  UserId INT NOT NULL,
  -- ID of the video type the user subscribed to
  VideoTypeId INT NOT NULL,
  PRIMARY KEY (UserId, VideoTypeId),
  FOREIGN KEY (UserId) REFERENCES [Users](UserId),
  FOREIGN KEY (VideoTypeId) REFERENCES [VideoTypes](VideoTypeId)
)

/* Playlists that a user has subscribed to */
CREATE TABLE [UserPlaylists](
  -- ID of the subscribed user
  UserId INT NOT NULL,
  -- ID of the playlist being subscribed to
  PlaylistId INT NOT NULL,
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
