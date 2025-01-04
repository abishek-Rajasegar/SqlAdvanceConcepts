/**------------------------------WINDOW FUNCTIONS------------------------------------*/
/**--------------------------------VALUE---------------------------------------------*/

	-- ALSO CALLED WINDOW ANALYTICS FUNCTIONS
	-- WE CAN ACCESS THE ROW FROM ANOTHER ROW 

 /**--------------------------------VALUE-LEAD-AND-LAG---------------------------------------------*/

	-- LAG
		-- PREVIOUS ROW FOR THE CURENTLY VALIDATING ROW
	-- LEAD
		-- NEXT ROW FOR THE CURENTLY VALIDATING ROW

	-- SYNTAX:
		-- LEAD(COLUMNS,OFFSET,DEFAULT) --> EXAMPLE: LEAD(SALES , 2, 10)
			-- COLUMN(SALES) - EXPRESSION
			-- OFFSET(2) OPTIONL - NUMBERS OF ROWS
			-- DEFAULT(10) OPTIONAL - DEFAULT VALUE OF THERE IS NO MORE LEADING ROWS 
		
		-- OVER (PARTITION BY COLUMN ORDER BY COLUMNS)
			-- PARTITION BY OPTIONAL
			-- ORDER BY IS MUST
			-- FRAME NOT ALLOWED

/**--------------------------------MONTH-OVER-MONTH-ANALYSIS---------------------------------------------*/

SELECT *,
	round((cast((SALES - PREV_SALES) as float)/PREV_SALES) * 100,2)  diff
from(
	SELECT
		  MONTH(OrderDate) AS MONTH
		, SUM(Sales) AS SALES
		, LAG(SUM(Sales),1) OVER(ORDER BY MONTH(OrderDate)) PREV_SALES
	FROM Sales.Orders
	GROUP BY MONTH(OrderDate)
) t
/**--------------*/

/**--------------------------------CUSTOMER-RETENTION-ANALYSIS---------------------------------------------*/

SELECT 
	CUSTOMERID,
	AVG(DAYS_UNTIL_NEXT_ORDER) AVG_DAYS, 
	RANK() OVER(ORDER BY COALESCE(AVG(DAYS_UNTIL_NEXT_ORDER),1000000000)) RANK_AVG

FROM(
	SELECT
		OrderID,
		CustomerID,
		OrderDate CURRENT_DAY,
		LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS NEXT_DAY,
		DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY ORDERDATE)) AS DAYS_UNTIL_NEXT_ORDER
	FROM Sales.Orders
) T
 
GROUP BY CUSTOMERID

/**--------------*/

 /**--------------------------------VALUE-LEAD-AND-LAG---------------------------------------------*/

	-- FIRST_VALUE()
		-- ACCESS A VALUE FROM FIRST ROW WITHIN A WINDOW --> ALWAYS THE FIRST ROW 
	-- LAST_VALUE()
		-- ACCESS A VALUE FROM LAST ROW WITHIN A WINDOW --> ALWAYS THE CURRENT ROW VALUE
		-- NEED TO CUSTOMIZE THE FRAME TO GET THE LAST VALUE
		-- ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING

	-- SYNTAX:
		-- LEAD(COLUMNS,OFFSET,DEFAULT) --> EXAMPLE: LEAD(SALES , 2, 10)
			-- COLUMN(SALES) - EXPRESSION
			-- OFFSET(2) OPTIONL - NUMBERS OF ROWS
			-- DEFAULT(10) OPTIONAL - DEFAULT VALUE OF THERE IS NO MORE LEADING ROWS 
		
		-- OVER (PARTITION BY COLUMN ORDER BY COLUMNS)
			-- PARTITION BY OPTIONAL
			-- ORDER BY IS MUST
			-- FRAME ALLOWED

/**--------------------------------HIGHEST-AND-LOWEST-SALES-OF-PRODUCT-ANALYSIS---------------------------------------------*/


SELECT 
	OrderID,
	ProductId,
	Sales,
	FIRST_VALUE(Sales) Over(Partition By ProductId Order By Sales) as min_sales,
	LAST_VALUE(Sales) Over(Partition By ProductId Order By Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as max_sales,
	sales - FIRST_VALUE(Sales) Over(Partition By ProductId Order By Sales) min_sales_diff,
	LAST_VALUE(Sales) Over(Partition By ProductId Order By Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) - sales  as max_sales_diff
	--FIRST_VALUE(Sales) Over(Partition By ProductId Order By Sales desc) as max_sales, -- alternative way to get max value
	--MIN(Sales) Over(Partition By ProductId) as max_sales, -- dircet way to get min value
	--MAX(Sales) Over(Partition By ProductId) as max_sales -- dircet way to get max value
FROM
	Sales.Orders