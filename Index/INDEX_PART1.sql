/**-----------------------------------------------INDEX----------------------------------------------*/

	-- Index is Data structurs to provide quick access to data, optimizing the speed of the query 
	-- It speed up the search of the data
	-- different indexs are there for different purpose
		-- structure
			-- clustered 
			-- non-clustered
		-- storage
			-- RowStore 
			-- ColumnStore
		-- function
			-- Unique
			-- filtered

/**-------------------------------------what-if-we-dont-have-index----------------------------------*/

	-- All the data that we inser into sql table is stored as files
	-- Each files can store certain number of row
	-- When all the row in a page is filled the new page is created
	-- The row are stored in the same way as they are inserted 
	-- The are not organised and tored in the files
	-- So if we want a prticular row then we a full scane is required
	-- This can we very fast for write operatiom but the read will be slow
	-- the storage type is like a heap no clustered index 
	-- So we need index to read the data faster
	
/**------------------------------------------clustered-index-----------------------------------------*/
	
	-- Cluster index is used to organise the data pages and each page is known as a cluster
	-- The index is like a B_tree where the data is available in the leaf noad
	-- The node and intermeiate node store the ID of the cluster
	-- This avoids the requirement of the full table scan
	-- We can quickly locate the data is using Index

/**-------------------------------------------non-clustered-index-------------------------------------*/

	-- 1:102:96
	-- 1 -- page , 102-cluster , 96 -- offset
	-- The non clustered in dex will not rearrange the pages in Ascending order
	-- It creates the Index page where each PK will have the exact location 
	-- for example for id 1 the storage will be like [E1:102:96]
	-- 1 -- page , 102-cluster , 96 -- offset
	-- This will then have a main pages storeing all these index
	-- will have one extra page when comparing with clustered index
	-- the index is in the leav node 
	-- and the data pages are below that 

/**--------------------------------------------other-details------------------------------------------*/

	-- A table can have both cluster and non cluster index
	-- But the number of culstered index should always be one
	-- But there can be more than one non clustered index 
	-- The Cludtered index are fast in reading when compared to non cluster index 
	-- Write operation is always good without any index but non clustered index is good for wirte operations
	-- Clusteed index is more storage effecient but non culstered index reuqires space
	-- cluster index Uses:
		-- Unique Columns
		-- not frequently modified columns
	-- non clustered index uses:
		-- columns frequently used in search conditions and joins
		-- Exact match query


/**--------------------------------------------other-details------------------------------------------*/

	-- CREATE [CLUSTERED | NONCLUSTERED] INDEX index_name ON table_name(column_name1, column_name2 or more......)
	-- default is non-clustered
	-- pk will be defult clustered index for any table

/**--------------------------------------------create-cluster-index------------------------------------------*/
 
	-- CREATE A CLUSTERED INDEX:
		CREATE CLUSTERED INDEX IDX_CUSTOMERS_DUPLICATE_CUSTOMERID ON [SalesDB].[Sales].[Customers_Duplicate] (CustomerID)

	-- DROP A CLUSTERED INDEX:
		-- DROP INDEX IDX_CUSTOMERS_DUPLICATE_CUSTOMERID ON  [SalesDB].[Sales].[Customers_Duplicate]

/**---------------------------*/

/**--------------------------------------------create-non-cluster-index------------------------------------------*/
 
	-- CREATE A CLUSTERED INDEX:
		CREATE NONCLUSTERED INDEX IDX_CUSTOMERS_DUPLICATE_LASTNAME ON Sales.[Customers_Duplicate] (LastName)

	-- DROP A CLUSTERED INDEX:
		--DROP INDEX IDX_CUSTOMERS_DUPLICATE_LASTNAME ON  [SalesDB].[Sales].[Customers_Duplicate]

/**---------------------------*/
	
/**--------------------------------------------composite-index------------------------------------------*/
 
	-- CREATE A CLUSTERED INDEX:
		CREATE NONCLUSTERED INDEX IDX_CUSTOMERS_DUPLICATE_country_score ON Sales.[Customers_Duplicate] (Country, Score)

	-- DROP A CLUSTERED INDEX:
		--DROP INDEX IDX_CUSTOMERS_DUPLICATE_LASTNAME ON  [SalesDB].[Sales].[Customers_Duplicate]

		
	-- SQL WILL NOT USE COMPOSIT INDEX IF THE COLUMN ORDER IS CHANGED AND USED IN THE QUERY 
	-- SO THE ORDER IS IMPORTANT 
	-- AND THE LEFTMOST PREFIX RULE IS APPLIED, ALL THE COLUMNS MUST BE IN THE INDEX MENTIONED ORDER
	-- IF INDEX IN CREATE IN A,B,C ORDER
		-- IF YOU USE A IN WHERE INDEX WILL WORK
		-- IF YOU USE A,B,C IN WHERE INDEX WILL WORK
		-- ANYTHING APART FROM THIS WILL NOT WORK

/**---------------------------*/
	
/**---------------------------------------columns-store-index------------------------------------------*/

	-- Row store index stores the data in data pages row-by-row all the rows are stored together
	-- In column store the data is stored in separate column 
	-- In one data page only the value of on column is stored
	-- Rows are divided into row groups used for parallel process 
	-- Then the columns are segmented
	-- Then the data compression happens
	-- The data compression converts the rows into dictonary so similar values are grouped together
	-- So the rows are reduced
	-- Standard data pages are not used LOB (Large Object page)
	-- The page conatis the details about the dictornary 
	-- Dictionary have the key and value for each category 
	-- Each unique category is converted into unique identifier
	-- In the LOB pages the data is stored as stream [1,2,1,2,1,1,1,2,2,2]
	-- Instead of string the actual value
	-- Type of index is mandatory for column store
	-- When we use the clustered index the actual table is reorganised and the deleted 
	-- Whereas the non clustered index the acutal table in not deleted
	-- The ready opertaion will be fast becuse it gets ony the reuired columns alone
	-- But the write operation can be time consuming as the dictionary creation takes place
	-- High effeciency and high compression
	-- Mostly used in OLAP
	-- big data , scanning of large dataset, fast agg


/**---------------------------------------columns-store-index-syntax-----------------------------------*/


	-- CREATE [CLUSTERED | NONCLUSTERED] [COLUMNSTORE] INDEX index_name ON table_name(columns....)
	

/**---------------------------------------columns-store-index-ex:-----------------------------------*/

	create clustered columnstore index idx_customers_duplictes on Sales.Customers_Duplicate

/**---------------------------------------columns-store-index-ex:-----------------------------------*/

	create nonclustered columnstore index idx_customers_duplictes on Sales.Customers_Duplicate(FirstName)

/**---------------------------------*/
	
	-- HEAP OR NORMAL STORAGE -- this takes the more space in storgae and no space in index ok

	select 
		* 
	into dbo.FactInternetSales_heap_storage
	from FactInternetSales

/**---------------------------------*/
	
	-- row STORAGE -- this takes the more space both in storgae and index size worst

	select 
		* 
	into dbo.FactInternetSales_row_storage
	from FactInternetSales

	create clustered index idx_factinternet_sales_rs_pf on FactInternetSales_row_storage(SalesOrderNumber,SalesOrderLineNumber)

/**---------------------------------*/

	-- column STORAGE -- this takes the less space both in storgae and index size best

	select 
		* 
	into dbo.FactInternetSales_column_storage
	from FactInternetSales

	create clustered columnstore index idx_factinternet_sales_cs_pk on FactInternetSales_column_storage

/**---------------------------------*/
	
/**---------------------------------------unique-index------------------------------------------*/

	-- Makes sure there is not unique index 
	-- Enforce uniqueness
	-- And it improves the perfromance 
	-- Write operation is slow but read is faster
	
/**---------------------------------------unique-index-syntax-----------------------------------*/

	-- CREATE [UNIQUE] [CLUSTERED | NONCLUSTERED] [COLUMNSTORE] INDEX index_name ON table_name(columns....)
	
/**---------------------------------------unique-index-ex-----------------------------------*/


	SELECT * FROM Sales.Products

	CREATE UNIQUE NONCLUSTERED INDEX idx_product_product on Sales.Products(Product)

**---------------------------------------filtered-index------------------------------------------*/

	-- Makes sure tonly the filtered row are included in the table
	-- the index size will be very small
	-- only the targetted values will be added
	-- The storage is reduced
	-- WE CANNOT HAVE FILTERED INDEX ON A CLUSTERED INDEX
	-- WE CANNOT HAVE FILTERED INDEX ON COLUMN STORE
	
/**---------------------------------------filtered-index-syntax-----------------------------------*/

	-- CREATE [UNIQUE] [NONCLUSTERED] [COLUMNSTORE] INDEX index_name ON table_name(columns....)
	-- WHERE [CONDITION]

/**---------------------------------------filtered-index-ex-----------------------------------*/

	SELECT * FROM Sales.Customers
	WHERE Country = 'GERMANY'

	CREATE NONCLUSTERED INDEX idx_custpmers_counter on Sales.Customers(Country)	 
	WHERE Country = 'USA'

/**------------------------------*/

	-- HEAP OR NORMAL STORAGE IS USED FRO WRITE OPERATION
	-- CLUSTERD INDEX IS USED FOR PK OR SORTING COLUMN -- OLTP
	-- COLUMN STORED INDEX ANALYTICAL QUERIES REDUCED SIZE FO LARGE TABLE -- OLAP
	-- NON-CLUSTERD INDEX FOR FK , FOR JOINS , FILTERS OR WHERE 
	-- FILTERED INDEX TARGET SUBSET OF DATA,  REDUCE THE SIZE OF INDEX 
	-- UNIQUE ENSDURE THAT THERE IS NOT DUPLICATED IS INSERTED







