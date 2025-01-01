/**------------------------------WINDOW FUNCTIONS--------------------------------------------*/
/**--------------------------------Running and Rolling Totals---------------------------------------------*/

 --- tracking current sales with target sales:
	-- they agg sequence of members . and the aggregation is updated each time a new member is added

	-- RUNNING TOTAL : more or less like a cummulative total
			--  agg all the values from the start till the current point without fropping old data

	-- ROLLING TOTAL :
			-- agg all the values within a fixed time window. oldest data point will be removed

	-- MOVING AVG :
			--  same like RUNNING TOTAL


/**--EXAMPLE-total-orders-by-customers--*/

	select
		OrderID,
		ProductID,
		OrderDate,
		Sales,
		AVG(Sales) Over(PARTITION BY ProductID ) as products_avg,
		AVG(Sales) Over(PARTITION BY ProductID Order BY OrderDate) as moving_avg,
		AVG(Sales) Over(PARTITION BY ProductID Order BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) as moving_avg
	from Sales.Orders
	
/**--------------*/
