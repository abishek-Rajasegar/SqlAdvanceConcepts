/**------------------------------SET OPERATORS------------------------------------*/
/**--------------------------------SET-OPERATORS--------------------------------------------*/

	-- THERE ARE TWO WAYS TO COMBINE DATA IN SQL
		-- ROW WISE --> JOIN 
			-- INNER JOIN 
			-- FULL JOIN 
			-- LEFT JOIN 
			-- RIGHT JOIN
		-- COLUMN WISE --> ROWS (APPEND ROWS AT THE BOTTOM)
			-- UNION
			-- UNION ALL
			-- EXCEPT
			-- INTERSECT
			-- KEY COLUMN NOT REQUIRED 

	-- SYNTAX:
		-- QUERY1 (SET OPERATOR) QUERY2
	
	-- RULES:
		-- ALL CLAUSES ARE ALLOWED BY THE ORDER BY CAN BE USE ONLY AT THE LAST QUERY
		-- NUMBER OF COLUMNS IN EACH QUERY SHOULD BE THE SAME
		-- DATA TYPE OF THE COLUMNS SHOULD BE THE SAME
		-- ORDER OF THE COLUMNS MUST BE THE SAME
		-- COLUMNS NAME IS DETERMINED BY THE FIRST QUERY 


/**--------------------------------UNION---------------------------------------------*/

	-- RETURNS ALL THE DISTINCT ROWS FROM BOTH QUERIES 
	-- REMOVE DUPLICATES

/**-----------EXAMPLE---------------------*/

	SELECT
		FirstName,
		LastName
	FROM Sales.Customers
UNION
	SELECT
		FirstName,
		LastName
	FROM Sales.Employees

/**-----------*/

/**--------------------------------UNION---------------------------------------------*/

	-- RETURNS ALL THE ROWS FROM BOTH QUERIES 
	-- WILL NOT REMOVE DUPLICATES

/**-----------EXAMPLE---------------------*/
	
	SELECT
		FirstName,
		LastName
	FROM Sales.Customers
UNION ALL
	SELECT
		FirstName,
		LastName
	FROM Sales.Employees

/**-----------*/

/**--------------------------------EXCEPT---------------------------------------------*/

	-- RETURNS ALL THE DISTINCT ROWS FROM FIRST QUERIES WHICH ARE NOT IN 2ND QUERY
	-- WILL REMOVE DUPLICATES

/**-----------EXAMPLE---------------------*/
	
	SELECT
		FirstName,
		LastName
	FROM Sales.Customers
EXCEPT
	SELECT
		FirstName,
		LastName
	FROM Sales.Employees

/**-----------*/

/**--------------------------------INTERSECT---------------------------------------------*/

	-- RETURNS ALL THE COMMON ROWS FROM 2 TABLES
	-- WILL REMOVE DUPLICATES

/**-----------EXAMPLE---------------------*/
	
	SELECT
		FirstName,
		LastName
	FROM Sales.Customers
INTERSECT
	SELECT
		FirstName,
		LastName
	FROM Sales.Employees

/**-----------*/


/**--------------------------------USE-CASE---------------------------------------------*/

	-- COMBINING SIMILAR TABLES BEFOR DOING DATA ANALYSIS 
	-- 

/**-----------EXAMPLE---------------------*/
	
	SELECT
		FirstName,
		LastName
	FROM Sales.Customers
INTERSECT
	SELECT
		FirstName,
		LastName
	FROM Sales.Employees

/**-----------*/

/**-----------EXAMPLE---------------------*/
	
	SELECT
	   'Orders' AS SOURCE_TABLE
	  ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
	FROM Sales.Orders
UNION
	SELECT
	   'OrdersArchive' AS SOURCE_TABLE
	  ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
	FROM Sales.OrdersArchive

/**-----------*/


