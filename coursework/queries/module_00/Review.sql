INSERT INTO Invoices
(
	VendorID, InvoiceNumber, InvoiceDate, InvoiceTotal, TermsID, InvoiceDueDate
) 
VALUES
(
	100, '234512', '2/18/2020', 165, 3, '3/18/2020'
)

UPDATE Invoices
SET CreditTotal = 35.89
WHERE InvoiceNumber = '367447'

SELECT *
FROM Invoices
WHERE InvoiceNumber = '367447'

DELETE FROM Invoices
WHERE InvoiceNumber = '367447'
