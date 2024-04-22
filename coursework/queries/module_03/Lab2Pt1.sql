USE master;
IF DB_ID('ProductsAndParts') IS NOT NULL
	AlTER DATABASE ProductsAndParts SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE ProductsAndParts;
CREATE DATABASE ProductsAndParts;
GO -- Make sure the database is created/reset before processing any subsequent steps

USE ProductsAndParts;

-- Create the tables from the book
CREATE TABLE Product(
	PROD_CODE CHAR(3) NOT NULL PRIMARY KEY,
	PROD_QOH SMALLINT NOT NULL
);

CREATE TABLE Part(
	PART_CODE CHAR(1) NOT NULL PRIMARY KEY,
	PART_QOH SMALLINT NOT NULL
);

-- Insert the items as they appear in the book
INSERT INTO Product (PROD_CODE, PROD_QOH) VALUES ('ABC', 1205);
INSERT INTO Part (PART_CODE, PART_QOH) VALUES ('A', 567);
INSERT INTO Part (PART_CODE, PART_QOH) VALUES ('B', 98);
INSERT INTO Part (PART_CODE, PART_QOH) VALUES ('C', 549);

-- Procedure for selecting the codes and counts for both tables
GO
CREATE OR ALTER PROCEDURE selectCounts AS
BEGIN
	SELECT PROD_CODE AS CODE, PROD_QOH AS QOH
	FROM Product
	UNION 
	SELECT PART_CODE AS CODE, PART_QOH AS QOH
	FROM Part;
END;
GO

-- Transaction for updating product ABC
EXEC selectCounts;
BEGIN TRANSACTION;
	UPDATE Product SET PROD_QOH = PROD_QOH + 1
		WHERE PROD_CODE = 'ABC';
	UPDATE Part SET PART_QOH = PART_QOH - 1
		WHERE PART_CODE IN ('A', 'B', 'C');
COMMIT TRANSACTION;
EXEC selectCounts;
