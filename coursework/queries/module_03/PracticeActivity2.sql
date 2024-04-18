-- DROP DATABASE IF EXISTS Membership;
-- CREATE DATABASE Membership;

CREATE TABLE Individuals(
	IndividualId INT NOT NULL PRIMARY KEY,
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NULL,
	Phone VARCHAR(32) NULL,
);

CREATE TABLE Groups(
	GroupId INT NOT NULL PRIMARY KEY,
	GroupName VARCHAR(255) NOT NULL,
	Dues MONEY NOT NULL DEFAULT 0 CHECK (Dues >= 0)
)

CREATE TABLE GroupMembers(
	GroupId INT REFERENCES Groups(GroupId),
	IndividualId INT REFERENCES Individuals(IndividualId)
);

SELECT * FROM Membership.INFORMATION_SCHEMA.TABLES;
