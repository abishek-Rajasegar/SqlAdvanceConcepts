-----------------------------------------------------Triggers----------------------------------------------

	-- Triggers are event that run after a specific event of a table
	-- Event like insert, update or delete
	-- DML triggers --- 
		-- after -- after the operation is completed 
		-- instead of -- it will run during the event
	-- DDl triggers
	-- Loggon triggers

---------------------------------------------Syntax--------------------------------------------------------

	-- CREATE TRIGGER Trigger_Name ON TableName
	-- [AFTER | INSTEAD OF] INSERT , UPDATE , END
	-- BEGIN
	-- END
---------------------------------------------Audit-Logs----------------------------------------------------

	-- audit table creation
	CREATE TABLE Sales.EmployeeLogs(
		LogID INT IDENTITY(1,1) PRIMARY KEY,
		EmployeeID INT,
		LogMessage VARCHAR(225),
		LogDate DATETIME
	)

	-- Trigger creation
	CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
	AFTER INSERT
	AS
	BEGIN
		INSERT INTO Sales.EmployeeLogs(EmployeeID , LogMessage , LogDate)
		SELECT
			EmployeeID,
			'New Employee Added =' + cast(EmployeeID as VARCHAR),
			GETDATE()
		FROM INSERTED
	END

	-- Trigger testing
	INSERT INTO Sales.Employees VALUES(6,'Mac','John','IT','1982-12-10','M',100000, NULL)
	
	select * from Sales.Employees

	select * from Sales.EmployeeLogs










