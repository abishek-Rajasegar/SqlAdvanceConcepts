---------------------------------------------------SQL-TIPS----------------------------------------------

	-- always check the execution plan
	-- if same perfromance in both query always pick which is readable 
	
---------------------------------------------------FETCh-TIPS----------------------------------------------

	-- slelect only the required columns avoid *
	-- avoid distinct and order by for each query
	-- for exploration use limit 

---------------------------------------------------FILTRING-TIPS----------------------------------------------

	-- create non clustered index to improve the performance
	-- avoid applying fuction on top of index columns or avoid using the function like SMALLER or UPPER on where clause
	-- ex: year(OrderDate) = 2025 index will not work if we have like this 
	-- aviod leading wildcard "%Ram" will be problem we can use "Ram%"
	-- use IN instead multiple OR
	
---------------------------------------------------JOIN-TIPS----------------------------------------------
	
	-- uderstand the performance of join 
		-- always use INNER joins
		-- LEFT and RIGHT join a slightly slow
		-- OUTER joins will be the worst perfromance
	-- dont use joins in the WHERE clause like [c.CustomerID = o.CustomerID]
	-- always use the inner join instead using like the above
	-- ensure the columns in on clause are indexd -- lookup is speed -- not index it is a full scane 
	-- always filter before joining (sub query)
	-- aggregate before joining (sub query)
	-- use UNION instead of or in join -- it avoids index
	-- check for nested loops use SQL hints OPTION(HASH JOIN)
	-- USE UNIONALL instead of UNION if duplicates are accepted 
	-- USE UNIONALL+DISTINCT instead of UNION if duplicates are NOT accepted 

---------------------------------------------------AGG-IPS----------------------------------------------

	-- use columnstore index for agg on large table
	-- pre agg data and store data in new table (the temp tables shoould be updated frequently)
	-- avoid using IN operator for filtring one table based on another table
	-- JOIN and EXISTS works the same for medium table
	-- For large thable EXISTS works best as it just check the existance of the data
	-- avoid redudant logic in query 

---------------------------------------------------CREATE-TABLES-TIPS----------------------------------------------
	
	-- avoid text data type they are resource intensive
	-- change the text type to VARCHAR()
	-- keep the date and number as its own type not VARCHAR as they can have any type
	-- avoid using max and large storgae size. VARCHA(225) use only when required or go with small number 
	-- use not null if possible Ex: FirstName VARCHAR(50) NOT NULL
	-- make sure the PK are clustered Ex: CustomerID INT PRIMARY KEY CLUSTERED
	-- create non-clustered for foreign key is it is frequently used
	
---------------------------------------------------INDEXING-TIPS----------------------------------------------

	-- avoid over indexing
	-- drop unused indexex
	-- update the statistics weekly
	-- Reorganize and Rebuild Indexes
	-- Partition large table to improve the performance
	
---------------------------------------------------INDEXING-TIPS----------------------------------------------
	
	-- focus on writing cler queries
	-- optimize perfromance only when necessary
	-- Always test using execution plan 
	-- 







