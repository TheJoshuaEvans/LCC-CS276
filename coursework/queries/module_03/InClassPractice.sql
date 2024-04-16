/*
	On 2022-05-11, customer 1001 makes 30 day credit purchase of
	one unit of product 11QER/31 with a unit price of $110.00; taxed at 8%
	Invoice number is 10983, and this invoice only has one product line

	(note, this example doesn't match any existing databases)
*/
BEGIN
	-- Add the invoice
	INSERT INTO Invoices
		VALUES(10983, '10010', '2022-05-11', 118.80, '30', 'OPEN');
	-- Add the invoice line item
	INSERT INTO InvoiceLineItems
		VALUES(10983, 1, '11QER/31', 1, 110.00);
	-- Update the product quantity
	UPDATE Products
		SET P_Qty = P_Qty - 1
		WHERE P_Code = '11QER/31';
	-- Update the customer balance
	UPDATE Customer
		SET Cus_DatePurchase = '2022-05-11',
			Cus_Balance = Cus_Balance + 118.80
		WHERE Cus_Code = 10983;
COMMIT;
