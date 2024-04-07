use AP;

/* Get all the invoices that are not yet fully paid (including credits) */
SELECT * FROM Invoices WHERE InvoiceTotal > (PaymentTotal + CreditTotal);
