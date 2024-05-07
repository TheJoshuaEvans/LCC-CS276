USE AP;

DROP TABLE IF EXISTS ShippingLabels;
CREATE TABLE ShippingLabels(
    VendorID varchar(50),
    VendorName varchar(50),
    VendorAddress1 varchar(50),
    VendorAddress2 varchar(50),
    VendorCity varchar(50),
    VendorState char(2),
    VendorZipCode varchar(20)
);

SELECT * FROM ShippingLabels;

DROP TRIGGER IF EXISTS Invoices_UPDATE_Shipping;

DELIMITER //
CREATE TRIGGER Invoices_UPDATE_Shipping
AFTER UPDATE
ON Invoices
FOR EACH ROW
BEGIN
    INSERT INTO ShippingLabels(
        VendorID, VendorName, VendorAddress1, VendorAddress2,
        VendorCity, VendorState, VendorZipCode
    )
    SELECT
        Vendors.VendorID, Vendors.VendorName, Vendors.VendorAddress1, Vendors.VendorAddress2,
        Vendors.VendorCity, Vendors.VendorState, Vendors.VendorZipCode
    FROM Vendors
    JOIN Invoices ON Vendors.VendorID = NEW.VendorID
    WHERE 
        NEW.InvoiceTotal - NEW.PaymentTotal - NEW.CreditTotal <= 0 AND
        NEW.InvoiceID = Invoices.InvoiceID;
END;//
DELIMITER ;

UPDATE Invoices
SET PaymentTotal = 10000, PaymentDate = '2020-02-23'
WHERE InvoiceID = 8;

UPDATE Invoices
SET PaymentTotal = 10000, PaymentDate = '2020-02-23'
WHERE InvoiceID = 100;

UPDATE Invoices
SET PaymentTotal = 10000, PaymentDate = '2020-02-23'
WHERE InvoiceID = 12;

SELECT * FROM ShippingLabels;

-- Check for Uniqueness
USE AP;
DROP TABLE IF EXISTS TestUniqueNulls;
CREATE TABLE TestUniqueNulls(
  RowID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  NoDupName VARCHAR(20) NULL
);

DELIMITER //
CREATE TRIGGER NoDuplicates
AFTER INSERT ON TestUniqueNulls
FOR EACH ROW
BEGIN
    DECLARE count_rows INT;
    SELECT COUNT(*) INTO count_rows
    FROM TestUniqueNulls
    WHERE NoDupName <=> NEW.NoDupName;

    IF count_rows > 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Duplicate value.';
    END IF;
END;//
DELIMITER ;

INSERT into TestUniqueNulls (NoDupName) VALUES (null);
INSERT into TestUniqueNulls (NoDupName) VALUES (null);
INSERT into TestUniqueNulls (NoDupName) VALUES ('Anne Boehm');
INSERT into TestUniqueNulls (NoDupName) VALUES ('Anne Boehm');

SELECT * FROM TestUniqueNulls;

