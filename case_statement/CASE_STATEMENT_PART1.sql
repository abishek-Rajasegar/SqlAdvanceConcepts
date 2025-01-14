/**------------------------------CASE STATEMENT------------------------------------*/
/**------------------------------SET-OPERATORS-------------------------------------*/

	 -- SYNTAX:
		-- CASE --> START
		-- WHEN --> CONDITION
		-- THEN --> RESULT WHEN TRUE
		-- ELSE --> RESULT WHEN FALSE
		-- END  --> END OF STATEMENT

	-- MAINLY USED FOT DATA TRANSFORMATION
	
	-- CATEGORIZING DATA
		
/**-----------EXAMPLE---------------------*/

	select CATEGORIES , sum(Sales) as total_sales  from(
		SELECT
			OrderID,
			Sales,
			CASE 
				WHEN Sales > 50 THEN 'HIGH'
				WHEN Sales > 20 THEN 'MEDIUM'
				ELSE'LOW'
			END AS CATEGORIES
		FROM Sales.Orders 
	) t
	group by CATEGORIES
	order by total_sales desc

/**-----------*/

/**-----------MAPPING---------------------*/

	SELECT 
		*,
		case 
		when Gender = 'M' then 'Male'
		when Gender = 'F' then 'Female'
		end as full_gender,
		case Gender
		when 'M' then 'Male'
		when 'F' then 'Female'
		end as full_gender_other_option
	FROM Sales.Employees

/**-----------*/

/**-----------NULL-REPLACE---------------------*/

	select
		CustomerID,
		LastName,
		Score,
		case 
			when Score is NULL then 0
			else Score
		end as new_score,
		AVG(Score) OVER() AVG_CUSTOMERS,
		AVG(case when Score is NULL then 0 else Score END) OVER() AS AVG_WITH_0
	from 
		Sales.Customers

/**-----------*/

/**-----------CONDITIONAL-AGG---------------------*/

	-- APPLY AGG FUNCTIONS ONLY ON SUBSET PF DATA THAT FULFILLS CERTAIN CONDITIONS
	-- TARGET ANALYSIS
   
   SELECT
          CustomerID
		, count(*) total_orders
		, Sum(case when Sales > 30 then 1 else 0 end) order_count_morethan_30
	from Sales.Orders
	group by CustomerID


/**-----------*/
