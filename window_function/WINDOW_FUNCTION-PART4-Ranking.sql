/**------------------------------WINDOW FUNCTIONS--------------------------------------*/
/**--------------------------------Ranking---------------------------------------------*/

	-- Rank: 
		-- sorting is the first step 
		-- two method in ranking
			-- Int based ranking  -> Discrete scale 1 to n
				-- when to use -> Find top 3 product (top / bottom N analysis )
				-- Row_number()
				-- Rank()
				-- Dense_Rank()
				-- NTile()
			-- percentage of the row -> contimuous scale 0 to 1
				-- when to use -> Find 20% of the product (distribution analysis)
				-- Cume_dist()
				-- Percent_Rank()

  --Syntax:
		--	Expression Rank()
			-- No argument

		-- Over 
			-- Indication for window function

		-- Order By
			-- Reuqired

		-- partition by 
			-- optional

		-- frame 
			-- Not allowed in the ranking function

/**--------------------------------Int-basd-ranking---------------------------------------------*/
/**--------------------------------Row_Number()---------------------------------------------*/

	-- row_number() 
		-- assign each row a unique number as rank
		-- ties are not handled

/**--EXAMPLE-Row_number()--*/

	select
		OrderID,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(ORDER BY Sales DESC) as Sales_Rank
	from Sales.Orders;

/**--------------*/

/**--EXAMPLE-Row_number()-EXAMPLE-Highest-sales-for-each-products-*/

select * from (
	select
		OrderID,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(Partition BY ProductID ORDER BY Sales DESC ) as Sales_Rank
	from Sales.Orders
	) t
where Sales_Rank = 1

/**--------------*/

/**--EXAMPLE-Highest-sales-for-each-products-*/

select * from(
	select
		CustomerID,
		SUM(Sales) Sales ,
		ROW_NUMBER() OVER(ORDER BY SUM(Sales)) as Customer_Rank
	from Sales.Orders
	group by CustomerID
) t
where Customer_Rank <= 2

/**--------------*/

/**--EXAMPLE-Asign-Unique-Id-for-eaach-row-*/

	select
		  ROW_NUMBER() OVER(ORDER BY OrderID) as id
		, *
	from Sales.OrdersArchive

/**--------------*/

/**--EXAMPLE-find-duplicates-*/
select * from(
	select 
		  ROW_NUMBER() Over(Partition by OrderID Order BY CreationTime DESC) rn
		, *
	from Sales.OrdersArchive
	) t
where rn =1
/**--------------*/

/**--------------------------------Rank()---------------------------------------------*/

	-- Rank() 
		-- assign each row a number as rank
		-- ties are handled
		-- gaps are possible in Rank function i.e number can be skipped


/**--EXAMPLE-Rank()--*/

	select
		OrderID,
		ProductID,
		Sales,
		Rank() OVER(ORDER BY Sales DESC ) as Sales_Rank
	from Sales.Orders;

/**--------------*/

/**--EXAMPLE-Rank()--*/

	select
		OrderID,
		ProductID,
		Sales,
		Rank() OVER(PARTITION BY ProductID  ORDER BY Sales DESC ) as Sales_Rank
	from Sales.Orders;

/**--------------*/

/**--------------------------------Rank()---------------------------------------------*/

	-- Rank() 
		-- assign each row a number as rank
		-- ties are handled
		-- gaps are not possible in Rank function i.e number can be skipped

/**--EXAMPLE-DENSE-Rank()--*/

	select
		OrderID,
		ProductID,
		Sales,
		DENSE_RANK() OVER(ORDER BY Sales DESC ) as Sales_Rank
	from Sales.Orders;

/**--------------*/

/**--EXAMPLE-DENSE-Rank()--*/

	select
		OrderID,
		ProductID,
		Sales,
		DENSE_RANK() OVER(PARTITION BY ProductID ORDER BY Sales DESC ) as Sales_Rank
	from Sales.Orders;

/**--------------*/

/**--------------------------------NTile()---------------------------------------------*/

	-- NTILE() 
		-- Divides the rows into a specific number of aprox equal groups (Buckets)
		-- Nitile(2) arg is required
		-- Order By is a must
		-- bucket size = number of rows / number of bucket  --> bucket size =  4(rows)/2(bucket) i.e 2
		-- if the rows are even number we will dived based on uneven bucket 
				-- that isif row = 5 bucket = 2 then we will have 3 buckt first and 2 bucket next
				-- the rule is larger bucket will be allocated first then the smallerone


/**--EXAMPLE-NTILE()--*/

	select
		OrderID,
		Sales,
		NTILE(1) OVER(ORDER BY Sales DESC ) as bucket1,
		NTILE(2) OVER(ORDER BY Sales DESC ) as bucket2,
		NTILE(3) OVER(ORDER BY Sales DESC ) as bucket3,
		NTILE(4) OVER(ORDER BY Sales DESC ) as bucket4,
		NTILE(5) OVER(ORDER BY Sales DESC ) as bucket5,
		NTILE(6) OVER(ORDER BY Sales DESC ) as bucket6
	from Sales.Orders;

/**--------------*/

/**--EXAMPLE-NTILE()-data-segment--*/

	-- data segmentation: divides a dataset into distinct subset based on ceriteria

 select 
	*,
	CASE WHEN sales_bucket = 1 then 'High-Value'
		 WHEN sales_bucket = 2 then 'Medium-Value'
		 WHEN sales_bucket = 3 then 'Low-Value'
	END AS Customer_value
 from (
	select
		OrderID,
		Sales,
		NTILE(3) OVER(ORDER BY Sales Desc) as sales_bucket
	from Sales.Orders
	) t
/**--------------*/

/**--EXAMPLE-NTILE()-Load-balencing--*/

select
	NTILE(2) OVER(ORDER BY OrderID),
	*
from
	Sales.Orders

/**--------------*/

/**--------------------------------%-basd-ranking---------------------------------------------*/
	-- Types: 
		-- CUME_DIST
		-- Percentage_Rank
/**--------------------------------CUME_DIST-ranking---------------------------------------------*/
	-- CUME_DIST - more inclusive

		-- cummulative distribution caluclates the distribution of data points within a window
		-- row number/number of rows i.e each row number will change the number of row remains same
		-- if we encounter a tie we take the largest row number and divide it by total number of rows
		
	-- 

/**--------------------------------Percentage_Rank-ranking---------------------------------------------*/

	-- Percentage_Rank - more exclusive

		-- Calculated the relative position of each row
		-- row number-1/number of rows -1
	
	--  

/**--EXAMPLE-NTILE()-top-40%-of-product---*/

select * from (
	select
		*,
		CUME_DIST() OVER(Order by Price DESC) * 100 as productRank
	from
		Sales.Products
	) t
where productRank  <= 40

/**--------------*/

/**--EXAMPLE-NTILE()-top-40%-of-product---*/

select * from (
	select
		*,
		CUME_DIST() OVER(Order by Price DESC) * 100 as productRank
	from
		Sales.Products
	) t
where productRank  <= 40

/**--------------*/

