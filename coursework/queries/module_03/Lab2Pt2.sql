USE master;
IF DB_ID('MyBookDB') IS NOT NULL
	-- Kill all other connections before dropping the database
	-- Source: https://stackoverflow.com/a/20569152
	AlTER DATABASE MyBookDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE MyBookDB;
CREATE DATABASE MyBookDB;
GO -- Make sure the database is created/reset before processing any subsequent steps

USE MyBookDB;

-- SECTION 1
-- Make all the tables
CREATE TABLE Users(
	UserID CHAR(36) NOT NULL PRIMARY KEY,
	EmailAddress VARCHAR(320) NOT NULL,
	FirstName VARCHAR(255) NULL,
	LastName VARCHAR(255) NULL
);

CREATE TABLE Books(
	BookID CHAR(36) NOT NULL PRIMARY KEY,
	BookName VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Downloads(
	DownloadID CHAR(36) NOT NULL PRIMARY KEY,
	UserID CHAR(36) NOT NULL REFERENCES Users(UserID),
	BookID CHAR(36) NOT NULL REFERENCES Books(BookID),
	Filename VARCHAR(255) NOT NULL,
	DownloadDate DATETIME NOT NULL DEFAULT GETDATE()
);

-- Add indexes for foreign keys
CREATE INDEX DownloadsUserIDFKIndex ON Downloads(UserID);
CREATE INDEX DownloadsBookIDFKIndex ON Downloads(BookID);

-- SECTION 2
-- Add some rows to users and books
DECLARE @user1Id UNIQUEIDENTIFIER = NEWID();
DECLARE @user2Id UNIQUEIDENTIFIER = NEWID();
DECLARE @book1Id UNIQUEIDENTIFIER = NEWID();
DECLARE @book2Id UNIQUEIDENTIFIER = NEWID();
INSERT INTO Users (UserID, EmailAddress, LastName, FirstName) VALUES (@user1Id, 'user1@email.com', 'One', 'User'); 
INSERT INTO Users (UserID, EmailAddress, LastName, FirstName) VALUES (@user2Id, 'user2@email.com', 'Two', 'User'); 

INSERT INTO Books (BookID, BookName) VALUES (@book1Id, 'The First Book');
INSERT INTO Books (BookID, BookName) VALUES (@book2Id, 'The Second Book');

-- Add some downloads
INSERT INTO Downloads (DownloadID, UserID, BookID, Filename) VALUES (NEWID(), @user1Id, @book1Id, 'the_first_book_book.pdf');
INSERT INTO Downloads (DownloadID, UserID, BookID, Filename) VALUES (NEWID(), @user2Id, @book1Id, 'the_first_book_book.pdf');
INSERT INTO Downloads (DownloadID, UserID, BookID, Filename) VALUES (NEWID(), @user2Id, @book2Id, 'the_second_book_book.pdf');

-- Make an example selection
SELECT EmailAddress, FirstName, LastName, DownloadDate, FileName, BookName
FROM Users, Downloads, Books
WHERE
	Users.UserID = Downloads.UserID AND
	Books.BookID = Downloads.BookID
ORDER BY Users.EmailAddress DESC, Books.BookName ASC;

-- SECTION 3
-- Alter the Books table a bit
ALTER TABLE Books ADD BookPrice DECIMAL(5, 2) DEFAULT 59.5;
ALTER TABLE Books ADD DateAdded DATETIME;

-- SECTION 4
-- Alter the Users table
ALTER TABLE Users ALTER COLUMN EmailAddress VARCHAR(25) NOT NULL;

-- Test our alteration
BEGIN TRY
	INSERT INTO Users (UserID, EmailAddress) VALUES (NEWID(), '12345678901234567890123456');
END TRY
BEGIN CATCH
	PRINT 'Error encountered: ' + ERROR_MESSAGE()
END CATCH

-- SECTION 5
-- Alter the Users table
ALTER TABLE Users ADD CONSTRAINT UsersEmailAddressUnique UNIQUE(EmailAddress);

-- Test our alteration
BEGIN TRY
	INSERT INTO Users (UserID, EmailAddress) VALUES (NEWID(), (
		SELECT EmailAddress
		FROM Users
		WHERE UserID = @user1Id
	));
END TRY
BEGIN CATCH
	PRINT 'Error encountered: ' + ERROR_MESSAGE()
END CATCH
