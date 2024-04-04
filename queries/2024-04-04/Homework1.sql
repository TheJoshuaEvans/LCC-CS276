/* Get the name and contact info of each vendor that has an unpaid invoice - as well as how much is owed */
SELECT
	VendorName, VendorPhone,
	VendorContactFName + ' ' + VendorContactLName AS VendorContactName,
	InvoiceNumber,
	InvoiceTotal - (PaymentTotal + CreditTotal) AS InvoiceAmountOwed
FROM Invoices
	JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
WHERE InvoiceTotal > (PaymentTotal + CreditTotal);

/* Get the name of all vendors that have more than one invoice */
SELECT Vendors.VendorID, VendorName
FROM Invoices
	JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
GROUP BY Vendors.VendorID, VendorName
HAVING COUNT(Invoices.VendorID) > 1;
