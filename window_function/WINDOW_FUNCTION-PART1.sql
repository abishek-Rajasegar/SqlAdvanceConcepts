/**------------------------------WINDOW FUNCTION--------------------------------------------*/
-- SYNTAX OF WINDOW FUNCTION

-- WINDOW FUNCTION -> "FUNCTION_NAME(FUNCTION_EXPRESION)"

	-- AGGRIGATION -> SUM() , MIN() , MAX() AND MORE 
			-- ONLY INT AND TXT VALUES FOR COUNT()
	
	-- RANK -> ROW_NUMBER() , RANK() , DENSE_RANK() , CUME_DIST(), PERCENT_RANK()
			-- NTILE() -- ONLY NUM FOR NTILE() OTHERS EMPTY 
	
	-- VALUE - LEAD() , LAG() , FIRST_VALUE() , LAST_VALUE() -- ALL DATA TYPES
	
	-- EXAMPLE:  
			-- RANK() - EMPTY
			-- AVG(SALES) - COL
			-- NTEIL(2) - NUM
			-- LEAD(SALES, 2, 10) - MULTI ARGS
			-- SUM(CASE WHEN SALES > 100 THEN 1 ELSE 0 END) - CONDITIONAL LOGIC

-- OVER CLAUSE - > PARTITION , ORDER BY , FRAME 
	-- OVER HELPS SQL TO IDENTIFY THAT IS A WINDOW FUNCTION EXPRESSION	

	-- PARTITION BY (OPTIONAL) -> VERY SIMILART TO GROUP , 
		-- IT DIVIDES THE DATA INTO WINDOW PARTITIONS
		-- IT CAN TAKE NO ARGS OR ONE OR MORE ARGS

	-- ORDER BY (OPTIONAL) -> USED FOR SORTING
		-- IT SORT THE DATA 
		-- IT CAN TAKE ONE OR MORE ARGS
	
	-- FRAME CLAUSE
		-- WE CAN USE A SUBSET OF DATA WITHIN A WINDOW
		-- THIS IS HELPFUL WHEN A SMALL PARTITION OF DATA IN A WINDOW IS REQUIRED	
		-- ORDER BY IS MUST WHEN USING FRAME
		-- WE CAN USE BOUNDRY OF A FRAME USING BETWEEN 
			-- POSSIBLE VALES: 
				-- CURRRENT ROW
				-- N PRECEDING (BEFORE CURRENT ROW)
				-- N FOLLOWING (AFTER CURRENT ROW)
				-- UNBOUNDED PRECEDING (FIRST VALUES)
				-- UNBOUNDED FOLLOWING (LAST VALUES)

-- WHAT WE SHOULD NOT DO IN WINDOW FUNCTION 
	-- WE CANNOT USE THE WINDOW FUNCTION COLUMNS IN WHERE CLAUSE AND GROUP BY
	-- WINDOW FUNCTION INSIDE ANOTHER WINDOW FUNCTION IS NOT ALLOWED
	-- WINDOW FUNCTION EXECUTES AFTER FILTERING DATA WITH WHERE CLAUSE
	-- WINDOW FUNCTION CAN BE USED WITH GROUP BY ONLY WITH THE SAME COLUMN IN SELECT CLAUSE

/**---------------------------WINDOW FUNCTION EXAMPLE------------------------*/

SELECT 
	  ProductID
	, OrderID
	, OrderDate
	, SUM(Sales) as TotalSales
FROM 
	SALES.Orders
GROUP BY
	  ProductID
	, OrderID
	, OrderDate;

/**--------------------------------------------------------------------------*/

select 
	  ProductID
	, OrderID
	, OrderDate
	, sum(Sales) over(partition by ProductID)  TotalSales
from 
	Sales.Orders;

/**--------------------------------------------------------------------------*/

SELECT 
	  OrderID
	, OrderDate
	, ProductID
	, Sales
	, OrderStatus
	, Sum(Sales) OVER() as TotalSales
	, Sum(Sales) OVER(PARTITION BY ProductID) as TotalSales_By_Product
	, Sum(Sales) OVER(PARTITION BY ProductID, OrderStatus) as TotalSales_By_Product_Order_Status
FROM
	Sales.Orders;

/**--------------------------------------------------------------------------*/

SELECT
	  OrderID
	, OrderDate
	, sales
	, RANK() OVER(ORDER BY sales DESC) Sales_Rank
FROM	
	sales.Orders
ORDER BY sales desc;

/**--------------------------------------------------------------------------*/

SELECT
	  OrderID
	, OrderDate
	, OrderStatus
	, sales
	, SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) Sales
FROM	
	sales.Orders
ORDER BY OrderStatus,OrderDate;

/**--------------------------------------------------------------------------*/

SELECT
	CustomerID,
	SUM(Sales) TOTAL_SALES,
	RANK() OVER(ORDER BY SUM(Sales) DESC) SCRE_RANK
FROM 
	Sales.Orders
GROUP BY CustomerID

/**--------------------------------------------------------------------------*/