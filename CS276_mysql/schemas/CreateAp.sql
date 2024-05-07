


/****** Object:  Database AP     ******/
DROP DATABASE IF EXISTS AP;

CREATE DATABASE AP
;

USE `AP`
;

/****** Object:  Table `ContactUpdates`    Script Date: 2/14/2020 12:45:55 PM ******/


CREATE TABLE IF NOT EXISTS `ContactUpdates`(
	`VendorID` int AUTO_INCREMENT PRIMARY KEY NOT NULL,
	`LastName` varchar(50) NULL,
	`FirstName` varchar(50) NULL
)
;

/****** Object:  Table `GLAccounts`    Script Date: 2/14/2020 12:45:55 PM ******/


CREATE TABLE IF NOT EXISTS `GLAccounts`(
	`AccountNo` int NOT NULL,
	`AccountDescription` varchar(50) NOT NULL,
 CONSTRAINT `PK_GLAccounts` PRIMARY KEY
(
	`AccountNo` ASC
)
)
;

/****** Object:  Table `InvoiceArchive`    Script Date: 2/14/2020 12:45:55 PM ******/


CREATE TABLE IF NOT EXISTS `InvoiceArchive`(
	`InvoiceID` int NOT NULL,
	`VendorID` int NOT NULL,
	`InvoiceNumber` varchar(50) NOT NULL,
	`InvoiceDate` datetime NOT NULL,
	`InvoiceTotal` decimal(12,2) NOT NULL,
	`PaymentTotal` decimal(12,2) NOT NULL,
	`CreditTotal` decimal(12,2) NOT NULL,
	`TermsID` int NOT NULL,
	`InvoiceDueDate` datetime NOT NULL,
	`PaymentDate` datetime NULL
)
;

/****** Object:  Table `InvoiceLineItems`    Script Date: 2/14/2020 12:45:55 PM ******/


CREATE TABLE IF NOT EXISTS `InvoiceLineItems`(
	`InvoiceID` int NOT NULL,
	`InvoiceSequence` int NOT NULL,
	`AccountNo` int NOT NULL,
	`InvoiceLineItemAmount` decimal(12,2) NOT NULL,
	`InvoiceLineItemDescription` varchar(100) NOT NULL,
 CONSTRAINT `PK_InvoiceLineItems` PRIMARY KEY
(
	`InvoiceID` ASC,
	`InvoiceSequence` ASC
)
)
;

/****** Object:  Table `Invoices`    Script Date: 2/14/2020 12:45:55 PM ******/


CREATE TABLE IF NOT EXISTS `Invoices`(
	`InvoiceID` int AUTO_INCREMENT NOT NULL,
	`VendorID` int NOT NULL,
	`InvoiceNumber` varchar(50) NOT NULL,
	`InvoiceDate` datetime NOT NULL,
	`InvoiceTotal` decimal(12,2) NOT NULL,
	`PaymentTotal` decimal(12,2) NOT NULL,
	`CreditTotal` decimal(12,2) NOT NULL,
	`TermsID` int NOT NULL,
	`InvoiceDueDate` datetime NOT NULL,
	`PaymentDate` datetime NULL,
 CONSTRAINT `PK_Invoices` PRIMARY KEY
(
	`InvoiceID` ASC
)
)
;

/****** Object:  Table `Terms`    Script Date: 2/14/2020 12:45:55 PM ******/


CREATE TABLE IF NOT EXISTS `Terms`(
	`TermsID` int AUTO_INCREMENT NOT NULL,
	`TermsDescription` varchar(50) NOT NULL,
	`TermsDueDays` int NOT NULL,
 CONSTRAINT `PK_Terms` PRIMARY KEY
(
	`TermsID` ASC
)
)
;

/****** Object:  Table `Vendors`    Script Date: 2/14/2020 12:45:55 PM ******/


CREATE TABLE IF NOT EXISTS `Vendors`(
	`VendorID` int AUTO_INCREMENT NOT NULL,
	`VendorName` varchar(50) NOT NULL,
	`VendorAddress1` varchar(50) NULL,
	`VendorAddress2` varchar(50) NULL,
	`VendorCity` varchar(50) NOT NULL,
	`VendorState` varchar(2) NOT NULL,
	`VendorZipCode` varchar(20) NOT NULL,
	`VendorPhone` varchar(50) NULL,
	`VendorContactLName` varchar(50) NULL,
	`VendorContactFName` varchar(50) NULL,
	`DefaultTermsID` int NOT NULL,
	`DefaultAccountNo` int NOT NULL,
 CONSTRAINT `PK_Vendors` PRIMARY KEY
(
	`VendorID` ASC
)
)
;


INSERT `ContactUpdates` (`VendorID`, `LastName`, `FirstName`) VALUES (5, 'Davison', 'Michelle');
INSERT `ContactUpdates` (`VendorID`, `LastName`, `FirstName`) VALUES (12, 'Mayteh', 'Kendall');
INSERT `ContactUpdates` (`VendorID`, `LastName`, `FirstName`) VALUES (17, 'Onandonga', 'Bruce');
INSERT `ContactUpdates` (`VendorID`, `LastName`, `FirstName`) VALUES (44, 'Antavius', 'Anthony');
INSERT `ContactUpdates` (`VendorID`, `LastName`, `FirstName`) VALUES (76, 'Bradlee', 'Danny');
INSERT `ContactUpdates` (`VendorID`, `LastName`, `FirstName`) VALUES (94, 'Suscipe', 'Reynaldo');
INSERT `ContactUpdates` (`VendorID`, `LastName`, `FirstName`) VALUES (101, 'O''Sullivan', 'Geraldine');
INSERT `ContactUpdates` (`VendorID`, `LastName`, `FirstName`) VALUES (123, 'Bucket', 'Charles');

INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (100, 'Cash');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (110, 'Accounts Receivable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (120, 'Book Inventory');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (150, 'Furniture');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (160, 'Computer Equipment');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (162, 'Capitalized Lease');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (167, 'Software');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (170, 'Other Equipment');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (181, 'Book Development');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (200, 'Accounts Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (205, 'Royalties Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (221, '401K Employee Contributions');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (230, 'Sales Taxes Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (234, 'Medicare Taxes Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (235, 'Income Taxes Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (237, 'State Payroll Taxes Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (238, 'Employee FICA Taxes Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (239, 'Employer FICA Taxes Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (241, 'Employer FUTA Taxes Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (242, 'Employee SDI Taxes Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (243, 'Employer UCI Taxes Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (251, 'IBM Credit Corporation Payable');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (280, 'Capital Stock');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (290, 'Retained Earnings');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (300, 'Retail Sales');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (301, 'College Sales');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (302, 'Trade Sales');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (306, 'Consignment Sales');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (310, 'Compositing Revenue');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (394, 'Book Club Royalties');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (400, 'Book Printing Costs');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (403, 'Book Production Costs');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (500, 'Salaries and Wages');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (505, 'FICA');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (506, 'FUTA');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (507, 'UCI');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (508, 'Medicare');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (510, 'Group Insurance');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (520, 'Building Lease');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (521, 'Utilities');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (522, 'Telephone');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (523, 'Building Maintenance');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (527, 'Computer Equipment Maintenance');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (528, 'IBM Lease');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (532, 'Equipment Rental');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (536, 'Card Deck Advertising');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (540, 'Direct Mail Advertising');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (541, 'Space Advertising');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (546, 'Exhibits and Shows');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (548, 'Web Site Production and Fees');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (550, 'Packaging Materials');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (551, 'Business Forms');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (552, 'Postage');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (553, 'Freight');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (555, 'Collection Agency Fees');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (556, 'Credit Card Handling');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (565, 'Bank Fees');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (568, 'Auto License Fee');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (569, 'Auto Expense');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (570, 'Office Supplies');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (572, 'Books, Dues, and Subscriptions');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (574, 'Business Licenses and Taxes');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (576, 'PC Software');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (580, 'Meals');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (582, 'Travel and Accomodations');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (589, 'Outside Services');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (590, 'Business Insurance');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (591, 'Accounting');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (610, 'Charitable Contributions');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (611, 'Profit Sharing Contributions');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (620, 'Interest Paid to Banks');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (621, 'Other Interest');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (630, 'Federal Corporation Income Taxes');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (631, 'State Corporation Income Taxes');
INSERT `GLAccounts` (`AccountNo`, `AccountDescription`) VALUES (632, 'Sales Tax');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (1, 1, 553, 3813.3300, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (2, 1, 553, 40.2000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (3, 1, 553, 138.7500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (4, 1, 553, 144.7000, 'Int''l shipment');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (5, 1, 553, 15.5000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (6, 1, 553, 42.7500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (7, 1, 553, 172.5000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (8, 1, 522, 95.0000, 'Telephone service');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (9, 1, 403, 601.9500, 'Cover design');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (10, 1, 553, 42.6700, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (11, 1, 553, 42.5000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (12, 1, 580, 50.0000, 'DiCicco''s');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (12, 2, 570, 75.6000, 'Kinko''s');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (12, 3, 570, 58.4000, 'Office Max');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (12, 4, 540, 478.0000, 'Publishers Marketing');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (13, 1, 522, 16.3300, 'Telephone (line 5)');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (14, 1, 553, 6.0000, 'Freight out');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (15, 1, 574, 856.9200, 'Property Taxes');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (16, 1, 572, 9.9500, 'Monthly access fee');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (17, 1, 553, 10.0000, 'Address correction');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (18, 1, 553, 104.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (19, 1, 160, 116.5400, 'MVS Online Library');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (20, 1, 553, 6.0000, 'Freight out');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (21, 1, 589, 4901.2600, 'Office lease');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (22, 1, 553, 108.2500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (23, 1, 572, 9.9500, 'Monthly access fee');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (24, 1, 520, 1750.0000, 'Warehouse lease');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (25, 1, 553, 129.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (26, 1, 553, 10.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (27, 1, 540, 207.7800, 'Prospect list');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (28, 1, 553, 109.5000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (29, 1, 523, 450.0000, 'Back office additions');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (30, 1, 553, 63.4000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (31, 1, 589, 7125.3400, 'Web site design');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (32, 1, 403, 953.1000, 'Crash Course revision');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (33, 1, 591, 220.0000, 'Form 571-L');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (34, 1, 553, 127.7500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (35, 1, 507, 1600.0000, 'Income Tax');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (36, 1, 403, 565.1500, 'Crash Course Ad');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (37, 1, 553, 36.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (38, 1, 553, 61.5000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (39, 1, 400, 37966.1900, 'CICS Desk Reference');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (40, 1, 403, 639.7700, 'Card deck');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (41, 1, 553, 53.7500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (42, 1, 553, 400.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (43, 1, 400, 21842.0000, 'Book repro');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (44, 1, 522, 19.6700, 'Telephone (Line 3)');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (45, 1, 553, 2765.3600, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (46, 1, 510, 224.0000, 'Health Insurance');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (47, 1, 572, 1575.0000, 'Catalog ad');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (48, 1, 553, 33.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (49, 1, 522, 16.3300, 'Telephone (line 6)');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (50, 1, 510, 116.0000, 'Health Insurance');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (51, 1, 553, 2184.1100, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (52, 1, 160, 1083.5800, 'MSDN');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (53, 1, 522, 46.2100, 'Telephone (Line 1)');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (54, 1, 403, 313.5500, 'Card revision');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (55, 1, 553, 40.7500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (56, 1, 572, 2433.0000, 'Card deck');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (57, 1, 589, 1367.5000, '401K Contributions');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (58, 1, 553, 53.2500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (59, 1, 553, 13.7500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (60, 1, 553, 2312.2000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (61, 1, 553, 25.6700, 'Freight out');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (62, 1, 553, 26.7500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (63, 1, 553, 2115.8100, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (64, 1, 553, 23.5000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (65, 1, 400, 6940.2500, 'OS Utilities');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (66, 1, 553, 31.9500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (67, 1, 553, 1927.5400, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (68, 1, 160, 936.9300, 'Quarterly Maintenance');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (69, 1, 540, 175.0000, 'Card deck advertising');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (70, 1, 553, 6.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (71, 1, 553, 108.5000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (72, 1, 553, 10.0000, 'Address correction');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (73, 1, 552, 290.0000, 'International pkg.');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (74, 1, 570, 41.8000, 'Coffee');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (75, 1, 553, 27.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (76, 1, 553, 241.0000, 'Int''l shipment');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (77, 1, 403, 904.1400, 'Cover design');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (78, 1, 403, 1197.0000, 'Cover design');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (78, 2, 540, 765.1300, 'Catalog design');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (79, 1, 540, 2184.5000, 'PC card deck');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (80, 1, 553, 2318.0300, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (81, 1, 553, 26.2500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (82, 1, 150, 17.5000, 'Supplies');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (83, 1, 522, 39.7700, 'Telephone (Line 2)');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (84, 1, 553, 111.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (85, 1, 553, 158.0000, 'Int''l shipment');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (86, 1, 553, 739.2000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (87, 1, 553, 60.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (88, 1, 553, 147.2500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (89, 1, 400, 85.3100, 'Book copy');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (90, 1, 553, 38.7500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (91, 1, 522, 32.7000, 'Telephone (line 4)');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (92, 1, 521, 16.6200, 'Propane-forklift');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (93, 1, 553, 162.7500, 'International shipment');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (94, 1, 553, 52.2500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (95, 1, 572, 600.0000, 'Books for research');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (96, 1, 400, 26881.4000, 'MVS JCL');

INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (97, 1, 170, 356.4800, 'Network wiring');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (98, 1, 572, 579.4200, 'Catalog ad');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (99, 1, 553, 59.9700, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (100, 1, 553, 67.9200, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (101, 1, 553, 30.7500, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (102, 1, 400, 20551.1800, 'CICS book printing');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (103, 1, 553, 2051.5900, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (104, 1, 553, 44.4400, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (105, 1, 582, 503.2000, 'Bronco lease');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (106, 1, 400, 23517.5800, 'DB2 book printing');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (107, 1, 553, 3689.9900, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (108, 1, 553, 67.0000, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (109, 1, 403, 1000.4600, 'Crash Course covers');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (110, 1, 540, 90.3600, 'Card deck advertising');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (111, 1, 553, 22.5700, 'Freight');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (112, 1, 400, 10976.0600, 'VSAM book printing');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (113, 1, 510, 224.0000, 'Health Insurance');
INSERT `InvoiceLineItems` (`InvoiceID`, `InvoiceSequence`, `AccountNo`, `InvoiceLineItemAmount`, `InvoiceLineItemDescription`) VALUES (114, 1, 553, 127.7500, 'Freight');


INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (1, 122, '989319-457', CAST('2019-10-08' AS Date), 3813.3300, 3813.3300, 0.0000, 3, CAST('2019-11-08' AS Date), CAST('2019-11-07' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (2, 123, '263253241', CAST('2019-10-10' AS Date), 40.2000, 40.2000, 0.0000, 3, CAST('2019-11-10' AS Date), CAST('2019-11-14' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (3, 123, '963253234', CAST('2019-10-13' AS Date), 138.7500, 138.7500, 0.0000, 3, CAST('2019-11-13' AS Date), CAST('2019-11-09' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (4, 123, '2-000-2993', CAST('2019-10-16' AS Date), 144.7000, 144.7000, 0.0000, 3, CAST('2019-11-16' AS Date), CAST('2019-11-12' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (5, 123, '963253251', CAST('2019-10-16' AS Date), 15.5000, 15.5000, 0.0000, 3, CAST('2019-11-16' AS Date), CAST('2019-11-11' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (6, 123, '963253261', CAST('2019-10-16' AS Date), 42.7500, 42.7500, 0.0000, 3, CAST('2019-11-16' AS Date), CAST('2019-11-21' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (7, 123, '963253237', CAST('2019-10-21' AS Date), 172.5000, 172.5000, 0.0000, 3, CAST('2019-11-21' AS Date), CAST('2019-11-22' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (8, 89, '125520-1', CAST('2019-10-24' AS Date), 95.0000, 95.0000, 0.0000, 1, CAST('2019-11-04' AS Date), CAST('2019-11-01' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (9, 121, '97/488', CAST('2019-10-24' AS Date), 601.9500, 601.9500, 0.0000, 3, CAST('2019-11-24' AS Date), CAST('2019-11-21' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (10, 123, '263253250', CAST('2019-10-24' AS Date), 42.6700, 42.6700, 0.0000, 3, CAST('2019-11-24' AS Date), CAST('2019-11-22' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (11, 123, '963253262', CAST('2019-10-25' AS Date), 42.5000, 42.5000, 0.0000, 3, CAST('2019-11-25' AS Date), CAST('2019-11-20' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (12, 96, 'I77271-O01', CAST('2019-10-26' AS Date), 662.0000, 662.0000, 0.0000, 2, CAST('2019-11-16' AS Date), CAST('2019-11-13' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (13, 95, '111-92R-10096', CAST('2019-10-30' AS Date), 16.3300, 16.3300, 0.0000, 2, CAST('2019-11-20' AS Date), CAST('2019-11-23' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (14, 115, '25022117', CAST('2019-11-01' AS Date), 6.0000, 6.0000, 0.0000, 4, CAST('2019-12-10' AS Date), CAST('2019-12-10' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (15, 48, 'P02-88D77S7', CAST('2019-11-03' AS Date), 856.9200, 856.9200, 0.0000, 3, CAST('2019-12-02' AS Date), CAST('2019-11-30' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (16, 97, '21-4748363', CAST('2019-11-03' AS Date), 9.9500, 9.9500, 0.0000, 2, CAST('2019-11-23' AS Date), CAST('2019-11-22' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (17, 123, '4-321-2596', CAST('2019-11-05' AS Date), 10.0000, 10.0000, 0.0000, 3, CAST('2019-12-04' AS Date), CAST('2019-12-05' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (18, 123, '963253242', CAST('2019-11-06' AS Date), 104.0000, 104.0000, 0.0000, 3, CAST('2019-12-05' AS Date), CAST('2019-12-05' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (19, 34, 'QP58872', CAST('2019-11-07' AS Date), 116.5400, 116.5400, 0.0000, 1, CAST('2019-11-17' AS Date), CAST('2019-11-19' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (20, 115, '24863706', CAST('2019-11-10' AS Date), 6.0000, 6.0000, 0.0000, 4, CAST('2019-12-19' AS Date), CAST('2019-12-15' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (21, 119, '10843', CAST('2019-11-11' AS Date), 4901.2600, 4901.2600, 0.0000, 2, CAST('2019-11-30' AS Date), CAST('2019-11-29' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (22, 123, '963253235', CAST('2019-11-11' AS Date), 108.2500, 108.2500, 0.0000, 3, CAST('2019-12-10' AS Date), CAST('2019-12-09' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (23, 97, '21-4923721', CAST('2019-11-13' AS Date), 9.9500, 9.9500, 0.0000, 2, CAST('2019-12-02' AS Date), CAST('2019-11-28' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (24, 113, '77290', CAST('2019-11-13' AS Date), 1750.0000, 1750.0000, 0.0000, 5, CAST('2020-01-02' AS Date), CAST('2020-01-05' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (25, 123, '963253246', CAST('2019-11-13' AS Date), 129.0000, 129.0000, 0.0000, 3, CAST('2019-12-12' AS Date), CAST('2019-12-09' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (26, 123, '4-342-8069', CAST('2019-11-14' AS Date), 10.0000, 10.0000, 0.0000, 3, CAST('2019-12-13' AS Date), CAST('2019-12-13' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (27, 88, '972110', CAST('2019-11-15' AS Date), 207.7800, 207.7800, 0.0000, 1, CAST('2019-11-25' AS Date), CAST('2019-11-27' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (28, 123, '963253263', CAST('2019-11-16' AS Date), 109.5000, 109.5000, 0.0000, 3, CAST('2019-12-15' AS Date), CAST('2019-12-10' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (29, 108, '121897', CAST('2019-11-19' AS Date), 450.0000, 450.0000, 0.0000, 4, CAST('2019-12-28' AS Date), CAST('2020-01-03' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (30, 123, '1-200-5164', CAST('2019-11-20' AS Date), 63.4000, 63.4000, 0.0000, 3, CAST('2019-12-19' AS Date), CAST('2019-12-24' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (31, 104, 'P02-3772', CAST('2019-11-21' AS Date), 7125.3400, 7125.3400, 0.0000, 3, CAST('2019-12-20' AS Date), CAST('2019-12-24' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (32, 121, '97/486', CAST('2019-11-21' AS Date), 953.1000, 953.1000, 0.0000, 3, CAST('2019-12-20' AS Date), CAST('2019-12-22' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (33, 105, '94007005', CAST('2019-11-23' AS Date), 220.0000, 220.0000, 0.0000, 3, CAST('2019-12-22' AS Date), CAST('2019-12-26' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (34, 123, '963253232', CAST('2019-11-23' AS Date), 127.7500, 127.7500, 0.0000, 3, CAST('2019-12-22' AS Date), CAST('2019-12-18' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (35, 107, 'RTR-72-3662-X', CAST('2019-11-25' AS Date), 1600.0000, 1600.0000, 0.0000, 4, CAST('2020-01-04' AS Date), CAST('2020-01-09' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (36, 121, '97/465', CAST('2019-11-25' AS Date), 565.1500, 565.1500, 0.0000, 3, CAST('2019-12-24' AS Date), CAST('2019-12-24' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (37, 123, '963253260', CAST('2019-11-25' AS Date), 36.0000, 36.0000, 0.0000, 3, CAST('2019-12-24' AS Date), CAST('2019-12-26' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (38, 123, '963253272', CAST('2019-11-26' AS Date), 61.5000, 61.5000, 0.0000, 3, CAST('2019-12-25' AS Date), CAST('2019-12-28' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (39, 110, '0-2058', CAST('2019-11-28' AS Date), 37966.1900, 37966.1900, 0.0000, 3, CAST('2019-12-27' AS Date), CAST('2019-12-28' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (40, 121, '97/503', CAST('2019-11-30' AS Date), 639.7700, 639.7700, 0.0000, 3, CAST('2019-12-28' AS Date), CAST('2019-12-25' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (41, 123, '963253255', CAST('2019-11-30' AS Date), 53.7500, 53.7500, 0.0000, 3, CAST('2019-12-28' AS Date), CAST('2019-12-27' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (42, 123, '94007069', CAST('2019-11-30' AS Date), 400.0000, 400.0000, 0.0000, 3, CAST('2019-12-28' AS Date), CAST('2020-01-01' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (43, 72, '40318', CAST('2019-12-01' AS Date), 21842.0000, 21842.0000, 0.0000, 3, CAST('2020-01-01' AS Date), CAST('2019-12-28' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (44, 95, '111-92R-10094', CAST('2019-12-01' AS Date), 19.6700, 19.6700, 0.0000, 2, CAST('2019-12-21' AS Date), CAST('2019-12-24' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (45, 122, '989319-437', CAST('2019-12-01' AS Date), 2765.3600, 2765.3600, 0.0000, 3, CAST('2020-01-01' AS Date), CAST('2019-12-28' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (46, 37, '547481328', CAST('2019-12-03' AS Date), 224.0000, 224.0000, 0.0000, 3, CAST('2020-01-03' AS Date), CAST('2020-01-04' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (47, 83, '31359783', CAST('2019-12-03' AS Date), 1575.0000, 1575.0000, 0.0000, 2, CAST('2019-12-23' AS Date), CAST('2019-12-21' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (48, 123, '1-202-2978', CAST('2019-12-03' AS Date), 33.0000, 33.0000, 0.0000, 3, CAST('2020-01-03' AS Date), CAST('2020-01-05' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (49, 95, '111-92R-10097', CAST('2019-12-04' AS Date), 16.3300, 16.3300, 0.0000, 2, CAST('2019-12-24' AS Date), CAST('2019-12-26' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (50, 37, '547479217', CAST('2019-12-07' AS Date), 116.0000, 116.0000, 0.0000, 3, CAST('2020-01-07' AS Date), CAST('2020-01-07' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (51, 122, '989319-477', CAST('2019-12-08' AS Date), 2184.1100, 2184.1100, 0.0000, 3, CAST('2020-01-08' AS Date), CAST('2020-01-08' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (52, 34, 'Q545443', CAST('2019-12-09' AS Date), 1083.5800, 1083.5800, 0.0000, 1, CAST('2019-12-19' AS Date), CAST('2019-12-23' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (53, 95, '111-92R-10092', CAST('2019-12-09' AS Date), 46.2100, 46.2100, 0.0000, 2, CAST('2019-12-28' AS Date), CAST('2020-01-02' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (54, 121, '97/553B', CAST('2019-12-10' AS Date), 313.5500, 313.5500, 0.0000, 3, CAST('2020-01-10' AS Date), CAST('2020-01-09' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (55, 123, '963253245', CAST('2019-12-10' AS Date), 40.7500, 40.7500, 0.0000, 3, CAST('2020-01-10' AS Date), CAST('2020-01-12' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (56, 86, '367447', CAST('2019-12-11' AS Date), 2433.0000, 2433.0000, 0.0000, 1, CAST('2019-12-21' AS Date), CAST('2019-12-17' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (57, 103, '75C-90227', CAST('2019-12-11' AS Date), 1367.5000, 1367.5000, 0.0000, 5, CAST('2020-01-31' AS Date), CAST('2020-01-31' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (58, 123, '963253256', CAST('2019-12-11' AS Date), 53.2500, 53.2500, 0.0000, 3, CAST('2020-01-11' AS Date), CAST('2020-01-07' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (59, 123, '4-314-3057', CAST('2019-12-11' AS Date), 13.7500, 13.7500, 0.0000, 3, CAST('2020-01-11' AS Date), CAST('2020-01-15' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (60, 122, '989319-497', CAST('2019-12-12' AS Date), 2312.2000, 2312.2000, 0.0000, 3, CAST('2020-01-12' AS Date), CAST('2020-01-09' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (61, 115, '24946731', CAST('2019-12-15' AS Date), 25.6700, 25.6700, 0.0000, 4, CAST('2020-01-25' AS Date), CAST('2020-01-26' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (62, 123, '963253269', CAST('2019-12-15' AS Date), 26.7500, 26.7500, 0.0000, 3, CAST('2020-01-15' AS Date), CAST('2020-01-11' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (63, 122, '989319-427', CAST('2019-12-16' AS Date), 2115.8100, 2115.8100, 0.0000, 3, CAST('2020-01-16' AS Date), CAST('2020-01-19' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (64, 123, '963253267', CAST('2019-12-17' AS Date), 23.5000, 23.5000, 0.0000, 3, CAST('2020-01-17' AS Date), CAST('2020-01-19' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (65, 99, '509786', CAST('2019-12-18' AS Date), 6940.2500, 6940.2500, 0.0000, 3, CAST('2020-01-18' AS Date), CAST('2020-01-15' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (66, 123, '263253253', CAST('2019-12-18' AS Date), 31.9500, 31.9500, 0.0000, 3, CAST('2020-01-18' AS Date), CAST('2020-01-21' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (67, 122, '989319-487', CAST('2019-12-20' AS Date), 1927.5400, 1927.5400, 0.0000, 3, CAST('2020-01-20' AS Date), CAST('2020-01-18' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (68, 81, 'MABO1489', CAST('2019-12-21' AS Date), 936.9300, 936.9300, 0.0000, 2, CAST('2020-01-11' AS Date), CAST('2020-01-10' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (69, 80, '133560', CAST('2019-12-22' AS Date), 175.0000, 175.0000, 0.0000, 2, CAST('2020-01-12' AS Date), CAST('2020-01-16' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (70, 115, '24780512', CAST('2019-12-22' AS Date), 6.0000, 6.0000, 0.0000, 4, CAST('2020-02-01' AS Date), CAST('2020-01-29' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (71, 123, '963253254', CAST('2019-12-22' AS Date), 108.5000, 108.5000, 0.0000, 3, CAST('2020-01-22' AS Date), CAST('2020-01-20' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (72, 123, '43966316', CAST('2019-12-22' AS Date), 10.0000, 10.0000, 0.0000, 3, CAST('2020-01-22' AS Date), CAST('2020-01-17' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (73, 114, 'CBM9920-M-T77109', CAST('2019-12-23' AS Date), 290.0000, 290.0000, 0.0000, 1, CAST('2020-01-03' AS Date), CAST('2019-12-28' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (74, 102, '109596', CAST('2019-12-24' AS Date), 41.8000, 41.8000, 0.0000, 4, CAST('2020-02-03' AS Date), CAST('2020-02-04' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (75, 123, '7548906-20', CAST('2019-12-24' AS Date), 27.0000, 27.0000, 0.0000, 3, CAST('2020-01-24' AS Date), CAST('2020-01-24' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (76, 123, '963253248', CAST('2019-12-24' AS Date), 241.0000, 241.0000, 0.0000, 3, CAST('2020-01-24' AS Date), CAST('2020-01-25' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (77, 121, '97/553', CAST('2019-12-25' AS Date), 904.1400, 904.1400, 0.0000, 3, CAST('2020-01-25' AS Date), CAST('2020-01-25' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (78, 121, '97/522', CAST('2019-12-28' AS Date), 1962.1300, 1762.1300, 200.0000, 3, CAST('2020-01-28' AS Date), CAST('2020-01-30' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (79, 100, '587056', CAST('2019-12-28' AS Date), 2184.5000, 2184.5000, 0.0000, 4, CAST('2020-02-09' AS Date), CAST('2020-02-07' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (80, 122, '989319-467', CAST('2020-01-01' AS Date), 2318.0300, 2318.0300, 0.0000, 3, CAST('2020-01-31' AS Date), CAST('2020-01-29' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (81, 123, '263253265', CAST('2020-01-02' AS Date), 26.2500, 26.2500, 0.0000, 3, CAST('2020-02-01' AS Date), CAST('2020-01-28' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (82, 94, '203339-13', CAST('2020-01-05' AS Date), 17.5000, 17.5000, 0.0000, 2, CAST('2020-01-25' AS Date), CAST('2020-01-27' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (83, 95, '111-92R-10093', CAST('2020-01-06' AS Date), 39.7700, 39.7700, 0.0000, 2, CAST('2020-01-26' AS Date), CAST('2020-01-22' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (84, 123, '963253258', CAST('2020-01-06' AS Date), 111.0000, 111.0000, 0.0000, 3, CAST('2020-02-05' AS Date), CAST('2020-02-05' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (85, 123, '963253271', CAST('2020-01-07' AS Date), 158.0000, 158.0000, 0.0000, 3, CAST('2020-02-06' AS Date), CAST('2020-02-11' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (86, 123, '963253230', CAST('2020-01-07' AS Date), 739.2000, 739.2000, 0.0000, 3, CAST('2020-02-06' AS Date), CAST('2020-02-06' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (87, 123, '963253244', CAST('2020-01-08' AS Date), 60.0000, 60.0000, 0.0000, 3, CAST('2020-02-07' AS Date), CAST('2020-02-09' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (88, 123, '963253239', CAST('2020-01-08' AS Date), 147.2500, 147.2500, 0.0000, 3, CAST('2020-02-07' AS Date), CAST('2020-02-11' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (89, 72, '39104', CAST('2020-01-10' AS Date), 85.3100, 0.0000, 0.0000, 3, CAST('2020-02-09' AS Date), NULL);
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (90, 123, '963253252', CAST('2020-01-12' AS Date), 38.7500, 38.7500, 0.0000, 3, CAST('2020-02-11' AS Date), CAST('2020-02-11' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (91, 95, '111-92R-10095', CAST('2020-01-15' AS Date), 32.7000, 32.7000, 0.0000, 2, CAST('2020-02-04' AS Date), CAST('2020-02-06' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (92, 117, '111897', CAST('2020-01-15' AS Date), 16.6200, 16.6200, 0.0000, 3, CAST('2020-02-14' AS Date), CAST('2020-02-14' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (93, 123, '4-327-7357', CAST('2020-01-16' AS Date), 162.7500, 162.7500, 0.0000, 3, CAST('2020-02-15' AS Date), CAST('2020-02-11' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (94, 123, '963253264', CAST('2020-01-18' AS Date), 52.2500, 0.0000, 0.0000, 3, CAST('2020-02-17' AS Date), NULL);
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (95, 82, 'C73-24', CAST('2020-01-19' AS Date), 600.0000, 600.0000, 0.0000, 2, CAST('2020-02-08' AS Date), CAST('2020-02-13' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (96, 110, 'P-0259', CAST('2020-01-19' AS Date), 26881.4000, 26881.4000, 0.0000, 3, CAST('2020-02-18' AS Date), CAST('2020-02-20' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (97, 90, '97-1024A', CAST('2020-01-20' AS Date), 356.4800, 356.4800, 0.0000, 2, CAST('2020-02-09' AS Date), CAST('2020-02-07' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (98, 83, '31361833', CAST('2020-01-21' AS Date), 579.4200, 0.0000, 0.0000, 2, CAST('2020-02-10' AS Date), NULL);
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (99, 123, '263253268', CAST('2020-01-21' AS Date), 59.9700, 0.0000, 0.0000, 3, CAST('2020-02-20' AS Date), NULL);

INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (100, 123, '263253270', CAST('2020-01-22' AS Date), 67.9200, 0.0000, 0.0000, 3, CAST('2020-02-21' AS Date), NULL);
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (101, 123, '263253273', CAST('2020-01-22' AS Date), 30.7500, 0.0000, 0.0000, 3, CAST('2020-02-21' AS Date), NULL);
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (102, 110, 'P-0608', CAST('2020-01-23' AS Date), 20551.1800, 0.0000, 1200.0000, 3, CAST('2020-02-22' AS Date), NULL);
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (103, 122, '989319-417', CAST('2020-01-23' AS Date), 2051.5900, 2051.5900, 0.0000, 3, CAST('2020-02-22' AS Date), CAST('2020-02-24' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (104, 123, '263253243', CAST('2020-01-23' AS Date), 44.4400, 44.4400, 0.0000, 3, CAST('2020-02-22' AS Date), CAST('2020-02-24' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (105, 106, '9982771', CAST('2020-01-24' AS Date), 503.2000, 0.0000, 0.0000, 3, CAST('2020-02-23' AS Date), NULL);
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (106, 110, '0-2060', CAST('2020-01-24' AS Date), 23517.5800, 21221.6300, 2295.9500, 3, CAST('2020-02-23' AS Date), CAST('2020-02-27' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (107, 122, '989319-447', CAST('2020-01-24' AS Date), 3689.9900, 3689.9900, 0.0000, 3, CAST('2020-02-23' AS Date), CAST('2020-02-19' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (108, 123, '963253240', CAST('2020-01-24' AS Date), 67.0000, 67.0000, 0.0000, 3, CAST('2020-02-23' AS Date), CAST('2020-02-23' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (109, 121, '97/222', CAST('2020-01-25' AS Date), 1000.4600, 1000.4600, 0.0000, 3, CAST('2020-02-24' AS Date), CAST('2020-02-22' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (110, 80, '134116', CAST('2020-01-28' AS Date), 90.3600, 0.0000, 0.0000, 2, CAST('2020-02-17' AS Date), NULL);
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (111, 123, '263253257', CAST('2020-01-30' AS Date), 22.5700, 22.5700, 0.0000, 3, CAST('2020-02-29' AS Date), CAST('2020-03-03' AS Date));
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (112, 110, '0-2436', CAST('2020-01-31' AS Date), 10976.0600, 0.0000, 0.0000, 3, CAST('2020-02-29' AS Date), NULL);
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (113, 37, '547480102', CAST('2020-02-01' AS Date), 224.0000, 0.0000, 0.0000, 3, CAST('2020-02-29' AS Date), NULL);
INSERT `Invoices` (`InvoiceID`, `VendorID`, `InvoiceNumber`, `InvoiceDate`, `InvoiceTotal`, `PaymentTotal`, `CreditTotal`, `TermsID`, `InvoiceDueDate`, `PaymentDate`) VALUES (114, 123, '963253249', CAST('2020-02-02' AS Date), 127.7500, 127.7500, 0.0000, 3, CAST('2020-03-01' AS Date), CAST('2020-03-04' AS Date));



INSERT `Terms` (`TermsID`, `TermsDescription`, `TermsDueDays`) VALUES (1, 'Net due 10 days', 10);
INSERT `Terms` (`TermsID`, `TermsDescription`, `TermsDueDays`) VALUES (2, 'Net due 20 days', 20);
INSERT `Terms` (`TermsID`, `TermsDescription`, `TermsDueDays`) VALUES (3, 'Net due 30 days', 30);
INSERT `Terms` (`TermsID`, `TermsDescription`, `TermsDueDays`) VALUES (4, 'Net due 60 days', 60);
INSERT `Terms` (`TermsID`, `TermsDescription`, `TermsDueDays`) VALUES (5, 'Net due 90 days', 90);



INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (1, 'US Postal Service', 'Attn:  Supt. Window Services', 'PO Box 7005', 'Madison', 'WI', '53707', '(800) 555-1205', 'Alberto', 'Francesco', 1, 552);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (2, 'National Information Data Ctr', 'PO Box 96621', NULL, 'Washington', 'DC', '20090', '(301) 555-8950', 'Irvin', 'Ania', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (3, 'Register of Copyrights', 'Library Of Congress', NULL, 'Washington', 'DC', '20559', NULL, 'Liana', 'Lukas', 3, 403);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (4, 'Jobtrak', '1990 Westwood Blvd Ste 260', NULL, 'Los Angeles', 'CA', '90025', '(800) 555-8725', 'Quinn', 'Kenzie', 3, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (5, 'Newbrige Book Clubs', '3000 Cindel Drive', NULL, 'Washington', 'NJ', '07882', '(800) 555-9980', 'Marks', 'Michelle', 4, 394);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (6, 'California Chamber Of Commerce', '3255 Ramos Cir', NULL, 'Sacramento', 'CA', '95827', '(916) 555-6670', 'Mauro', 'Anton', 3, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (7, 'Towne Advertiser''s Mailing Svcs', 'Kevin Minder', '3441 W Macarthur Blvd', 'Santa Ana', 'CA', '92704', NULL, 'Maegen', 'Ted', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (8, 'BFI Industries', 'PO Box 9369', NULL, 'Fresno', 'CA', '93792', '(559) 555-1551', 'Kaleigh', 'Erick', 3, 521);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (9, 'Pacific Gas & Electric', 'Box 52001', NULL, 'San Francisco', 'CA', '94152', '(800) 555-6081', 'Anthoni', 'Kaitlyn', 3, 521);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (10, 'Robbins Mobile Lock And Key', '4669 N Fresno', NULL, 'Fresno', 'CA', '93726', '(559) 555-9375', 'Leigh', 'Bill', 2, 523);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (11, 'Bill Marvin Electric Inc', '4583 E Home', NULL, 'Fresno', 'CA', '93703', '(559) 555-5106', 'Hostlery', 'Kaitlin', 2, 523);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (12, 'City Of Fresno', 'PO Box 2069', NULL, 'Fresno', 'CA', '93718', '(559) 555-9999', 'Mayte', 'Kendall', 3, 574);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (13, ';lden Eagle Insurance Co', 'PO Box 85826', NULL, 'San Die;', 'CA', '92186', NULL, 'Blanca', 'Korah', 3, 590);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (14, 'Expedata Inc', '4420 N. First Street, Suite 108', NULL, 'Fresno', 'CA', '93726', '(559) 555-9586', 'Quintin', 'Marvin', 3, 589);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (15, 'ASC Signs', '1528 N Sierra Vista', NULL, 'Fresno', 'CA', '93703', NULL, 'Darien', 'Elisabeth', 1, 546);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (16, 'Internal Revenue Service', NULL, NULL, 'Fresno', 'CA', '93888', NULL, 'Aileen', 'Joan', 1, 235);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (17, 'Blanchard & Johnson Associates', '27371 Valderas', NULL, 'Mission Viejo', 'CA', '92691', '(214) 555-3647', 'Keeton', ';nzalo', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (18, 'Fresno Photoengraving Company', '1952 "H" Street', 'P.O. Box 1952', 'Fresno', 'CA', '93718', '(559) 555-3005', 'Chaddick', 'Derek', 3, 403);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (19, 'Crown Printing', '1730 "H" St', NULL, 'Fresno', 'CA', '93721', '(559) 555-7473', 'Randrup', 'Leann', 2, 400);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (20, 'Diversified Printing & Pub', '2632 Saturn St', NULL, 'Brea', 'CA', '92621', '(714) 555-4541', 'Lane', 'Vanesa', 3, 400);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (21, 'The Library Ltd', '7700 Forsyth', NULL, 'St Louis', 'MO', '63105', '(314) 555-8834', 'Marques', 'Malia', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (22, 'Micro Center', '1555 W Lane Ave', NULL, 'Columbus', 'OH', '43221', '(614) 555-4435', 'Evan', 'Emily', 2, 160);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (23, 'Yale Industrial Trucks-Fresno', '3711 W Franklin', NULL, 'Fresno', 'CA', '93706', '(559) 555-2993', 'Alexis', 'Alexandro', 3, 532);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (24, 'Zee Medical Service Co', '4221 W Sierra Madre #104', NULL, 'Washington', 'IA', '52353', NULL, 'Hallie', 'Juliana', 3, 570);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (25, 'California Data Marketing', '2818 E Hamilton', NULL, 'Fresno', 'CA', '93721', '(559) 555-3801', 'Jonessen', 'Moises', 4, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (26, 'Small Press', '121 E Front St - 4th Floor', NULL, 'Traverse City', 'MI', '49684', NULL, 'Colette', 'Dusty', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (27, 'Rich Advertising', '12 Daniel Road', NULL, 'Fairfield', 'NJ', '07004', '(201) 555-9742', 'Neil', 'Ingrid', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (29, 'Vision Envelope & Printing', 'PO Box 3100', NULL, 'Gardena', 'CA', '90247', '(310) 555-7062', 'Raven', 'Jamari', 3, 551);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (30, 'Costco', 'Fresno Warehouse', '4500 W Shaw', 'Fresno', 'CA', '93711', NULL, 'Jaquan', 'Aaron', 3, 570);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (31, 'Enterprise Communications Inc', '1483 Chain Bridge Rd, Ste 202', NULL, 'Mclean', 'VA', '22101', '(770) 555-9558', 'Lawrence', 'Eileen', 2, 536);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (32, 'RR Bowker', 'PO Box 31', NULL, 'East Brunswick', 'NJ', '08810', '(800) 555-8110', 'Essence', 'Marjorie', 3, 532);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (33, 'Nielson', 'Ohio Valley Litho Division', 'Location #0470', 'Cincinnati', 'OH', '45264', NULL, 'Brooklynn', 'Keely', 2, 541);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (34, 'IBM', 'PO Box 61000', NULL, 'San Francisco', 'CA', '94161', '(800) 555-4426', 'Camron', 'Trentin', 1, 160);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (35, 'Cal State Termite', 'PO Box 956', NULL, 'Selma', 'CA', '93662', '(559) 555-1534', 'Hunter', 'Demetrius', 2, 523);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (36, 'Graylift', 'PO Box 2808', NULL, 'Fresno', 'CA', '93745', '(559) 555-6621', 'Sydney', 'Deangelo', 3, 532);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (37, 'Blue Cross', 'PO Box 9061', NULL, 'Oxnard', 'CA', '93031', '(800) 555-0912', 'Eliana', 'Nikolas', 3, 510);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (38, 'Venture Communications Int''l', '60 Madison Ave', NULL, 'New York', 'NY', '10010', '(212) 555-4800', 'Neftaly', 'Thalia', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (39, 'Custom Printing Company', 'PO Box 7028', NULL, 'St Louis', 'MO', '63177', '(301) 555-1494', 'Myles', 'Harley', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (40, 'Nat Assoc of College Stores', '500 East Lorain Street', NULL, 'Oberlin', 'OH', '44074', NULL, 'Bernard', 'Lucy', 3, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (41, 'Shields Design', '415 E Olive Ave', NULL, 'Fresno', 'CA', '93728', '(559) 555-8060', 'Kerry', 'Rowan', 2, 403);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (42, 'Opamp Technical Books', '1033 N Sycamore Ave.', NULL, 'Los Angeles', 'CA', '90038', '(213) 555-4322', 'Paris', 'Gideon', 3, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (43, 'Capital Resource Credit', 'PO Box 39046', NULL, 'Minneapolis', 'MN', '55439', '(612) 555-0057', 'Maxwell', 'Jayda', 3, 589);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (44, 'Courier Companies, Inc', 'PO Box 5317', NULL, 'Boston', 'MA', '02206', '(508) 555-6351', 'Antavius', 'Troy', 4, 400);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (45, 'Naylor Publications Inc', 'PO Box 40513', NULL, 'Jacksonville', 'FL', '32231', '(800) 555-6041', 'Gerald', 'Kristofer', 3, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (46, 'Open Horizons Publishing', 'Book Marketing Update', 'PO Box 205', 'Fairfield', 'IA', '52556', '(515) 555-6130', 'Damien', 'Deborah', 2, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (47, 'Baker & Taylor Books', 'Five Lakepointe Plaza, Ste 500', '2709 Water Ridge Parkway', 'Charlotte', 'NC', '28217', '(704) 555-3500', 'Bernardo', 'Brittnee', 3, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (48, 'Fresno County Tax Collector', 'PO Box 1192', NULL, 'Fresno', 'CA', '93715', '(559) 555-3482', 'Brenton', 'Kila', 3, 574);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (49, 'Mcgraw Hill Companies', 'PO Box 87373', NULL, 'Chica;', 'IL', '60680', '(614) 555-3663', 'Holbrooke', 'Rashad', 3, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (50, 'Publishers Weekly', 'Box 1979', NULL, 'Marion', 'OH', '43305', '(800) 555-1669', 'Carrollton', 'Priscilla', 3, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (51, 'Blue Shield of California', 'PO Box 7021', NULL, 'Anaheim', 'CA', '92850', '(415) 555-5103', 'Smith', 'Kylie', 3, 510);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (52, 'Aztek Label', 'Accounts Payable', '1150 N Tustin Ave', 'Anaheim', 'CA', '92807', '(714) 555-9000', 'Griffin', 'Brian', 3, 551);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (53, 'Gary McKeighan Insurance', '3649 W Beechwood Ave #101', NULL, 'Fresno', 'CA', '93711', '(559) 555-2420', 'Jair', 'Caitlin', 3, 590);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (54, 'Ph Photographic Services', '2384 E Gettysburg', NULL, 'Fresno', 'CA', '93726', '(559) 555-0765', 'Cheyenne', 'Kaylea', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (55, 'Quality Education Data', 'PO Box 95857', NULL, 'Chica;', 'IL', '60694', '(800) 555-5811', 'Misael', 'Kayle', 2, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (56, 'Springhouse Corp', 'PO Box 7247-7051', NULL, 'Philadelphia', 'PA', '19170', '(215) 555-8700', 'Maeve', 'Clarence', 3, 523);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (57, 'The Windows Deck', '117 W Micheltorena Top Floor', NULL, 'Santa Barbara', 'CA', '93101', '(800) 555-3353', 'Wood', 'Liam', 3, 536);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (58, 'Fresno Rack & Shelving Inc', '4718 N Bendel Ave', NULL, 'Fresno', 'CA', '93722', NULL, 'Baylee', 'Dakota', 2, 523);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (59, 'Publishers Marketing Assoc', '627 Aviation Way', NULL, 'Manhatttan Beach', 'CA', '90266', '(310) 555-2732', 'Walker', 'Jovon', 3, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (60, 'The Mailers Guide Co', 'PO Box 1550', NULL, 'New Rochelle', 'NY', '10802', NULL, 'Lacy', 'Karina', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (61, 'American Booksellers Assoc', '828 S Broadway', NULL, 'Tarrytown', 'NY', '10591', '(800) 555-0037', 'Angelica', 'Nashalie', 3, 574);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (62, 'Cmg Information Services', 'PO Box 2283', NULL, 'Boston', 'MA', '02107', '(508) 555-7000', 'Randall', 'Yash', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (63, 'Lou Gentile''s Flower Basket', '722 E Olive Ave', NULL, 'Fresno', 'CA', '93728', '(559) 555-6643', 'Anum', 'Trisha', 1, 570);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (64, 'Texaco', 'PO Box 6070', NULL, 'Inglewood', 'CA', '90312', NULL, 'Oren', 'Grace', 3, 582);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (65, 'The Drawing Board', 'PO Box 4758', NULL, 'Carol Stream', 'IL', '60197', NULL, 'Mckayla', 'Jeffery', 2, 551);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (66, 'Ascom Hasler Mailing Systems', 'PO Box 895', NULL, 'Shelton', 'CT', '06484', NULL, 'Lewis', 'Darnell', 3, 532);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (67, 'Bill Jones', 'Secretary Of State', 'PO Box 944230', 'Sacramento', 'CA', '94244', NULL, 'Deasia', 'Tristin', 3, 589);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (68, 'Computer Library', '3502 W Greenway #7', NULL, 'Phoenix', 'AZ', '85023', '(602) 547-0331', 'Aryn', 'Leroy', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (69, 'Frank E Wilber Co', '2437 N Sunnyside', NULL, 'Fresno', 'CA', '93727', '(559) 555-1881', 'Millerton', 'Johnathon', 3, 532);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (70, 'Fresno Credit Bureau', 'PO Box 942', NULL, 'Fresno', 'CA', '93714', '(559) 555-7900', 'Braydon', 'Anne', 2, 555);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (71, 'The Fresno Bee', '1626 E Street', NULL, 'Fresno', 'CA', '93786', '(559) 555-4442', 'Colton', 'Leah', 2, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (72, 'Data Reproductions Corp', '4545 Glenmeade Lane', NULL, 'Auburn Hills', 'MI', '48326', '(810) 555-3700', 'Arodondo', 'Cesar', 3, 400);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (73, 'Executive Office Products', '353 E Shaw Ave', NULL, 'Fresno', 'CA', '93710', '(559) 555-1704', 'Danielson', 'Rachael', 2, 570);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (74, 'Leslie Company', 'PO Box 610', NULL, 'Olathe', 'KS', '66061', '(800) 255-6210', 'Alondra', 'Zev', 3, 570);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (75, 'Retirement Plan Consultants', '6435 North Palm Ave, Ste 101', NULL, 'Fresno', 'CA', '93704', '(559) 555-7070', 'Edgardo', 'Salina', 3, 589);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (76, 'Simon Direct Inc', '4 Cornwall Dr Ste 102', NULL, 'East Brunswick', 'NJ', '08816', '(908) 555-7222', 'Bradlee', 'Daniel', 2, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (77, 'State Board Of Equalization', 'PO Box 942808', NULL, 'Sacramento', 'CA', '94208', '(916) 555-4911', 'Dean', 'Julissa', 1, 631);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (78, 'The Presort Center', '1627 "E" Street', NULL, 'Fresno', 'CA', '93706', '(559) 555-6151', 'Marissa', 'Kyle', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (79, 'Valprint', 'PO Box 12332', NULL, 'Fresno', 'CA', '93777', '(559) 555-3112', 'Warren', 'Quentin', 3, 551);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (80, 'Cardinal Business Media, Inc.', 'P O Box 7247-7844', NULL, 'Philadelphia', 'PA', '19170', '(215) 555-1500', 'Eulalia', 'Kelsey', 2, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (81, 'Wang Laboratories, Inc.', 'P.O. Box 21209', NULL, 'Pasadena', 'CA', '91185', '(800) 555-0344', 'Kapil', 'Robert', 2, 160);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (82, 'Reiter''s Scientific & Pro Books', '2021 K Street Nw', NULL, 'Washington', 'DC', '20006', '(202) 555-5561', 'Rodolfo', 'Carlee', 2, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (83, 'Ingram', 'PO Box 845361', NULL, 'Dallas', 'TX', '75284', NULL, 'Yobani', 'Trey', 2, 541);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (84, 'Boucher Communications Inc', '1300 Virginia Dr. Ste 400', NULL, 'Fort Washington', 'PA', '19034', '(215) 555-8000', 'Carson', 'Julian', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (85, 'Champion Printing Company', '3250 Spring Grove Ave', NULL, 'Cincinnati', 'OH', '45225', '(800) 555-1957', 'Clifford', 'Jillian', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (86, 'Computerworld', 'Department #1872', 'PO Box 61000', 'San Francisco', 'CA', '94161', '(617) 555-0700', 'Lloyd', 'Angel', 1, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (87, 'DMV Renewal', 'PO Box 942894', NULL, 'Sacramento', 'CA', '94294', NULL, 'Josey', 'Lorena', 4, 568);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (88, 'Edward Data Services', '4775 E Miami River Rd', NULL, 'Cleves', 'OH', '45002', '(513) 555-3043', 'Helena', 'Jeanette', 1, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (89, 'Evans Executone Inc', '4918 Taylor Ct', NULL, 'Turlock', 'CA', '95380', NULL, 'Royce', 'Hannah', 1, 522);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (90, 'Wakefield Co', '295 W Cromwell Ave Ste 106', NULL, 'Fresno', 'CA', '93711', '(559) 555-4744', 'Rothman', 'Nathanael', 2, 170);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (91, 'McKesson Water Products', 'P O Box 7126', NULL, 'Pasadena', 'CA', '91109', '(800) 555-7009', 'Destin', 'Luciano', 2, 570);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (92, 'Zip Print & Copy Center', 'PO Box 12332', NULL, 'Fresno', 'CA', '93777', '(233) 555-6400', 'Javen', 'Justin', 2, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (93, 'AT&T', 'PO Box 78225', NULL, 'Phoenix', 'AZ', '85062', NULL, 'Wesley', 'Alisha', 3, 522);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (94, 'Abbey Office Furnishings', '4150 W Shaw Ave', NULL, 'Fresno', 'CA', '93722', '(559) 555-8300', 'Francis', 'Kyra', 2, 150);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (95, 'Pacific Bell', NULL, NULL, 'Sacramento', 'CA', '95887', '(209) 555-7500', 'Nickalus', 'Kurt', 2, 522);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (96, 'Wells Far; Bank', 'Business Mastercard', 'P.O. Box 29479', 'Phoenix', 'AZ', '85038', '(947) 555-3900', 'Damion', 'Mikayla', 2, 160);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (97, 'Compuserve', 'Dept L-742', NULL, 'Columbus', 'OH', '43260', '(614) 555-8600', 'Armando', 'Jan', 2, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (98, 'American Express', 'Box 0001', NULL, 'Los Angeles', 'CA', '90096', '(800) 555-3344', 'Story', 'Kirsten', 2, 160);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (99, 'Bertelsmann Industry Svcs. Inc', '28210 N Avenue Stanford', NULL, 'Valencia', 'CA', '91355', '(805) 555-0584', 'Potter', 'Lance', 3, 400);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (100, 'Cahners Publishing Company', 'Citibank Lock Box 4026', '8725 W Sahara Zone 1127', 'The Lake', 'NV', '89163', '(301) 555-2162', 'Jacobsen', 'Samuel', 4, 540);

INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (101, 'California Business Machines', 'Gallery Plz', '5091 N Fresno', 'Fresno', 'CA', '93710', '(559) 555-5570', 'Rohansen', 'Anders', 2, 170);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (102, 'Coffee Break Service', 'PO Box 1091', NULL, 'Fresno', 'CA', '93714', '(559) 555-8700', 'Smitzen', 'Jeffrey', 4, 570);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (103, 'Dean Witter Reynolds', '9 River Pk Pl E 400', NULL, 'Boston', 'MA', '02134', '(508) 555-8737', 'Johnson', 'Vance', 5, 589);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (104, 'Digital Dreamworks', '5070 N Sixth Ste. 71', NULL, 'Fresno', 'CA', '93711', NULL, 'Elmert', 'Ron', 3, 589);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (105, 'Dristas Groom & McCormick', '7112 N Fresno St Ste 200', NULL, 'Fresno', 'CA', '93720', '(559) 555-8484', 'Aaronsen', 'Thom', 3, 591);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (106, 'Ford Motor Credit Company', 'Dept 0419', NULL, 'Los Angeles', 'CA', '90084', '(800) 555-7000', 'Snyder', 'Karen', 3, 582);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (107, 'Franchise Tax Board', 'PO Box 942857', NULL, 'Sacramento', 'CA', '94257', NULL, 'Prado', 'Anita', 4, 507);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (108, ';stanian General Building', '427 W Bedford #102', NULL, 'Fresno', 'CA', '93711', '(559) 555-5100', 'Bragg', 'Walter', 4, 523);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (109, 'Kent H Landsberg Co', 'File No 72686', 'PO Box 61000', 'San Francisco', 'CA', '94160', '(916) 555-8100', 'Stevens', 'Wendy', 3, 540);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (110, 'Malloy Lithographing Inc', '5411 Jackson Road', 'PO Box 1124', 'Ann Arbor', 'MI', '48106', '(313) 555-6113', 'Regging', 'Abe', 3, 400);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (111, 'Net Asset, Llc', '1315 Van Ness Ave Ste. 103', NULL, 'Fresno', 'CA', '93721', NULL, 'Kraggin', 'Laura', 1, 572);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (112, 'Office Depot', 'File No 81901', NULL, 'Los Angeles', 'CA', '90074', '(800) 555-1711', 'Pinsippi', 'Val', 3, 570);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (113, 'Pollstar', '4697 W Jacquelyn Ave', NULL, 'Fresno', 'CA', '93722', '(559) 555-2631', 'Aranovitch', 'Robert', 5, 520);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (114, 'Postmaster', 'Postage Due Technician', '1900 E Street', 'Fresno', 'CA', '93706', '(559) 555-7785', 'Finklestein', 'Fyodor', 1, 552);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (115, 'Roadway Package System, Inc', 'Dept La 21095', NULL, 'Pasadena', 'CA', '91185', NULL, 'Smith', 'Sam', 4, 553);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (116, 'State of California', 'Employment Development Dept', 'PO Box 826276', 'Sacramento', 'CA', '94230', '(209) 555-5132', 'Articunia', 'Mercedez', 1, 631);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (117, 'Suburban Propane', '2874 S Cherry Ave', NULL, 'Fresno', 'CA', '93706', '(559) 555-2770', 'Spivak', 'Harold', 3, 521);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (118, 'Unocal', 'P.O. Box 860070', NULL, 'Pasadena', 'CA', '91186', '(415) 555-7600', 'Bluzinski', 'Rachael', 3, 582);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (119, 'Yesmed, Inc', 'PO Box 2061', NULL, 'Fresno', 'CA', '93718', '(559) 555-0600', 'Hernandez', 'Reba', 2, 589);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (120, 'Dataforms/West', '1617 W. Shaw Avenue', 'Suite F', 'Fresno', 'CA', '93711', NULL, 'Church', 'Charlie', 3, 551);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (121, 'Zylka Design', '3467 W Shaw Ave #103', NULL, 'Fresno', 'CA', '93711', '(559) 555-8625', 'Ronaldsen', 'Jaime', 3, 403);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (122, 'United Parcel Service', 'P.O. Box 505820', NULL, 'Reno', 'NV', '88905', '(800) 555-0855', 'Beauregard', 'Violet', 3, 553);
INSERT `Vendors` (`VendorID`, `VendorName`, `VendorAddress1`, `VendorAddress2`, `VendorCity`, `VendorState`, `VendorZipCode`, `VendorPhone`, `VendorContactLName`, `VendorContactFName`, `DefaultTermsID`, `DefaultAccountNo`) VALUES (123, 'Federal Express Corporation', 'P.O. Box 1140', 'Dept A', 'Memphis', 'TN', '38101', '(800) 555-4091', 'Bucket', 'Charlie', 3, 553);






ALTER TABLE `InvoiceLineItems` ADD CONSTRAINT `FK_InvoiceLineItems_GLAccounts` FOREIGN KEY (AccountNo) REFERENCES GLAccounts (AccountNo);

ALTER TABLE `InvoiceLineItems` ADD CONSTRAINT `FK_InvoiceLineItems_Invoices` FOREIGN KEY (InvoiceID) REFERENCES Invoices (InvoiceID) ON DELETE CASCADE;

ALTER TABLE `Invoices` ADD CONSTRAINT `FK_Invoices_Terms` FOREIGN KEY(TermsID) REFERENCES Terms (TermsID);

ALTER TABLE `Invoices` ADD CONSTRAINT `FK_Invoices_Vendors` FOREIGN KEY(VendorID) REFERENCES Vendors (VendorID);

ALTER TABLE `Vendors`ADD CONSTRAINT `FK_Vendors_GLAccounts` FOREIGN KEY(DefaultAccountNo) REFERENCES GLAccounts (AccountNo);

ALTER TABLE `Vendors` ADD CONSTRAINT `FK_Vendors_Terms` FOREIGN KEY(DefaultTermsID) REFERENCES Terms (TermsID);
