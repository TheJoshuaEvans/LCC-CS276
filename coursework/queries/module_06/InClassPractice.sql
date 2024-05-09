USE AP;

DROP TABLE IF EXISTS ShippingLabels
CREATE TABLE ShippingLabels (
  VendorName varchar(50),
  VendorAddress1 varchar(50),
  VendorAddress2 varchar(50),
  VendorCity varchar(50),
  VendorState char(2),
  VendorZipCode varchar(20),
)

GO
DROP TRIGGER IF EXISTS Invoices_UPDATE_Shipping;

GO
CREATE TRIGGER Invoices_UPDATE_Shipping
  ON Invoices
  AFTER INSERT, UPDATE
AS
  INSERT ShippingLabels
  SELECT VendorName, VendorAddress1, VendorAddress2,
    VendorCity, VendorState, VendorZipCode
  From Vendors JOIN Inserted
  ON Vendors.VendorID = (SELECT VendorID FROM Inserted)
  WHERE
    Inserted.InvoiceTotal - Inserted.PaymentTotal - Inserted.CreditTotal <= 0;
GO

UPDATE Invoices
SET PaymentTotal = 10000, PaymentDate = '2020-02-23'
WHERE InvoiceID = 100;

UPDATE Invoices
SET PaymentTotal = 10000, PaymentDate = '2020-02-23'
WHERE InvoiceID = 8;

SELECT * FROM ShippingLabels;

DROP TABLE IF EXISTS TestUniqueNulls
CREATE TABLE TestUniqueNulls(
  RowID INT IDENTITY NOT NULL,
  NoDupName VARCHAR(20) NULL
);

GO
DROP TRIGGER IF EXISTS Invoices_UPDATE_Shipping;

GO
CREATE TRIGGER NoDuplicates
ON TestUniqueNulls
AFTER INSERT, UPDATE AS
BEGIN
  IF (
      SELECT COUNT(*)
      FROM TestUniqueNulls JOIN Inserted ON
        TestUniqueNulls.NoDupName = Inserted.NoDupName
    ) > 1
  BEGIN
    ROLLBACK TRAN;
    THROW 50001, 'Duplicate value.', 1;
  END;
END;
GO

INSERT into TestUniqueNulls VALUES (null);
INSERT into TestUniqueNulls VALUES (null);
INSERT into TestUniqueNulls VALUES ('Anne Boehm');
INSERT into TestUniqueNulls VALUES ('Anne Boehm');

SELECT * FROM TestUniqueNulls;
