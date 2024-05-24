USE MyGuitarShop;

-- Section 1
-- Write a script that creates and calls a stored procedure named spInsertCategory. First, code
-- a statement that creates a procedure that adds a new row to the Categories table. To do that,
-- this procedure should have one parameter for the category name.
-- Code at least two EXEC statements that test this procedure. (Note that this table doesn’t
-- allow duplicate category names.)
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
    THROW 51000, @ErrorMessage, 1;
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
    THROW 51001, @ListPriceInvalidErrorMessage, 1;
  END

  IF @DiscountPercent < 0 BEGIN
    DECLARE @DiscountPercentInvalidErrorMessage VARCHAR(255) = 
      'Discount percent cannot be less than 0. ' +
      'Provided discount percent: ' + CAST (@DiscountPercent AS VARCHAR);
    THROW 51002, @DiscountPercentInvalidErrorMessage, 1;
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
    @ProductCode = 'prod_001', @ProductName = 'More Cowbell',
    @ListPrice = -10, @DiscountPercent = 0;
END TRY
BEGIN CATCH PRINT 'Error message: ' + ERROR_MESSAGE() END CATCH

BEGIN TRY
  EXEC [spInsertProduct]
    @ProductCode = 'prod_002', @ProductName = 'Even More Cowbell!!',
    @ListPrice = 100, @DiscountPercent = -33;
END TRY
BEGIN CATCH PRINT 'Error message: ' + ERROR_MESSAGE() END CATCH

-- Test functionality
DELETE FROM [Products] WHERE ProductCode IN ('prod_001', 'prod_002');

EXEC [spInsertProduct]
  @ProductCode = 'prod_001', @ProductName = 'More Cowbell',
  @ListPrice = 10, @DiscountPercent = 0;

EXEC [spInsertProduct]
  @ProductCode = 'prod_002', @ProductName = 'Even More Cowbell!!',
  @ListPrice = 100, @DiscountPercent = 33;

-- Final State
SELECT TOP 8 * FROM Products ORDER BY ProductID DESC;

-- Clean up after ourselves
DELETE FROM [Categories] WHERE CategoryName IN ('Cowbells', 'Theremins');
DELETE FROM [Products] WHERE ProductCode IN ('prod_001', 'prod_002');
