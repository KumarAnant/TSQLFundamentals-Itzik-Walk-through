USE [TSQLV4]
GO

-- Exercise - 1.
-- Get Sales.Orders table

-- Drop a table
DROP TABLE 
IF EXISTS [abc123] 



-- Exercise - 2.

-- Group on two fields
SELECT [empid]
	, YEAR([orderdate]) AS OrderYear
	, COUNT(*) AS NumOrders
FROM [TSQLV4].[Sales].[Orders]
GROUP BY [empid], YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY [empid], YEAR([orderdate])


-- COUNT counts any NULL values whereas other
-- aggregate functions do not.

SELECT [empid]
	, YEAR([orderdate]) AS [OrdYear]
	, SUM([freight]) AS [SumFrieght]
	, COUNT(*) AS [NumOrders]
FROM [TSQLV4].[Sales].[Orders]
GROUP BY [empid], [orderdate]
ORDER BY [empid], [orderdate]

-- Use of Distinct
SELECT [empid]
	, YEAR([orderdate])
	, COUNT(DISTINCT [custid]) AS [NumCustomers]
FROM [TSQLV4].[Sales].[Orders]
GROUP BY YEAR([orderdate]), [empid]



SELECT [Orderid]
	, [orderdate]
	, [custid]
	, [empid]
FROM [TSQLV4].[Sales].[Orders] 



