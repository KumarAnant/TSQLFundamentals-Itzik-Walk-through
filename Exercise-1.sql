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


--Order of operation
--1. FROM
--2. WHERE
--3. GROUP BY
--4. HAVING
--5. SELECT
--6. ORDER BY

-- Use of Distinct
SELECT [empid]
	, YEAR([orderdate])
	, COUNT(DISTINCT [custid]) AS [NumCustomers]
FROM [TSQLV4].[Sales].[Orders]
GROUP BY YEAR([orderdate]), [empid]



-- Having clause - Aggregate filter as against WHERE is a row filter
-- It is executed after group has been processed and comes towards end of SQL statement
-- Unlike WHERE, which is executed towards begining in query
-- Aliases used in query are not available until SELECT clause is executed. Since SELECT is executed
-- towards the end, for most part alias will not work in the same query
-- The above problem og referring an alias may not work because of 'All at once' operations
-- All at once operation, that appear in same same logical query processing phase are evaluated
-- at same point and hence cann not be referred by concurrent operations or prceding operation
-- ORDER BY is the last clause to process in a SQL query
-- TOP clause is applied after ORDER BY clause.
SELECT [empid]
	, YEAR([orderdate])
	, COUNT(*) AS [OrderCount]
FROM [TSQLV4].[Sales].[Orders]
WHERE [custid] = 71
GROUP BY [empid], YEAR([orderdate])
HAVING COUNT(*) > 1

-- An unordered tuples set is called Table, whereas ordered is called Cursor. So output of a query
-- can be called as Table or Cursosr depending if ORDER BY clause has been used or not.
-- Some language  elements and operations in SQL expect to work with table results of queries and not with cursors.

-- TOP clause can be clubbed with 'WITH TIES' clause to get all the ties rows
SELECT TOP(5) WITH TIES [orderid]
	, [orderdate]
	, [custid]
	, [empid]
FROM [TSQLV4].[Sales].[Orders]
ORDER BY [orderdate] DESC

-- Similar to TOP, we have OFFSET-FETCH clause for more dynamic selection
-- SQL server does not support OFFSET-FETCH clause without ORDER BY clause
-- NEXT and FIRST are interchangeable in OFFSET-FETCH clause
-- OFFSET-FETCH does not support PERCENT and WITH TIES clause as TOP clause does
SELECT [orderid]
	, [orderdate]
	, [custid]
	, [empid]
FROM [TSQLV4].[Sales].[Orders]
ORDER BY [orderdate] DESC
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;

-- N preceding string represents Unicode Data type.
-- NUMERIC(12, 2) means precision of 12 (length of number) with 2 decimal part
-- By default tge operation in SQL is int. So 5/2 will return 2.

-- Order of operation in SQL
-- 1. ( ) (Parentheses)
-- 2. * (Multiplication), / (Division), % (Modulo)
-- 3. + (Positive), – (Negative), + (Addition), + (Concatenation), – (Subtraction)
-- 4. =, >, <, >=, <=, <>, !=, !>, !< (Comparison operators)
-- 5. NOT
-- 6. AND
-- 7. BETWEEN, IN, LIKE, OR
-- 8. = (Assignment)

-- CASE expression is a scalar expression. It returns the first value tested true. It does not control flow of the execution.
-- If no value in the CASE list is equalt to testeed value, default value in the ELSE statement is return.
-- If the expression does not have ELSE clause, it returns NULL value.

SELECT [orderid]
	, [custid]
	, [val]
	, CASE 
		WHEN [val] < 1000				THEN 'Less than 1000'
		WHEN [val] < 3000				THEN 'Between 1000 & 3000'
		When [val] > 3000				THEN 'Greater than 3000'
		ELSE							'Unknown'
	END AS [valuecategory]
FROM [TSQLV4].[Sales].[OrderValues]

-- ISNULL(col1, col2) - Takes two attribues and return first non NULL value. If both are null return an empty string
-- COALESCE(col1, col2, ...) take two or more attributes and return first NON-Null or NULL if case non-NUll does not exist.
-- IIF(<logical expression>, expression 1, expression 2) return expression 1 if <logical expression> is TRUE, expression 2 otherwise.
-- CHOOSE(val, col1, col2, col3) returns a position column given by value of val (1, 2 or 3).
-- Three value predicate True, False, Unknow

-- A very understandable query
SELECT [custid]
	, [country]
	, [region]
	, [city]
FROM [TSQLV4].[Sales].[Customers]
WHERE [region] = N'WA';

-- A query where Unknown predicate plays a role
-- In the Customers table there are records with NULL value in [region]
-- whcih was neglected for being UNKNOWN even though it was giving TRUE value for [region] <> N'WA'
-- value of logic [region] <> N'WA' remains unknown and filtered out
-- Best practice is to handle NULL value explicitly
SELECT [custid]
	, [country]
	, [region]
	, [city]
FROM [TSQLV4].[Sales].[Customers]
WHERE [region] <> N'WA';

-- All at once operation
--SELECT col1, col2
--FROM dbo.T1
--WHERE col1 <> 0 AND col2/col1 > 2;
-- Here both of WHERE clauses are evaluated at once and hence in case of col1 = 0, WHERE clause will not work

-- Workaround
--SELECT col1, col2
--FROM dbo.T1
--WHERE (col1 > 0 AND col2 > 2*col1) OR (col1 < 0 AND col2 < 2*col1);

-- CONCAT and '+' operators works almost same, except '+' can not work with NULL value whereas CONCAT substitutes NULL to blank string.
-- Diffrence between LEN and DATALEN, DATALENGTH return size in byte. Normally one character/digit take one byte
-- In case of Unicaode one character takes 2 bytes. So in case Unicode both of the above functions will return differnet values.
-- LEN exludes trailing blanks.

-- CHARINDEX, PATINDEX, REPLACE, REPLICATE, STUFF, UPPER, LOWER, RTRIM, LTRIM, STRING_SPLIT

-- SELECT * FROM string_split('Hello how are you doing this is just so much fun', ' ')

-- LIKE predicate
-- % for any sequence of character
-- _ for one character _e for single e.
-- [lst of characters] One character from the list.
-- [<character1>-<character2>] One character between Character 1 and Character 2.
-- [A-E] any one character between A and E
-- [^<list of characters>] character not in the list.

SET LANGUAGE British;
SELECT CAST('02/12/2016' AS DATE);

SET LANGUAGE us_english;
SELECT CAST('02/12/2016' AS DATE);

SET LANGUAGE British;
SELECT CAST('20160212' AS DATE);

SET LANGUAGE us_english;
SELECT CAST('20160212' AS DATE);

-- en-US
SELECT CONVERT(DATE, '02/12/2016', 101);
SELECT PARSE('02/12/2016' AS DATE USING 'en-US');

-- British
SELECT CONVERT(DATE, '02/12/2016', 103);
SELECT PARSE('02/12/2016' AS DATE USING 'en-GB');


--DATEADD function - DATEADD(part, n, val)
-- DATEDIFF(4 bit) and DATEDIFF_BIG (8 bit)
-- DATEPART(part, date_val) part - YEAR, QUARTER, MONTH, DAYOFYEAR, DAY, WEEK, WEEKDAY, 
-- HOUR, MINUTE, SECOND, MILLISECONF, MICROSECOND, NANOSECOND, ISO_WEEK

SELECT DATENAME(month, '20160212');
-- DATENAMe returns name
SELECT DATENAME(year, '20160212');
SELECT DATENAME(month, '20160212');
SELECT DATENAME(WEEKDAY, '20160212');

-- ISDATE checks for a elligible date
--DATEFROMPARTS take integer value and return DATE value

SELECT DATEFROMPARTS(2016, 02, 12);

--EOMONTH(input [, months_to_add]) accepts an input date and time value and returns the 
-- respective end-of-month as a DATE value.

SELECT [orderid]
	, [orderdate]
	, [custid]
FROM [TSQLV4].[Sales].[Orders]
WHERE [orderdate] = EOMONTH([orderdate])

-- TO get the infromation of columns in table
SELECT
name AS column_name,
TYPE_NAME(system_type_id) AS column_type,
max_length,
collation_name,
is_nullable
FROM sys.columns
WHERE object_id = OBJECT_ID(N'Sales.Orders');

-- System stored procedure
EXEC sys.sp_tables;  --list of objects (Table and View) that can be queried

EXEC sys.sp_help
@objname = N'TSQLV4.Sales.Orders';

EXEC sys.sp_columns
@table_name = N'Orders',
@table_owner = N'Sales';

-- *****************************
-- Exercise - 1
-- *****************************

SELECT [orderid]
	, [orderdate]
	, [custid]
	, [empid]
FROM [TSQLV4].[Sales].[Orders]
WHERE MONTH([orderdate]) = 6

-- *****************************
-- Exercise - 2
-- *****************************

SELECT [orderid]
	, [orderdate]
	, [custid]
	, [empid]
FROM [TSQLV4].[Sales].[Orders]
WHERE [orderdate] = EOMONTH([orderdate])

-- *****************************
-- Exercise - 3
-- *****************************

SELECT [empid]
	, [firstname]
	, [lastname]
FROM [TSQLV4].[HR].[Employees]
WHERE [lastname] LIKE '%e%e%'

-- *****************************
-- Exercise - 4
-- *****************************

SELECT [orderid]
	, SUM([qty] * [unitprice]) AS [TotalValue]	
FROM [TSQLV4].[Sales].[OrderDetails]
GROUP BY [orderid]
HAVING SUM([qty] * [unitprice]) > 10000
ORDER BY [TotalValue]

-- *****************************
-- Exercise - 5
-- *****************************

SELECT [empid]
	, [lastname]
FROM [TSQLV4].[HR].[Employees]
WHERE [lastname] COLLATE Latin1_General_CS_AS LIKE N'[abcdefghijklmnopqrstuvwxyz]%'

-- *****************************
-- Exercise - 7
-- *****************************
SELECT TOP(3) [shipcountry]
	, AVG([freight]) AS [AvgFrieght]
FROM [TSQLV4].[Sales].[Orders]
WHERE YEAR([shippeddate]) = 2015
GROUP BY [shipcountry]
ORDER BY [AvgFrieght] DESC

-- *****************************
-- Exercise - 8
-- *****************************

SELECT [custid]
	, [orderdate]
	, [orderid]
	, ROW_NUMBER() OVER (PARTITION BY [custid] ORDER BY [orderdate] ASC, [orderid] ASC) AS [RowNum]
FROM [TSQLV4].[Sales].[Orders]

-- *****************************
-- Exercise - 9
-- *****************************

SELECT [empid]
	, [firstname]
	, [lastname]
	, [titleofcourtesy]
	, CASE 
		WHEN [titleofcourtesy] = 'Ms.' OR [titleofcourtesy] = 'Mrs' THEN 'Female'
		WHEN [titleofcourtesy] = 'Mr'			THEN 'Male'
		ELSE										 'Unknown'
	END AS [gender]
FROM [TSQLV4].[HR].[Employees]

-- *****************************
-- Exercise - 10
-- *****************************

SELECT [custid]
	, [region]
FROM [TSQLV4].[Sales].[Customers]
ORDER BY CASE 
	WHEN [region] IS NOT NULL THEN 1
	WHEN [region] IS NULL THEN 2
	END
