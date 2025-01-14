/**-------------------------------------------Views-----------------------------------------*/

	-- SQL Server manages all the db
	-- db is collection of information
	-- schema is way to group related items into groups
	-- tables is where actual data is stored
	-- view is like structure of table but no data is present 
		-- we can define multile columns
		-- each columns there is a name and data type

	-- to do all these we use DDL
	-- it helps to define the structure of the db
	-- create , alter , drop 

	-- 3 level architecture 
		-- PHYSICAL (INTERNAL) :
			-- LOWEST LEVEL -- THE DATA IS AVAILABLE IN THIS LEVEL 
			-- DATA FILE , PRTITION , LOGS
			-- DB ADMIN
		-- LOGICAL (CONCEPTUAL) :
			-- STRUCTURE YOU DATA 
			-- CRETE TABLE DEFINE RELATIONSHIP , VIEWS , INDEX AND MORE
			-- FUNCTION AND STORED PROCEDURE
			-- DE
		-- VIEW (EXTERNAL) :
			-- END USERS LEVEL 
			-- CAN BE USE FOR BI DEVELOPERS , BA , AND OTHE TEAMS
			-- THESE PEOPLE CAN USE THE DATA BASED ON THEIRE REQUIREMENTS

/**--------------------------------------Views-definition-----------------------------------*/

	-- views is a table based on the result set of a query without storing the data in DB
	-- views are persisted SQL queries in DB
	-- views is a abstraction layer between users and the actual DB table
	-- views are wasy to maintain 
	-- tables are faster than the views
	-- views are read only

/**--------------------------------------Views-requirements---------------------------------*/
	
	-- most redundent queries that are used by users are created as view
	-- and other logics are done by users utilizing the view 	

/**--------------------------------------View-VS-CTE----------------------------------------*/

	-- view reduces redundency in multiple queries and cte in one query
	-- presisted logic in views and temporary logic in cte

/**--------------------------------------View-Syntax----------------------------------------*/

	-- SYNTAX:
		-- create view view-name as (
			-- query
		-- )

/**--------------------------------------CTE------------------------------------------------*/

with cte_monthly_sales as(
	select
		datetrunc(MONTH , OrderDate) as OrderMonth,
		sum(Sales) as Total_Sales
	from Sales.Orders
	group by datetrunc(MONTH , OrderDate)

)
select 
	  OrderMonth
	, Total_Sales
	, sum(Total_Sales) Over (Order by OrderMonth) as RunningTotal
from cte_monthly_sales;

/**-------------------------------------CREATE-VIEW----------------------------

	IF OBJECT_ID('vMonthly_Summary', 'V') IS NOT NULL
		DROP VIEW vMonthly_Summary;
	GO
	CREATE VIEW Sales.vMonthly_Summary AS
		(
			select
				datetrunc(MONTH , OrderDate) as OrderMonth,
				sum(Sales) as Total_Sales,
				count(OrderID) as TotalOrders
			from Sales.Orders
			group by datetrunc(MONTH , OrderDate)

		)

-------------*/

/**-------------------------------------SELECT-VIEW-----------------------------------------*/
	
	
	select * from Sales.vMonthly_Summary;


/**-------------------------------------HOW-VIEW-WORKS--------------------------------------*/

	-- VIEW IS STORED IN CATELOG 
	-- FOR VIEWS THE CATELOG STORES BOTH METADATA AND SQL QUERY 

/**-------------------------------------HOW-TO-USES-VIEWS-------------------------------------*/

	-- VIEWS IS USEFUL FOR DATA SECURITY 
		-- COLUMN LEVEL SECURITY
		-- ROW LEVEL SECURITY 
		-- MULTI TEAM VIEWS
		-- LANGUAGE WISE SPLIT
		-- REGION WISE SPLIT
		-- VIRTUAL DATA MARTS IN DW
			-- DATA MARTS IS SPECIFIC TO ONE TOPIC
			-- EX: it, hr sales ALL THESE CAN BE MADE INTO DATA MARTS










