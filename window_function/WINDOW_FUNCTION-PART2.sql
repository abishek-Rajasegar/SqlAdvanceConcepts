/**------------------------------WINDOW FUNCTIONS--------------------------------------------*/
/**--------------------------------AGG FUNCTIONS---------------------------------------------*/

-- AGG FUNCTIONS -- COUNT, SUM, AVG, MIN, MAX

-- COUNT -> RETURN NUMBER OF ROW IN EACH WINDOW
		-- COUNT(*) OR COUNT(1) WILL "CONSIDER NULL" AS ROW AND WILL BE INCLUDED IN COUNTING
		-- COUNT(COLUMN_NAME) WILL "NOT CONSIDER NULL" AS ROW AND WILL NOT BE INCLUDED IN COUNTING

/**--EXAMPLE-total-orders-by-customers--*/

	select
		* ,
		count(*) over() total_customers ,-- COUNT ALL THE VALUES INCLUDING NULLL
		count(SCORE) over() total_customers_by_score -- COUNT ALL THE NON-NULL VALUES
	from Sales.Customers
	
/**--------------*/

/**--EXAMPLE-check-duplicates--*/

	select 
		OrderID,
		count(*) OVER(PARTITION BY OrderID) check_duplicates
	from 
		sales.Orders

/**--------------*/

/**--EXAMPLE-check-duplicates--*/
	
	select * from
		(select 
			OrderID,
			count(*) OVER(PARTITION BY OrderID) check_duplicates
		from 
			sales.OrdersArchive
		) t
	where check_duplicates <> 1

/**--------------*/

--  SUM -> RETURN SUM OF ROWS IN EACH WINDOW
	---
	---
	---

/**--EXAMPLE-total-SALES-by-product--*/

	select 
		OrderID ,
		OrderDate ,
		Sales ,
		SUM(Sales) OVER() total_sales,
		SUM(Sales) OVER(PARTITION BY ProductID) total_sales_by_product
	from 
		sales.Orders

/**--------------*/

/**------part to whole comparison--------*/

	select 
		OrderID ,
		ProductID ,
		Sales ,
		sum(Sales) over() total_sales,
		ROUND(cast(sales AS float)/sum(Sales) over() * 100,2) AS '%-TOTAL'
	from 
		sales.Orders

/**--------------*/

--  AVG -> RETURN AVG OF ROWS IN EACH WINDOW
	--- NULL WILL BE IGNORED
	---
	---

/**------EXAMPLE-avg-score-and-product-avg score----*/

	select 
		OrderID ,
		ProductID ,
		Sales ,
		AVG(Sales) over() avg_sales,
		AVG(Sales) over(PARTITION BY ProductID) product_avg_sales
	from 
		sales.Orders;

/**--------------*/

/**------EXAMPLE-avg-score-of-customers----*/

	select 
		customerID ,
		Score ,
		coalesce(Score,0) customer_score ,
		AVG(coalesce(Score,0)) over() customer_avg_sales
	from 
		sales.Customers;

/**--------------*/

/**------EXAMPLE-sales->-avg_sales----*/

	select * from 
		(select
			OrderID ,
			ProductID ,
			Sales,
			AVG(Sales) OVER() avg_sales
		from Sales.Orders) t
	where Sales >= avg_sales;

/**--------------*/

--  MIN/MAX -> RETURN MIN OR MAX VALUES IN EACH WINDOW
	--- NULL WILL BE IGNORED
	---
	---

/**------EXAMPLE-MIN-AND-MAX-VALUES----*/
	
	SELECT
		OrderID,
		OrderDate,
		ProductID,
		Sales,
		MAX(Sales) OVER() max_sales,
		MIN(Sales) OVER() max_sales,
		MAX(Sales) OVER(PARTITION BY ProductID) max_sales,
		MIN(Sales) OVER(PARTITION BY ProductID) max_sales
	FROM 
		Sales.Orders	

/**--------------*/

/**------EXAMPLE-MIN-AND-MAX-VALUES----*/
	
	select * from
		(SELECT
			*,
			MAX(Salary) over() highest_salary
		FROM 
			Sales.Employees	) t
	where Salary = highest_salary

/**--------------*/

/**------EXAMPLE-MIN-AND-MAX-VALUES----*/
	
	select * from
		(SELECT
			*,
			MAX(Salary) over() highest_salary
		FROM 
			Sales.Employees	) t
	where Salary = highest_salary

/**--------------*/
