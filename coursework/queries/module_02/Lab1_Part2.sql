/*
Write a SELECT statement that returns these columns from the Products table:
	The ListPrice column
	The DiscountPercent column
	A column named DiscountAmount that uses the previous two columns to calculate the discount amount and uses the ROUND function to round the result to 2 decimal places
*/
SELECT 
	ListPrice,
	DiscountPercent, 
	ROUND(ListPrice * (DiscountPercent / 100), 2) AS DiscountAmount
FROM Products;

/*
Write a SELECT statement that returns these columns from the Orders table:
	The OrderDate column
	A column that returns the four-digit year that's stored in the OrderDate column
	A column that returns only the day of the month that's stored in the OrderDate column.
	A column that returns the result from adding thirty days to the OrderDate column.
*/
SELECT 
	OrderDate,
	YEAR(OrderDate) AS OrderYear,
	DAY(OrderDate) AS OrderDay,
	OrderDate + 30 AS OrderExpiration
FROM Orders;

/*
Write a SELECT statement that returns these columns from the Orders table:
	The CardNumber column
	The length of the CardNumber column
	The last four digits of the CardNumber column

When you get that working right, add the column that follows to the result set. This is more difficult because the column requires the use of functions within functions.
	A column that displays the last four digits of the CardNumber column in this format: XXXX-XXXX-XXXX-1234. In other words, use Xs for the first 12 digits of the card number and actual numbers for the last four digits of the number.
*/
SELECT 
	CardNumber,
	LEN(CardNumber) AS CardNumberLength,
	SUBSTRING(CardNumber, LEN(CardNumber) - 3, 4) as CardNumberLastFour,
	'XXXX-XXXX-XXXX-' + SUBSTRING(CardNumber, LEN(CardNumber) - 3, 4) as ObfuscatedCardNumber
FROM Orders;

/*
Write a SELECT statement that returns these columns from the Orders table:
	The OrderID column
	The OrderDate column
	A column named ApproxShipDate that's calculated by adding 2 days to the OrderDate column
	The ShipDate column
	A column named DaysToShip that shows the number of days between the order date and the ship date

When you have this working, add a WHERE clause that retrieves just the orders for March 2020.
*/
SELECT 
	OrderId,
	OrderDate,
	OrderDate + 2 AS ApproxShipDate,
	ShipDate,
	DATEDIFF(day, OrderDate, ShipDate) as DaysToShip
FROM ORDERS
WHERE YEAR(OrderDate) = 2020 AND MONTH(OrderDate) = 3;
