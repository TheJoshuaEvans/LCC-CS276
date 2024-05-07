/* In class view practice */
use AP;

-- VIEW PRACTICE
-- Create the view
DROP VIEW IF EXISTS VendorsMin;
GO
CREATE VIEW VendorsMin AS
SELECT VendorName, VendorState, VendorPhone
FROM Vendors;
GO

-- Values in a view can be updated, and propagate to the actual table
UPDATE VendorsMin
SET VendorPhone = '(801) 555-8725'
WHERE VendorState = 'Ca' AND VendorName = 'Jobtrak';

SELECT *
FROM VendorsMin
WHERE VendorState = 'Ca' AND VendorName = 'Jobtrak';

SELECT *
FROM Vendors
WHERE VendorState = 'Ca' AND VendorName = 'Jobtrak';

-- Create a view with named fields
DROP VIEW IF EXISTS OutstandingInvoices;
GO
CREATE VIEW OutstandingInvoices(
  InvoiceNumber,
  InvoiceDate,
  InvoiceTotal,
  Balance
) AS
SELECT
  InvoiceNumber,
  InvoiceDate,
  InvoiceTotal,
  InvoiceTotal - PaymentTotal - CreditTotal
FROM Invoices;
GO

SELECT * FROM OutstandingInvoices;

-- Create a view with a join
DROP VIEW IF EXISTS InvoiceSummary;
GO
CREATE VIEW InvoiceSummary AS
SELECT 
  VendorName,
  COUNT(*) AS InvoiceQty,
  SUM(InvoiceTotal) AS InvoiceSum
FROM Vendors JOIN
  Invoices ON Vendors.VendorId = Invoices.InvoiceID
GROUP BY VendorName;
GO

SELECT * FROM InvoiceSummary;

-- Clean up after ourselves
DROP VIEW IF EXISTS VendorsMin
DROP VIEW IF EXISTS OutstandingInvoices
DROP VIEW IF EXISTS InvoiceSummary

/* Some scripting! */
-- Simple example script
USE AP;

DECLARE @totalDue MONEY
SET @totalDue = (
  SELECT SUM(InvoiceTotal - PaymentTotal - CreditTotal)
  FROM Invoices
);

IF @totalDue > 0
  PRINT 'Total Invoices Due = $' + CONVERT(VARCHAR, @totalDue, 1);
ELSE
  PRINT 'Invoice paid in full';
GO

-- Script that uses a bunch of variables
USE AP;
DECLARE @MaxInvoice MONEY, @minInvoice MONEY;
DECLARE @PercentDifference DECIMAL(8,2);
DECLARE @InvoiceCount INT, @VendorIdVar INT;

SET @VendorIdVar = 95;
SET @MaxInvoice = (
  SELECT MAX(InvoiceTotal)
  FROM Invoices
  WHERE VendorID = @VendorIdVar
);

SELECT @minInvoice = MIN(InvoiceTotal), @InvoiceCount = COUNT(*)
FROM Invoices
WHERE VendorID = @VendorIdVar;

SET @PercentDifference = (@MaxInvoice - @minInvoice) / @minInvoice * 100;

PRINT 'Maximum invoice is $' + CONVERT(VARCHAR, @MaxInvoice, 1);
PRINT 'Minimum invoice is $' + CONVERT(VARCHAR, @minInvoice, 1);
PRINT 'Maximum is ' + CONVERT(VARCHAR, @PercentDifference) + '% more than minimum'
PRINT 'Number of invoices: ' + CONVERT(VARCHAR, @InvoiceCount) + '.';
GO

-- Declare statement for a table variable
USE AP;

DECLARE @BigVendors TABLE(
  VendorID INT,
  VendorName VARCHAR(50)
);

INSERT @BigVendors
SELECT VendorID, VendorName
FROM Vendors
WHERE VendorID IN (
  SELECT VendorId FROM Invoices WHERE InvoiceTotal > 5000
)

/* The @BigVendors table variable will only exist in the script where it is run */
SELECT * FROM @BigVendors;
GO

-- Temporary Table
SELECT TOP 1 VendorID, AVG(InvoiceTotal) AS AvgInvoice
INTO #TopVendors
FROM Invoices
GROUP BY VendorID
ORDER BY AvgInvoice DESC;
GO

/* We can keep using the temp table as long as we are in the session */
SELECT Invoices.VendorID, MAX(InvoiceDate) AS LatestInv
FROM Invoices JOIN #TopVendors
  ON Invoices.VendorID = #TopVendors.VendorID
GROUP BY Invoices.VendorID
GO

-- Script with IF statement
USE AP;
DECLARE @EarliestInvoiceDue DATE;

SELECT @EarliestInvoiceDue = MIN(InvoiceDueDate)
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;

IF @EarliestInvoiceDue < GETDATE()
  PRINT 'Outstanding invoices overdue!';

GO

-- IF - ELSE
USE AP;
DECLARE @MinInvoiceDue MONEY, @MaxInvoiceDue MONEY;
DECLARE @EarliestInvoiceDue DATE, @LatestInvoiceDue DATE;
SELECT
  @MinInvoiceDue = MIN(InvoiceTotal - PaymentTotal - CreditTotal),
  @MaxInvoiceDue = MAX(InvoiceTotal - PaymentTotal - CreditTotal),
  @EarliestInvoiceDue = MIN(InvoiceDueDate),
  @LatestInvoiceDue = MAX(InvoiceDueDate)
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;

IF @EarliestInvoiceDue < GETDATE()
  BEGIN
    PRINT 'Outstanding invoices overdue!';
    PRINT 'Dated ' +
      CONVERT(VARCHAR, @EarliestInvoiceDue, 1) +
      ' through ' +
      CONVERT(VARCHAR, @LatestInvoiceDue, 1) + '.';
    PRINT 'Amounting from $' +
      CONVERT(VARCHAR, @MinInvoiceDue, 1) +
      ' to $' +
      CONVERT(VARCHAR, @MaxInvoiceDue, 1) + '.';
  END;
GO

-- While statement
USE AP;
IF OBJECT_ID('tempdb..#InvoiceCopy') IS NOT NULL
  DROP TABLE #InvoiceCopy;

SELECT * INTO #InvoiceCopy FROM Invoices
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0;

WHILE (SELECT SUM(InvoiceTotal - CreditTotal - PaymentTotal) FROM #InvoiceCopy) >= 20000
  BEGIN
    UPDATE #InvoiceCopy
    SET CreditTotal = CreditTotal + 1
    WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0;

    IF (SELECT MAX(CreditTotal) FROM #InvoiceCopy) > 3000
      BREAK;
    ELSE
      CONTINUE;
  END;

SELECT InvoiceDate, InvoiceTotal, CreditTotal
FROM #InvoiceCopy

-- Try Catch
BEGIN TRY
  INSERT Invoices VALUES(
    799, 'ZXK-799', '2020-03-07', 299.95, 0, 0, 1, '2020-04-06', NULL
  );
  PRINT 'SUCCESS: Record was inserted!'
END TRY
BEGIN CATCH
  PRINT 'FAILURE: Record was not inserted.';
  PRINT 'Error ' + CONVERT(VARCHAR, ERROR_NUMBER(), 1) +
    ': ' + ERROR_MESSAGE();
END CATCH
GO

-- Insert new vendor and invoice
USE AP;
DECLARE @MyIdentity INT, @MyRowCount INT;

INSERT Vendors (
  VendorName, VendorAddress1, VendorCity, VendorState, VendorZipCode, VendorPhone,
  DefaultTermsID, DefaultAccountNo
) VALUES (
  'Peerless Binding', '1112 S Windsor St', 'Hallowell', 'ME', '04347', '(207) 555-1555',
   4, 400
)

SET @MyIdentity = @@IDENTITY;
SET @MyRowCount = @@ROWCOUNT;

IF @MyRowCount = 1
  INSERT Invoices
  VALUES (@MyIdentity, 'BA-0199', '2020-03-01', 4598.23, 0, 0, 4, '2020-04-30', NULL)

-- Syntax for EXEC
USE AP;
DECLARE @TableNameVar VARCHAR(128)

SET @TableNameVar = 'Invoices';
EXEC ('SELECT * FROM ' + @TableNameVar + ';');

SELECT * FROM Invoices;

