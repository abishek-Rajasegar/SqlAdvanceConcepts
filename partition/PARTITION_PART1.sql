---------------------------------------------table-partition------------------------------------

	-- It a way of creating partition in a big table so the read write operation will be fast
	-- Partition does not mean that the table is divided into smmall portion
	-- Only a read write partion is created the user has no idea about it.
	-- Because of this the index will be faster as each partition will have a separate index

---------------------------------------------table-partition-function-----------------------------------

	-- Defines the logic how to divide your data into partition 
	-- define a boundry and interval 
	-- two method left or right 
	
---------------------------------------------table-partition-syntax-----------------------------------

	create partition function partitionByYear (DATE)
	as range left for values ('2023-12-31','2024-12-31','2025-12-31')


	select * from sys.partition_functions

---------------------------------------------table-partition-filegroup-----------------------------------

	-- logical container of one or more data files to help organize partitions

	ALTER DATABASE SalesDB ADD FILEGROUP FG_2023;
	  -- ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2023;
	ALTER DATABASE SalesDB ADD FILEGROUP FG_2024;
	ALTER DATABASE SalesDB ADD FILEGROUP FG_2025;
	ALTER DATABASE SalesDB ADD FILEGROUP FG_2026;

	SELECT * FROM SYS.filegroups

---------------------------------------------table-partition-DATA-FILES-----------------------------------

	-- FORMAT USED FOR THE FILES ARE .ndf
	
	ALTER DATABASE SalesDB ADD FILE (
			NAME = P_2023, 
			FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS03\MSSQL\DATA\p_2023.ndf'

	) TO FILEGROUP FG_2023

	ALTER DATABASE SalesDB ADD FILE (
			NAME = P_2024, 
			FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS03\MSSQL\DATA\p_2024.ndf'

	) TO FILEGROUP FG_2024

	
	ALTER DATABASE SalesDB ADD FILE (
			NAME = P_2025, 
			FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS03\MSSQL\DATA\p_2025.ndf'

	) TO FILEGROUP FG_2025

	
	ALTER DATABASE SalesDB ADD FILE (
			NAME = P_2026, 
			FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS03\MSSQL\DATA\p_2026.ndf'

	) TO FILEGROUP FG_2026

----------------------------------------------------------------------------------------------------


	select 
		fg.name, 
		mf.name,
		mf.physical_name,
		mf.size/128 as size
	from sys.filegroups fg
	join sys.master_files mf on fg.data_space_id = mf.data_space_id
	where mf.database_id =DB_ID('SalesDB')

--------------------------------------------partition-scheme--------------------------------------------------------

	CREATE PARTITION SCHEME SchemePartitionByYear
	as partition partitionByYear
	to (FG_2023,FG_2024,FG_2025,FG_2026)

-------------------------------------------create-partition-table--------------------------------------------------------

	CREATE TABLE Sales.Order_partition
	(
		OrderID INT,
		OrderDate DATE,
		Sales INT
	) ON SchemePartitionByYear (OrderDate)


-------------------------------------------Insert-into-partition-table---------------------------------------------

	INSERT INTO Sales.Order_partition VALUES (1,'2023-05-15' ,100)
	INSERT INTO Sales.Order_partition VALUES (1,'2024-05-15' ,100)
	INSERT INTO Sales.Order_partition VALUES (1,'2025-05-15' ,100)
	INSERT INTO Sales.Order_partition VALUES (1,'2026-05-15' ,100)
	
	select * from Sales.Order_partition

	-- to check if the data is inserted into the correct partition 
	select
		p.partition_number,
		f.name,
		p.rows
	from sys.partitions p 
	join sys.destination_data_spaces dds on p.partition_number = dds.destination_id
	join sys.filegroups f on dds.data_space_id = f.data_space_id
	where OBJECT_NAME(p.object_id) = 'Order_partition';

-------------------------------------------------------------------------------------------------------






