---------------------------------------------stored-procedure---------------------------------

	-- stored procudure is a collection of query 
	-- we use this when DB operation should happen one after one manner
	-- the regular tasks can be made as stored procedure and it can be execute when required
	-- we can use loops , control flow , paramaters , error handling 
	-- stored proceduer are pre complied

---------------------------------------------stored-syntax------------------------------------

	-- sp definition
		
		-- CREATE PROCEDURE [Prodecure_name] as
			-- BEGIN

			-- END

	-- sp execution
		-- EXEC [Prodecure_name]


	CREATE PROCEDURE procCustomerDetails as
	BEGIN
		SELECT 
			COUNT(*) total_customers,
			AVG(Score) avg_score
		FROM Sales.Customers
		WHERE Country = 'USA'
	END

	EXEC procCustomerDetails

---------------------------------------------stored-procdure-parameters------------------------------------

	ALTER PROCEDURE procCustomerDetails @Country NVARCHAR(50) as
	BEGIN
		SELECT 
			COUNT(*) total_customers,
			AVG(Score) avg_score
		FROM Sales.Customers
		WHERE Country = @Country
	END

	EXEC procCustomerDetails @Country = 'USA'

	-- drop procedure [Prodecure_name] for deleting 
---------------------------------------------stored-procdure-default-value------------------------------------
	
	ALTER PROCEDURE procCustomerDetails @Country NVARCHAR(50) = 'USA' as
	BEGIN
		SELECT 
			COUNT(*) total_customers,
			AVG(Score) avg_score
		FROM Sales.Customers
		WHERE Country = @Country
	END

	EXEC procCustomerDetails

---------------------------------------------stored-procdure-multiple-query------------------------------------
 
	ALTER PROCEDURE procCustomerDetails @Country NVARCHAR(50) = 'USA' as
		BEGIN

			-- query1: customer score details
			SELECT 
				COUNT(*) total_customers,
				AVG(Score) avg_score
			FROM Sales.Customers
			WHERE Country = @Country;

			--query2: customer sales details

			SELECT 
				COUNT(OrderID) TotalOrders,
				SUM(Sales) TotalSales
			FROM Sales.Orders O
			JOIN Sales.Customers C ON O.CustomerID = C.CustomerID
			WHERE Country =  @Country;

		END

	EXEC procCustomerDetails @Country = 'Germany'
	
---------------------------------------------stored-procdure-Variables------------------------------------

	-- var is not like parameter
	-- it is only inside proceure
	-- steps for creating var
		-- declare a variable

	ALTER PROCEDURE procCustomerDetails @Country NVARCHAR(50) = 'USA' as
		BEGIN
			-- variables
			DECLARE @TotalCustomers INT, @AvgScore FLOAT;

			-- query1: customer score details
			SELECT 
				@TotalCustomers = COUNT(*),
				@AvgScore = AVG(Score)
			FROM Sales.Customers
			WHERE Country = @Country;

			-- printing the values
			PRINT 'Total Customer from '+@Country+':' + cast(@TotalCustomers as VARCHAR);
			PRINT 'Avg Score from '+@Country+':' + cast(@AvgScore as VARCHAR);
			
			--query2: customer sales details
			SELECT 
				COUNT(OrderID) TotalOrders,
				SUM(Sales) TotalSales
			FROM Sales.Orders O
			JOIN Sales.Customers C ON O.CustomerID = C.CustomerID
			WHERE Country =  @Country;

		END

	EXEC procCustomerDetails @Country = 'Germany'


---------------------------------------------stored-procdure-control-flow-----------------------------------
	
	ALTER PROCEDURE procCustomerDetails @Country NVARCHAR(50) = 'USA' as
		BEGIN
			-- variables
			DECLARE @TotalCustomers INT, @AvgScore FLOAT;

			-- preparing data and cleaning the data (handling null)

			IF EXISTS(SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
				BEGIN
					PRINT ('Updating NULL Scores to 0')
					UPDATE Sales.Customers
					Set Score = 0
					WHERE Score is NULL AND Country = @Country;
				END

			ELSE
				BEGIN
					Print('No Null in the score')
				END;

			-- query1: customer score details
			SELECT 
				@TotalCustomers = COUNT(*),
				@AvgScore = AVG(Score)
			FROM Sales.Customers
			WHERE Country = @Country;

			-- printing the values
			PRINT 'Total Customer from '+@Country+':' + cast(@TotalCustomers as VARCHAR);
			PRINT 'Avg Score from '+@Country+':' + cast(@AvgScore as VARCHAR);
			
			--query2: customer sales details
			SELECT 
				COUNT(OrderID) TotalOrders,
				SUM(Sales) TotalSales
			FROM Sales.Orders O
			JOIN Sales.Customers C ON O.CustomerID = C.CustomerID
			WHERE Country =  @Country;

		END

	EXEC procCustomerDetails @Country = 'Germany'

---------------------------------------------stored-procdure-error-handling-----------------------------------
	
	-- BEGIN TRY ----- END TRY / BEGIN CATCH ----- END CATCH

	ALTER PROCEDURE procCustomerDetails @Country NVARCHAR(50) = 'USA' as
		BEGIN
			BEGIN TRY
				DECLARE @TotalCustomers INT, @AvgScore FLOAT; -- variables 

				-- preparing data and cleaning the data (handling null)
				IF EXISTS(SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
					BEGIN
						PRINT ('Updating NULL Scores to 0')
						UPDATE Sales.Customers
						Set Score = 0
						WHERE Score is NULL AND Country = @Country;
					END
				ELSE
					BEGIN
						Print('No Null in the score')
					END;

				-- query1: customer score details
				SELECT 
					@TotalCustomers = COUNT(*),
					@AvgScore = AVG(Score)
				FROM Sales.Customers
				WHERE Country = @Country;

				-- printing the values
				PRINT 'Total Customer from '+@Country+':' + cast(@TotalCustomers as VARCHAR);
				PRINT 'Avg Score from '+@Country+':' + cast(@AvgScore as VARCHAR);
			
				--query2: customer sales details
				SELECT 
					COUNT(OrderID) TotalOrders,
					SUM(Sales) TotalSales
					-- 1/0  -- error to test try and catch
				FROM Sales.Orders O
				JOIN Sales.Customers C ON O.CustomerID = C.CustomerID
				WHERE Country =  @Country;

			END TRY
			BEGIN CATCH
				PRINT('An Error Occured.')
				PRINT('Error Message.'+ERROR_MESSAGE())
				PRINT('Error Message.'+CAST(ERROR_NUMBER() AS VARCHAR))
				PRINT('Error Message.'+CAST(ERROR_LINE() AS VARCHAR))
				PRINT('Error Message.'+CAST(ERROR_PROCEDURE() AS VARCHAR))
			END CATCH
		END

		EXEC procCustomerDetails @Country = 'Germany'

































































