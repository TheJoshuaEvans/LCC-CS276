-- Based of the ERD found here:
-- https://lucid.app/documents/view/0c5c4c4f-23c9-40cc-ac58-064ccffd53d5

--Prompt:
-- [X] SQL Create Database Statement
-- [ ] SQL Create Table Statements. Make sure to include constraints, primary, and foreign keys 
-- [ ] SQL Create Insert Statements
-- [ ] SQL Create Indexes
USE master;
GO

-- TODO: Uncomment before submitting
-- DROP DATABASE IF EXISTS RealTimeWW2;
-- CREATE DATABASE RealTimeWW2; 
GO

USE [RealTimeWW2];

-- Because of the complex relationship between tables, it's best to delete them all up front
-- then create them together
DROP TABLE IF EXISTS [HistoricDates];
DROP TABLE IF EXISTS [ConfigSets];
DROP TABLE IF EXISTS [Users];
DROP TABLE IF EXISTS [BlockedUsers];
DROP TABLE IF EXISTS [PlaylistVideos];
DROP TABLE IF EXISTS [Playlists];
DROP TABLE IF EXISTS [Videos];
DROP TABLE IF EXISTS [VideoTypes];
DROP TABLE IF EXISTS [UserVideoTypes];
DROP TABLE IF EXISTS [UserPlaylists];

-- Static Utility Tables
CREATE TABLE [HistoricDates](
  HistoricDate DATE NOT NULL PRIMARY KEY,
  HistoricDateNote TEXT NULL
);

CREATE TABLE [ConfigSets](
  ConfigSetId INT NOT NULL IDENTITY(0,1) PRIMARY KEY,
  EmailHeaderImageLink VARCHAR(1024) NOT NULL,
  UnsubscribeLinkSecret VARCHAR(255) NOT NULL
)

-- Users
CREATE TABLE [Users](
	UserId INT IDENTITY(0,1) NOT NULL PRIMARY KEY,
  UserEmail VARCHAR(320) NOT NULL,
  UserAlias VARCHAR(1024) NOT NULL,
  UserUnsubscribeKey VARCHAR(1024) NOT NULL
);

CREATE TABLE [BlockedUsers](
  BlockedUserEmail VARCHAR(320) NOT NULL PRIMARY KEY
);

-- Videos and playlists
CREATE TABLE [Playlists](
  PlaylistId INT IDENTITY(0,1) NOT NULL PRIMARY KEY,
  PlaylistName VARCHAR(255) NOT NULL,
  PlaylistDescription TEXT NOT NULL
);

CREATE TABLE [VideoTypes](
  VideoTypeId INT IDENTITY(0,1) NOT NULL PRIMARY KEY,
  VideoTypeName VARCHAR(255) NOT NULL,
  VideoTypeDescription TEXT NOT NULL
);

CREATE TABLE [Videos](
  VideoId INT IDENTITY(0,1) NOT NULL PRIMARY KEY,
  VideoUrl VARCHAR(255) NOT NULL,
  VideoName VARCHAR(255) NOT NULL,
  VideoDescription TEXT,
  VideoTypeId INT NOT NULL,
  FOREIGN KEY (VideoTypeId) REFERENCES [VideoTypes](VideoTypeId)
);

CREATE TABLE [PlaylistVideos](
  VideoId INT NOT NULL,
  PlaylistId INT NOT NULL,
  PRIMARY KEY (VideoId, PlaylistId),
  FOREIGN KEY (VideoId) REFERENCES [Videos](VideoId),
  FOREIGN KEY (PlaylistId) REFERENCES [Playlists](PlaylistId)
);

-- User Join Tabes
CREATE TABLE [UserVideoTypes](
  UserId INT NOT NULL,
  VideoTypeId INT NOT NULL,
  PRIMARY KEY (UserId, VideoTypeId),
  FOREIGN KEY (UserId) REFERENCES [Users](UserId),
  FOREIGN KEY (VideoTypeId) REFERENCES [VideoTypes](VideoTypeId)
)

CREATE TABLE [UserPlaylists](
  UserId INT NOT NULL,
  PlaylistId INT NOT NULL,
  UserPlaylistStartYear INT NOT NULL,
  PRIMARY KEY (UserId, PlaylistId),
  FOREIGN KEY (UserId) REFERENCES [Users](UserId),
  FOREIGN KEY (PlaylistId) REFERENCES [Playlists](PlaylistId)
)
