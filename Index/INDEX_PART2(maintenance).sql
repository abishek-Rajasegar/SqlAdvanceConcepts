--------------------------------------Index-Manage-and-maintain-----------------------------------

	-- Index if not used storage is wasted and pefroamace is not obtained
	-- This gives info about our index:
		sp_helpindex 'Sales.Customers_duplicate'
		
	-- Details of all the index
		select 
			* 
		from sys.indexes idx
		join sys.tables tbl on idx.object_id = tbl.object_id -- give index for table abailable in the db


	-- how to usage of Index
		
		select 
			tbl.name,
			idx.name,
			idx.type_desc,
			idx.is_primary_key,
			idx.is_unique,
			idx.is_disabled,
			s.user_seeks,
			s.user_lookups,
			s.user_lookups,
			s.user_updates,
			s.last_user_seek,
			s.last_user_scan
		from sys.indexes idx
		join sys.tables tbl on idx.object_id = tbl.object_id -- give index for table abailable in the db
		left join sys.dm_db_index_usage_stats s on s.object_id = idx.object_id and s.index_id = idx.index_id

----------------------------------------Index-about-missing-index---------------------------------------

	SELECT * FROM SYS.dm_db_missing_index_details














