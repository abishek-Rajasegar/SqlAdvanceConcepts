/**------------------------------SUBQUERY--------------------------*/
	-- ITS A QUERY INSIDE ANOTHER QUERY
	-- THE MAIN QUERY USES SUBQUERY TO FILTER SELECT OR MORE DB OPERATION 
	-- THE MIN QUERY CAN INTERACT WITH THE SUBQUERY
	-- SUBQUERY CAN BE USED ONLY FROM MAIN QUERY
	
	-- CATEGORIES:
		-- DEPENDENCY
			-- NON-CORRELATED SUBQUERY
				-- subquery that can run independently from the main query
			-- CORRELATED SUBQUERY
				--  it relies for values from main query

		-- RESULT TYPE:
			-- SCALR SUBQUERY -- SINGLE VALUE 

/**------------------------------SCALR SUBQUERY--------------------------*/
		
		SELECT AVG(Sales) from Sales.Orders

/**------------------*/

			-- ROW SUBQUERY -- SINGLE ROW

/**------------------------------ROW-SUBQUERY--------------------------*/
		
		SELECT Sales from Sales.Orders

/**------------------*/

			-- TABLE SUBQUERY -- TABLE OUTPUT

/**------------------------------ROW-SUBQUERY--------------------------*/
		
		SELECT Sales , ProductID from Sales.Orders where ProductID = 101

/**------------------*/

		-- LOCATION OR CLAUSES:
			-- SELECT
			--
			--

/**------------------------------SELECT--------------------------*/
		
		SELECT
			OrderID,
			(SELECT MAX(FirstName+' '+LastName) FROM Sales.Customers WHERE CustomerID = O.CustomerID) CUSTOMERS
		FROM Sales.Orders O

/**------------------*/	

/**------------------------------SELECT--------------------------*/
		
		SELECT 
			* , 
			(select count(*) from Sales.Orders
			where ProductID = p.ProductID) as order_count 
		FROM Sales.Products p 

/**------------------*/	

			-- FROM -- sub suery in from acts as a table
			--
			--

/**------------------------------FROM--------------------------*/
		
		SELECT ProductID,CustomerID FROM 
			(SELECT * from Sales.Orders where ProductID = 101) temp

/**------------------*/
/**------------------------------FROM--------------------------*/
	-- PRICE > THAN THE AVG PRICE
	SELECT * FROM
			(SELECT
				 ProductID
				,Price
				,AVG(PRICE) OVER()  AS AVG_PRICE 
			FROM Sales.Products
			) T
		WHERE Price > AVG_PRICE

/**------------------*/
/**------------------------------FROM--------------------------*/
	
	-- RANK CUSTOMER BASED ON TOTAL SALES	
	SELECT 
	  CustomerID 
	, TOTAL_SALES 
	, RANK() OVER(ORDER BY TOTAL_SALES DESC) CUSTOMER_RANK 
		FROM(
			SELECT 
				CustomerID,
				Sum(Sales) TOTAL_SALES
			FROM Sales.Orders
			GROUP BY CustomerID
		) T

/**------------------*/

			-- JOINING TABLE
			--
			--

/**------------------------------ JOINING--------------------------*/				
	
	select 
		  c.* 
		, order_count
	from 
		Sales.Customers c
	left join 
	(select CustomerID,count(*) order_count  from Sales.Orders group by CustomerID ) as t
	on t.CustomerID = c.CustomerID

/**------------------*/

			-- WHERE: 
				-- COMPARISON - < , > , >= , <=  , !=
				-- LOGICAL IN ANY ALL EXISTS
/**------------------------------WHERE--------------------------*/				
	
		SELECT *,
		(SELECT AVG(Price) FROM Sales.Products) avg_price
		FROM Sales.Products
		WHERE Price > (SELECT AVG(Price) FROM Sales.Products)

/**------------------*/
			
/**------------------------------WHERE--------------------------*/				

	select * from Sales.Orders
	where CustomerID IN (select customerid from Sales.Customers where Country = 'Germany')

/**------------------*/

/**------------------------------WHERE--------------------------*/				
	select
		EmployeeID,
		FirstName,
		Salary
	from Sales.Employees
	where Gender = 'F'
	and Salary > any (select Salary from Sales.Employees where Gender = 'M')
	
/**------------------*/

/**------------------------------WHERE--------------------------*/				
	-- all operator

	select
		EmployeeID,
		FirstName,
		Salary
	from Sales.Employees
	where Gender = 'F'
	and Salary > all (select Salary from Sales.Employees where Gender = 'M')
	
/**------------------*/

	select 
		  c.* 
		, (select count(*) from Sales.Orders where CustomerID = c.CustomerID) total_order
	from 
		Sales.Customers c

/**------------------*/						

/**------------------------------WHERE--------------------------*/				
	-- exists:

	select * from Sales.Orders s
	where exists 
				(select  * 
				  from  Sales.Customers 
				  where  Country = 'Germany' and CustomerID = s.CustomerID	
				)

/**------------------*/

	select * from Sales.Orders s
	where not exists 
				(select  * 
				  from  Sales.Customers 
				  where  Country = 'Germany' and CustomerID = s.CustomerID	
				)

/**------------------*/
	
	select * 
	from Sales.Orders s
	where
	CustomerID NOT IN 
		(select  CustomerID from  Sales.Customers where  Country = 'Germany' )

/**------------------*/

