USE AP;

/* Select all columns */
SELECT *
FROM Invoices;

/* Select specific columns */
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices;

/* Combine columns and have a space in an alias name */
SELECT InvoiceNumber, InvoiceDate, (CreditTotal + PaymentTotal) AS "Total Credit"
FROM Invoices
ORDER BY "Total Credit" DESC;

/* Filter by date */
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
WHERE InvoiceDate BETWEEN '2020-01-01' AND '2020-03-31'
ORDER BY InvoiceDate DESC;

/* Same as above, but with different conditionals */
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
WHERE InvoiceDate >= '2020-01-01' AND InvoiceDate <= '2020-03-31'
ORDER BY InvoiceDate DESC;

/* Retrieve distinct Vendor IDs */
SELECT DISTINCT VendorID
FROM Invoices;

/* Concatenate strings. Note that concatenate with "+" is only available in certain engines */
SELECT VendorName, (VendorCity + ', ' + VendorState + ' ' + VendorZipCode) as Address
FROM Vendors;

/* Concatenate strings with the CONCAT function */
SELECT VendorName, CONCAT(VendorCity, ', ', VendorState, ' ', VendorZipCode) as Address
FROM Vendors;

/* Filter a statement by state */
SELECT VendorName, CONCAT(VendorCity, ', ', VendorState, ' ', VendorZipCode) as Address
FROM Vendors
WHERE VendorState = 'IA';

/* Select all columns from multiple tables without a join (messy and gross!) */
SELECT *
FROM Invoices, Vendors;

/* Simple inner join */
SELECT InvoiceNumber, VendorName
FROM Vendors JOIN Invoices ON 
	Vendors.VendorID = Invoices.VendorID

/* Same as above but with aliases */
SELECT InvoiceNumber, VendorName
FROM Vendors AS V JOIN Invoices AS I ON 
	V.VendorID = I.VendorID

/* 
	A more complex join. Select all the invoices that have more than one line item. We know
	there is more than one line item if the invoice total is greater than the line item total(s)
*/
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceLineItemAmount
FROM Invoices JOIN InvoiceLineItems ON
	Invoices.InvoiceID = InvoiceLineItems.InvoiceID AND
	Invoices.InvoiceTotal > InvoiceLineItems.InvoiceLineItemAmount
ORDER BY InvoiceDate DESC

/* 
	Self referencing join. Note the need for aliases. Select all the distinct vendors that are in the
	same city / state as another vendor
*/
SELECT DISTINCT v1.VendorID, v1.VendorName, v1.VendorCity, v1.VendorState
FROM Vendors v1 JOIN Vendors v2 ON
	v1.VendorCity = v2.VendorCity AND
	v1.VendorState = v2.VendorState AND
	v1.VendorID <> v2.VendorID
ORDER BY v1.VendorCity, v1.VendorState

/* Same as above but with implicit join */
SELECT DISTINCT v1.VendorID, v1.VendorName, v1.VendorCity, v1.VendorState
FROM Vendors v1, vendors v2
WHERE 
	v1.VendorCity = v2.VendorCity AND
	v1.VendorState = v2.VendorState AND
	v1.VendorID <> v2.VendorID
ORDER BY v1.VendorCity, v1.VendorState

/* 
	Create new tables from a existing tables, then use UNION to combine them
*/
DROP TABLE IF EXISTS ActiveInvoices;
SELECT * INTO ActiveInvoices
FROM Invoices
WHERE (InvoiceTotal - PaymentTotal - CreditTotal) > 0;

DROP TABLE IF EXISTS PaidInvoices;
SELECT * INTO PaidInvoices
FROM Invoices
WHERE (InvoiceTotal - PaymentTotal - CreditTotal) <= 0;

SELECT 'Active' AS Source, InvoiceNumber, InvoiceDate, InvoiceTotal
FROM ActiveInvoices
UNION
SELECT 'Paid' AS Source, InvoiceNumber, InvoiceDate, InvoiceTotal
FROM  PaidInvoices
