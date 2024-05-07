USE AP;
IF OBJECT_ID('SpBalanceRange') IS NOT NULL
  DROP PROCEDURE SpBalanceRange
GO

CREATE PROCEDURE SpBalanceRange
  @VendorVar VARCHAR(50) = '%',
  @BalanceMin MONEY = 0,
  @BalanceMax MONEY = 0
AS
  IF @BalanceMax = 0
    BEGIN
      SELECT 
        VendorName, InvoiceNumber,
        InvoiceTotal - CreditTotal - PaymentTotal AS Balance
      FROM Vendors JOIN Invoices ON
        Invoices.VendorID = Vendors.VendorID
      WHERE 
        VendorName LIKE @VendorVar AND
        (InvoiceTotal - CreditTotal - PaymentTotal) >= 0 AND
        (InvoiceTotal - CreditTotal - PaymentTotal) >= @BalanceMin
      ORDER BY Balance DESC;
    END;
  ELSE
    BEGIN
      SELECT
        VendorName, InvoiceNumber,
        InvoiceTotal - CreditTotal - PaymentTotal AS Balance
      FROM Vendors JOIN Invoices ON
        Invoices.VendorID = Vendors.VendorID
      WHERE 
        VendorName LIKE @VendorVar AND
        (InvoiceTotal - CreditTotal - PaymentTotal) >= 0 AND
        (InvoiceTotal - CreditTotal - PaymentTotal) BETWEEN @BalanceMin AND @BalanceMax
      ORDER BY Balance DESC;
    END;
  -- ENDIF
GO

-- Note: '%' is a wildcard, so the following will get all vendors with a name beginning with M
EXEC SpBalanceRange 'M%';

-- Explicitly define named parameters (parameters do not need to be in order!)
EXEC SpBalanceRange @BalanceMax = 1000, @BalanceMin = 200;

USE AP;
IF OBJECT_ID('SpDateRange') IS NOT NULL
  DROP PROCEDURE SpDateRange
GO

CREATE PROCEDURE SpDateRange
  @DateMin VARCHAR(50) = NULL,
  @DateMax VARCHAR(50) = NULL
AS
  IF @DateMin IS NULL OR @DateMax IS NULL
    THROW 50001, 'The DateMin and DateMax parameters are required.', 1

  IF NOT (ISDATE(@DateMin) = 1 AND ISDATE(@DateMax) = 1)
    THROW 50001, 'The date format is not valid. Please use mm/dd/yy', 1

  IF CAST(@DateMin AS DATE) > CAST(@DateMax AS DATE)
    THROW 50001, 'The DateMin must be earlier than DateMax', 1
  
  SELECT
    InvoiceNumber, InvoiceDate, InvoiceTotal,
    InvoiceTotal - CreditTotal - PaymentTotal AS Balance
  FROM Invoices
  WHERE InvoiceDate BETWEEN @DateMin AND @DateMax

-- TEST
BEGIN TRY
  EXEC spDateRange '2019/10/10', '2019/10/20'
END TRY
BEGIN CATCH
  PRINT 'Error Number: ' + CONVERT(VARCHAR, ERROR_NUMBER());
  PRINT 'Error Message: ' + CONVERT(VARCHAR, ERROR_MESSAGE());
END CATCH
