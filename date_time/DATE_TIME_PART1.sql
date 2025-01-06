/**------------------------------DATE-TIME-FUNCTIONS---------------------------*/
/**----------------------------------DATE-TIME---------------------------------*/

  	-- GETDATE() --> CURRENT DATE AND TIME WILL BE RETURNED

/**------------EXAMPLE------------*/

	SELECT 
		GETDATE() TODAYS_DATE_TIME,
		DATEPART(WEEKDAY ,'2025-08-20') WEEKDAY,
		DATEPART(HOUR ,'2025-08-20') HOUR,
		DATEPART(QUARTER ,'2025-08-20') QUARTER,
		DATEPART(DAYOFYEAR ,'2025-08-20') QUARTER,
		DATENAME(MONTH ,'2025-08-20') MONTH,
		DATENAME(WEEKDAY ,'2025-08-20') WEEKDAY,

		DATETRUNC(YEAR ,'2025-08-20') 

/**---------*/

/**----------------------------------PART-EXTRACTION-TIME---------------------------------*/
	SELECT 
		GETDATE() TODAYS_DATE_TIME,
		
		DATEPART(WEEKDAY ,'2025-08-20') WEEKDAY,
		DATEPART(HOUR ,'2025-08-20') HOUR,
		DATEPART(QUARTER ,'2025-08-20') QUARTER,
		DATEPART(DAYOFYEAR ,'2025-08-20') QUARTER,
		
		DATENAME(MONTH ,'2025-08-20') MONTH,
		DATENAME(WEEKDAY ,'2025-08-20') WEEKDAY,

		DATETRUNC(YEAR ,'2025-08-20') DATE_TRUNC,
		EOMONTH('2025-08-20') END_OF_MONTH
	
	-- EX DATE: '2025-08-20'
		-- DAY --> 20
		-- MONTH --> 08
		-- YEAR --> 2025
		
		-- DATEPART --> INT VALUES
			--> TO EXTRACT WEEK , QUATER AND MORE 
			--> DATEPART(WEEKDAY ,'2025-08-20') WEEKDAY,
			-->	DATEPART(HOUR ,'2025-08-20') HOUR,
			-->	DATEPART(QUARTER ,'2025-08-20') QUARTER,
			-->	DATEPART(DAYOFYEAR ,'2025-08-20') QUARTER

		-- DATENAME --> STRING VALUES
			--> IT GIVE THE NAME OF THE DATE PART  
			--> DATENAME(MONTH ,'2025-08-20') MONTH -- August
			--> DATENAME(WEEKDAY ,'2025-08-20') WEEKDAY -- Wednesday
		
		-- DATETRUNC --> TRUNCATES THE DATE TO SPECIFIC PARTS 
			--> RESET THE VALUES AFTER A PART 
			--> DATETRUNC(YEAR ,'2025-08-20') --> 2025-01-01 00:00:00.0000000
			--> DATETRUNC(MONTH ,'2025-08-20') --> 2025-08-01 00:00:00.0000000
			
		-- EOMONTH -> MAKE THE MAKE TO THE LAST DATE OF MONTH 
			--> EOMONTH('2025-08-20') --> 2025-08-31

/**----------------------------------PART-EXTRACTION-TIME-DATA-AGG-------------------------------*/		
	
	SELECT
		YEAR(ORDERDATE) YEAR,
		COUNT(*) NO_OF_ORDERS
	FROM SALES.Orders
	GROUP BY YEAR(ORDERDATE)

/**-------*/
	
	SELECT
		DATENAME(MONTH,ORDERDATE) MONTH,
		COUNT(*) NO_OF_ORDERS
	FROM SALES.Orders
	GROUP BY DATENAME(MONTH, ORDERDATE)

/**-------*/
	
	SELECT
		*
	FROM SALES.Orders
	WHERE DATEPART(MONTH, ORDERDATE) = 2
	
/**----------------------------------FORMAT-CASTING-DTATETIME---------------------------------*/
	
	-- FORMAT  -- changing one format to another

		-- YEAR -> YYYY
		-- MONTH -> MM
		-- DAY -> dd
		-- HOUR -> HH
		-- MIN -> mm
		-- SEC -> ss

	-- syntax:
		-- FORMAT(VALUE, FORMAT, CULTURE)
			-- VALUE - VALUE TO FORMAT
			-- FORMAT - FORMAT TYPE
			-- CULTURE - REGION SPECIFIC

	--> YYYY-MM-dd HH:mm:ss
	--> INTERNATIONAL -> YYYY-MM-dd --> SQL STANDARD
	--> USA -> MM-dd-YYYY 
	--> EUROPEAN -> dd-MM-YYYY

/**---example-------*/


	SELECT 
	FORMAT(GETDATE(), 'dd' ) day_number,
	FORMAT(GETDATE(), 'ddd' ) day_name,
	FORMAT(GETDATE(), 'dddd' ) day_name_full,
	FORMAT(GETDATE(), 'MM' ) day_number,
	FORMAT(GETDATE(), 'MMM' ) day_name,
	FORMAT(GETDATE(), 'MMMM' ) day_name_full,
	FORMAT(GETDATE(), 'MM-dd-YYYY' ) day_name_full,
	FORMAT(GETDATE(), 'D','fr-FR' ) day_name_full_FR
	

/**----custom-format-example-------*/

	select
		OrderID,
		CreationTime,
		'Day '+Format(CreationTime , 'ddd MMM Q')+datename(QUARTER,CreationTime)+Format(CreationTime , ' yyyy hh:mm:ss tt')
	from Sales.Orders	

/**----format-agg--------*/
	
	select
		format(OrderDate,'MMM yy') orderDate,
		count(*)
	from Sales.Orders
	group by format(OrderDate,'MMM yy')

/**-----------------------------CONVERT---------------------------------*/

	-- CONVERT
		--> this will change the datattime values data type and also format it
		--> 

	-- SYNTAX:
		-- CONVERT(DATA_TYPE , VALUE , STYLE)

/**----custom-convert-example-------*/

	SELECT 
		CONVERT(INT, '1234') STRING_TO_INT,
		CONVERT(DATE, '2025-08-02') STRING_TO_DATE,
		CONVERT(DATE, CreationTime) STRING_TO_DATE,
		CONVERT(VARCHAR, CreationTime, 32) TO_USE_STANDARD,
		CONVERT(VARCHAR, CreationTime, 34) TO_USE_STANDARD
	FROM Sales.Orders

/**-----------------------------CONVERT---------------------------------*/
	
	-- CAST
		--> change the data type of one to another
	
	-- cast(columnName as dataType)

/**----custom-cast-example-------*/

	select 
		cast('123' as int) str_to_int,
		cast(123 as char) int_to_str,
		cast('2025-01-02' as DATE) str_to_date

/**----summary-------*/
		
		-- cast 
			--> used for any to any type
			--> we cannot format values using cast function

		-- convert
			--> any type to any type
			--> formats only the date time number cannot be formatted

		-- Format 
			--> any type to any type 
			--> formats date time and numbers

/**-------------------------------CALCULATION-DATETIME-----------------------*/
	
/**----------------------------------DATEADD()-------------------------------*/

	-- DATEADD :	
		-- add/sub specific time interval to the date 
	
	-- SYNATX:
		-- DATEADD(PART,INTERVAL,DATE)
		-- PART -- WHAT YOU WANT TO CHANGE YEAR OR MONTH OR DATE 
		-- INTERVAL -- NUMBER TO ADD OR SUB 
		-- DATE -- COLUMN OR STATIC DATE

/**----dateadd-example-------*/

	select
		getdate() [current_date],
		dateadd(year,-2,getdate()) [2_years_before_current_date],
		dateadd(month,-2,getdate()) [2_months_before_current_date],
		dateadd(year,2,getdate()) [2_years_from_current_date],
		dateadd(day,10,getdate()) [10_days_from_current_date]

/**------*/

/**----------------------------------DATEDIFF()-------------------------------*/

	-- DATEDIFF
		-- diff of date between two dates
	
	-- SYNATX:
		-- DATEADD(PART,START_DATE,END_DATE)
		-- PART -- WHAT YOU WANT TO CHANGE YEAR OR MONTH OR DATE
		-- START_DATE or min date in the two dates
		-- END_DATE or max date in the two dates

/**----datediff-example-age------*/
	
	select 
		* ,
		DATEDIFF(year,BirthDate,GETDATE()) as age
	from Sales.Employees

/**------*/


/**----datediff-example-avg-shipping-duration----*/
	
	select 
		* ,
		DATEDIFF(year,BirthDate,GETDATE()) as age
	from Sales.Employees

/**------*/

/**----datediff-example-avg-shipping-duration----*/
	
	select 
		Datename(month,OrderDate) as month,
		avg(DATEDIFF(DAY,OrderDate,ShipDate)) delivery_days
	from Sales.Orders
	group by Datename(month,OrderDate)

/**------*/

/**----datediff-example--days-between-eac-order-prev-order----*/
	
	select 
		OrderID,
		OrderDate,
		lag(OrderDate) OVER(order by OrderDate) prev_order_date,
		datediff(day ,lag(OrderDate) OVER(order by OrderDate)  , OrderDate) diff_between_ordes
	from Sales.Orders
	
/**------*/

/**----------------------------------VALIDATION-DATETIME---------------------------------*/

	-- ISDATE:
		-- checks if a value is a date or note return 1 or 0
	
	-- SYNTAX:
		-- ISDATE(value)
	
/**----isdate-example---------*/
	

	select 
		isdate('123'),
		isdate('2024-10-01'),
		isdate('20-10-2024'),
		isdate('2024')

/**------*/

/**---------*/














