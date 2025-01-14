/**------------------------------------CTAS-AND-TEMP_Tables-------------------------------------*/
/**---------------------------------------------CTAS--------------------------------------------*/

	-- DDL: data definition language  
		-- create , alter , drop  
	
	-- Logical layer
	-- Table is a collection of row and column and cell is a single element 
	-- Tables are stored as files and
	-- Tables type :
		-- permanent table
		-- temporary table

	-- Way to create a table create/insert vs CTAS
		-- create inster in a classical way to create a table in db
		-- CTAS create a table using result of a query 
	
	-- CTAS vs VIEW:
		-- In view the result is not stored in the db only works on demand
		-- In CTAS the result is stored in the db the table contains the result in it.
		-- Views are slower than CTAS 
		-- The updates will not be reflected in CTAS but views will have new data 
		
	-- SYNTAX:
		-- create table table_name AS
		-- (
				--query 
		-- )
		
	-- optimizing perfromance:
		-- can be used when views are slow
		-- can be used in data marts
	
/**-------------------------------------------Tables-----------------------------------------*/

		if OBJECT_ID('Sales.MonthlySales','U') is not null
			DROP TABLE Sales.MonthlySales
		GO
		select
			  DATENAME(month , OrderDate) as MonthName
			, sum(Sales) as TotalSale
		INTO Sales.MonthlySales  ---  this creates the table name MonthlySales and store it
		from sales.Orders
		group by DATENAME(month , OrderDate);
	
		select * from Sales.MonthlySales;

		

/**------------------------------------------Temp-Tables-----------------------------------------*/
	
	-- Temporary tables are used to store the intermediate results in temp table
	-- This is deleted after the session is over 
	-- session is a time between connectinga and disconnecting from db
	-- this can be same like accessing normal table

	-- syntax:
		-- select INTO #TABLE_NAME from where
		-- # helps db to identify that it is a temp table
		-- these are available in system database folder in that we will have tempdb

/**------------------------------------------Temp-Tables-ex----------------------------------------*/
	
	select
		*
	INTO #temp_orders
	from Sales.Orders;

	select * from dbo.#temp_orders

/**------------------------------------------Temp-Tables-ex----------------------------------------*/



















