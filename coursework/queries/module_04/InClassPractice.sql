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
