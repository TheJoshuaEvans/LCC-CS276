-- Section 1
-- Write a script that creates and calls a stored procedure named spInsertCategory. First, code
-- a statement that creates a procedure that adds a new row to the Categories table. To do that,
-- this procedure should have one parameter for the category name.
-- Code at least two EXEC statements that test this procedure. (Note that this table doesn’t
-- allow duplicate category names.)
USE MyGuitarShop;
DROP PROCEDURE IF EXISTS [spInsertCategory];

GO
CREATE PROCEDURE [spInsertCategory] @CategoryName VARCHAR(255) AS
  DECLARE @ItemsWithCategoryNameCount INT;
  SET @ItemsWithCategoryNameCount = (
    SELECT COUNT(*) FROM [Categories]
      WHERE CategoryName = @CategoryName
  );

  -- Ensure uniqueness of category names
  IF @ItemsWithCategoryNameCount > 0 BEGIN
    DECLARE @ErrorMessage VARCHAR(255);
    SET @ErrorMessage = 'Category "' + @CategoryName + '" already exists';
    THROW 1025000, @ErrorMessage, 1;
  END
  
  INSERT INTO [Categories] (CategoryName) VALUES (@CategoryName);
GO

SELECT * FROM [Categories];
EXEC [spInsertCategory] @CategoryName = 'Cowbells';
EXEC [spInsertCategory] @CategoryName = 'Theremins';
SELECT * FROM [Categories];

-- Section 2
-- Write a script that creates and calls a function named fnDiscountPrice that calculates the
-- discount price of an item in the OrderItems table (discount amount subtracted from item
-- price). To do that, this function should accept one parameter for the item ID, and it should
-- return the value of the discount price for that item.
USE MyGuitarShop;
DROP FUNCTION IF EXISTS [fnDiscountPrice] 

GO
CREATE FUNCTION [fnDiscountPrice] (@ItemID INT) RETURNS MONEY AS
BEGIN
  DECLARE @DiscountPrice INT;
  SELECT @DiscountPrice = ItemPrice - DiscountAmount
    FROM OrderItems WHERE ItemID = @ItemID;

  RETURN @DiscountPrice
END;
GO

DECLARE @DiscountPriceResult1 MONEY, @DiscountPriceResult2 MONEY;
EXEC @DiscountPriceResult1 = [fnDiscountPrice] @ItemID = 1;
EXEC @DiscountPriceResult2 = [fnDiscountPrice] @ItemID = 2;
SELECT 
  'Discount Price 1' = @DiscountPriceResult1,
  'Discount Price 2' = @DiscountPriceResult2;


-- Section 3
-- Write a script that creates and calls a function named fnItemTotal that calculates the total
-- amount of an item in the OrderItems table (discount price multiplied by quantity). To do
-- that, this function should accept one parameter for the item ID, it should use the
-- fnDiscountPrice function that you created in exercise 2, and it should return the value
-- of the total for that item.
USE MyGuitarShop;
DROP FUNCTION IF EXISTS [fnItemTotal]

GO
CREATE FUNCTION [fnItemTotal] (@ItemID INT) RETURNS MONEY AS
BEGIN
  DECLARE @ItemTotal MONEY, @DiscountPrice MONEY;
  EXEC @DiscountPrice = [fnDiscountPrice] @ItemID = @ItemID;
  SELECT @ItemTotal = @DiscountPrice * Quantity
    FROM OrderItems WHERE ItemID = @ItemID;

  RETURN @ItemTotal;
END;
GO

DECLARE @ItemTotalResult1 MONEY, @ItemTotalResult33 MONEY;
EXEC @ItemTotalResult1 = [fnItemTotal] @ItemID = 1;
EXEC @ItemTotalResult33 = [fnItemTotal] @ItemID = 33;
SELECT 
  'Item Total 1' = @ItemTotalResult1,
  'Item Total 33' = @ItemTotalResult33;

-- Section 4
-- Write a script that creates and calls a stored procedure named spInsertProduct that inserts
-- a row into the Products table. This stored procedure should accept one parameter for each of
-- these columns: CategoryID, ProductCode, ProductName, ListPrice, and DiscountPercent.

-- This stored procedure should set the Description column to an empty string, and it should
-- set the DateAdded column to the current date.

-- If the value for the ListPrice column is a negative number, the stored procedure should
-- raise an error that indicates that this column doesn’t accept negative numbers. Similarly,
-- the procedure should raise an error if the value for the DiscountPercent column is a
-- negative number.

-- Code at least two EXEC statements that test this procedure.
USE MyGuitarShop;
DROP PROCEDURE IF EXISTS [spInsertProduct];

GO
CREATE PROCEDURE [spInsertProduct]
  @ProductCode VARCHAR(10),
  @ProductName VARCHAR(255),
  @ListPrice MONEY,
  @DiscountPercent MONEY,
  @CategoryID INT = NULL
AS
  -- Validation
  IF @ListPrice < 0 BEGIN
    DECLARE @ListPriceInvalidErrorMessage VARCHAR(255) = 
      'List price cannot be less than 0. ' +
      'Provided list price: ' + CAST (@ListPrice AS VARCHAR);
    THROW 1025001, @ListPriceInvalidErrorMessage, 1;
  END

  IF @DiscountPercent < 0 BEGIN
    DECLARE @DiscountPercentInvalidErrorMessage VARCHAR(255) = 
      'Discount percent cannot be less than 0. ' +
      'Provided discount percent: ' + CAST (@DiscountPercent AS VARCHAR);
    THROW 1025002, @DiscountPercentInvalidErrorMessage, 1;
  END

  -- Perform the insert!
  INSERT INTO [Products] (
    ProductCode, ProductName, ListPrice, DiscountPercent, CategoryID,
    Description, DateAdded
  ) VALUES (
    @ProductCode, @ProductName, @ListPrice, @DiscountPercent, @CategoryID,
    '', GETDATE()
  );
GO

-- Initial State
SELECT TOP 8 * FROM Products ORDER BY ProductID DESC;

-- Test Validation
BEGIN TRY
  EXEC [spInsertProduct]
    @ProductCode = 'test_001', @ProductName = 'More Cowbell',
    @ListPrice = -10, @DiscountPercent = 0;
END TRY BEGIN CATCH PRINT 'Error message: ' + ERROR_MESSAGE() END CATCH

BEGIN TRY
  EXEC [spInsertProduct]
    @ProductCode = 'test_002', @ProductName = 'Even More Cowbell!!',
    @ListPrice = 100, @DiscountPercent = -33;
END TRY BEGIN CATCH PRINT 'Error message: ' + ERROR_MESSAGE() END CATCH

-- Test functionality
DELETE FROM [Products] WHERE ProductCode IN ('test_001', 'test_002');

EXEC [spInsertProduct]
  @ProductCode = 'test_001', @ProductName = 'More Cowbell',
  @ListPrice = 10, @DiscountPercent = 0;

EXEC [spInsertProduct]
  @ProductCode = 'test_002', @ProductName = 'Even More Cowbell!!',
  @ListPrice = 100, @DiscountPercent = 33;

-- Final State
SELECT TOP 8 * FROM Products ORDER BY ProductID DESC;

-- Section 5
-- Write a script that creates and calls a stored procedure named spUpdateProductDiscount that
-- updates the DiscountPercent column in the Products table. This procedure should have one
-- parameter for the product ID and another for the discount percent

-- If the value for the DiscountPercent column is a negative number, the stored procedure
-- should raise an error that indicates that the value for this column must be a positive number

-- Code at least two EXEC statements that test this procedure.
USE MyGuitarShop;
DROP PROCEDURE IF EXISTS [spUpdateProductDiscount];

GO
CREATE PROCEDURE [spUpdateProductDiscount]
  @ProductID INT,
  @NewDiscountPercent MONEY
AS
  -- Validation
  IF @NewDiscountPercent < 0 BEGIN
    DECLARE @ListPriceInvalidErrorMessage VARCHAR(255) = 
      'New discount percent cannot be less than 0. ' +
      'Provided discount percent: ' + CAST (@NewDiscountPercent AS VARCHAR);
    THROW 1025003, @ListPriceInvalidErrorMessage, 1;
  END

  -- Perform the update!
  UPDATE [Products]
    SET DiscountPercent = @NewDiscountPercent
    WHERE ProductID = @ProductID
GO

-- Initial State
SELECT ProductID, DiscountPercent FROM Products WHERE ProductID = 1;

-- Test Validation
BEGIN TRY
  EXEC [spUpdateProductDiscount]
    @ProductId = 1, @NewDiscountPercent = -50;
END TRY BEGIN CATCH PRINT 'Error message: ' + ERROR_MESSAGE() END CATCH

-- Test Functionality
EXEC [spUpdateProductDiscount]
  @ProductId = 1, @NewDiscountPercent = 60;

-- End State
SELECT ProductID, DiscountPercent FROM Products WHERE ProductID = 1;

-- Section 6
-- Create a trigger named Products_UPDATE that checks the new value for the DiscountPercent
-- column of the Products table. This trigger should raise an appropriate error if the discount
-- percent is greater than 100 or less than 0.

-- If the new discount percent is between 0 and 1, this trigger should modify the new discount
-- percent by multiplying it by 100. That way, a discount percent of .2 becomes 20.

-- Test this trigger with an appropriate UPDATE statement.
USE MyGuitarShop;
DROP TRIGGER IF EXISTS [Products_UPDATE];

GO
CREATE TRIGGER [Products_UPDATE] ON [Products] FOR UPDATE AS
  -- Acquire variables
  DECLARE @ProductIDChar CHAR = CAST((SELECT ProductId FROM [inserted]) AS CHAR);
  DECLARE @NewDiscountPercent MONEY = (SELECT DiscountPercent FROM [inserted]);

  -- Validate the new discount percentage
  IF @NewDiscountPercent < 0 OR @NewDiscountPercent > 100 BEGIN
    DECLARE @DiscountPercentInvalidErrorMessage VARCHAR(255) = 
      'Discount percent must be between 0 and 100 (inclusive). ' +
      'Provided discount percent of ' + CAST(@NewDiscountPercent AS CHAR) +
      ' for product with ID ' + @ProductIDChar;
    THROW 1025004, @DiscountPercentInvalidErrorMessage, 1;
  END

  -- Normalize the discount percentage
  IF @NewDiscountPercent <= 1 BEGIN
    DECLARE @NormalizedDiscountPercent MONEY = @NewDiscountPercent * 100
    PRINT
      'Normalizing discount scalar of ' + CAST(@NewDiscountPercent AS CHAR) +
      ' to percentage of ' + CAST(@NormalizedDiscountPercent AS CHAR) +
      ' for product with ID ' + @ProductIDChar

    UPDATE [Products] SET DiscountPercent = @NormalizedDiscountPercent 
      FROM [Products] INNER JOIN [inserted]
      ON [Products].ProductID = [inserted].ProductID
  END
GO

BEGIN TRY
  UPDATE [Products] SET DiscountPercent = -22 WHERE ProductID = 1;
END TRY BEGIN CATCH PRINT 'Error message: ' + ERROR_MESSAGE() END CATCH

BEGIN TRY
  UPDATE [Products] SET DiscountPercent = 101 WHERE ProductID = 1;
END TRY BEGIN CATCH PRINT 'Error message: ' + ERROR_MESSAGE() END CATCH

UPDATE [Products] SET DiscountPercent = 0.22 WHERE ProductID = 1;

SELECT ProductID, DiscountPercent FROM Products WHERE ProductID = 1;

-- Section 7
-- Create a trigger named Products_INSERT that inserts the current date for the DateAdded column
-- of the Products table if the value for that column is null.

-- Test this trigger with an appropriate INSERT statement.
USE MyGuitarShop;
DROP TRIGGER IF EXISTS [Products_INSERT];

GO
CREATE TRIGGER [Products_INSERT] ON [Products] AFTER INSERT AS
  DECLARE @ProductIDChar CHAR = CAST((SELECT ProductId FROM [inserted]) AS CHAR);
  DECLARE @DateAdded DATETIME = (SELECT DateAdded FROM [inserted]);

  IF (@DateAdded) IS NULL BEGIN
    PRINT 
      'Null DateAdded detected inserting product with id ' + @ProductIDChar + '. ' +
      'DateAdded value will be set to ' + CAST(GETDATE() AS CHAR)
    UPDATE [Products] SET DateAdded = GETDATE() 
      FROM [Products] JOIN [inserted]
      ON [Products].ProductID = [inserted].ProductID;
  END
GO

INSERT INTO [Products] (
  ProductCode, ProductName, ListPrice, DiscountPercent, CategoryID, Description
) VALUES (
  'test_003', 'unimaginative test name', 100, 10, 1, ''
);
SELECT * FROM Products WHERE ProductCode = 'test_003';

-- Section 8
-- Create a table named ProductsAudit. This table should have all columns of the Products table,
-- except the Description column. Also, it should have an AuditID column for its primary key,
-- and the DateAdded column should be changed to DateUpdated.

-- Create a trigger named [Products_UPDATE_ProductAudit]. This trigger should insert the old
-- data about the product into the ProductsAudit table after the row is updated and set the
-- [DateUpdated] column to the current date and time. Then, test this trigger with an
-- appropriate UPDATE statement.
USE MyGuitarShop;

DROP TABLE IF EXISTS [ProductsAudit];
CREATE TABLE [ProductsAudit](
	AuditID INT IDENTITY(1,1) NOT NULL,
	ProductID INT NOT NULL,
	CategoryID INT NULL,
	ProductCode VARCHAR(10) NOT NULL,
	ProductName VARCHAR(255) NOT NULL,
	ListPrice MONEY NOT NULL,
	DiscountPercent MONEY NOT NULL,
	DateUpdated DATETIME NULL,
);

DROP TRIGGER IF EXISTS [Products_UPDATE_ProductAudit];

GO
CREATE TRIGGER [Products_UPDATE_ProductAudit] ON [Products] INSTEAD OF UPDATE AS
  DECLARE @ProductID CHAR = (SELECT ProductId FROM [inserted]);

  -- Secretly add the current values into the audit table 🤫
  INSERT INTO [ProductsAudit] (
    ProductID, CategoryID, ProductCode, ProductName, ListPrice, DiscountPercent, DateUpdated
  ) SELECT
      ProductID, CategoryID, ProductCode, ProductName, ListPrice, DiscountPercent, GETDATE()
    FROM [Products] WHERE [Products].ProductID = @ProductID

  -- Update the actual product table
  UPDATE [Products] SET
      CategoryID = [inserted].CategoryID, 
      ProductCode = [inserted].ProductCode, 
      ProductName = [inserted].ProductName, 
      Description = [inserted].Description, 
      ListPrice = [inserted].ListPrice, 
      DateAdded = [inserted].DateAdded, 
      DiscountPercent = [inserted].DiscountPercent
    FROM [Products] JOIN [inserted]
    ON [Products].ProductID = [inserted].ProductID
GO

UPDATE [Products] SET DiscountPercent = 40 WHERE ProductID = 1;
UPDATE [Products] SET DiscountPercent = 60 WHERE ProductID = 1;

SELECT * FROM [ProductsAudit];
SELECT * FROM [Products] WHERE ProductID = 1;




-- Clean up after ourselves
DELETE FROM [Categories] WHERE CategoryName IN ('Cowbells', 'Theremins');
DELETE FROM [Products] WHERE ProductCode LIKE 'test_%';
UPDATE [Products] SET DiscountPercent = 30 WHERE ProductID = 1;
DROP TABLE IF EXISTS [ProductsAudit];

