IF OBJECT_ID('Sales.vMonthly_Summary', 'V') IS NOT NULL
    DROP VIEW Sales.vMonthly_Summary;
GO
CREATE VIEW Sales.vMonthly_Summary AS
	(
		select
			datetrunc(MONTH , OrderDate) as OrderMonth,
			sum(Sales) as Total_Sales,
			count(OrderID) as TotalOrders
		from Sales.Orders
		group by datetrunc(MONTH , OrderDate)


	);

IF OBJECT_ID('Sales.vOrder_Details', 'V') IS NOT NULL
    DROP VIEW Sales.vOrder_Details;
GO
CREATE VIEW Sales.vOrder_Details AS
	(
		select 
			o.OrderID,				
			o.CustomerID,
			o.ProductID,
			o.SalesPersonID,
			o.OrderDate,
			o.Sales,
			o.Quantity,
			coalesce(c.FirstName,'')+' '+coalesce(c.LastName,'') as Customer,
			c.Country,
			c.Score,
			p.Product, 
			p.Price, 
			p.Category,
			coalesce(e.FirstName,'')+' '+coalesce(e.LastName,'') employee, 
			e.Gender, 
			e.Salary
		from Sales.Orders o
		left join Sales.Customers c on o.CustomerID = c.CustomerID
		left join Sales.Products p on p.ProductID = o.ProductID
		left join Sales.Employees e on e.EmployeeID = o.SalesPersonID
	);

IF OBJECT_ID('Sales.vEU_Order_Details', 'V') IS NOT NULL
    DROP VIEW Sales.vEU_Order_Details;
GO
CREATE VIEW Sales.vEU_Order_Details AS
	(
		select 
			o.OrderID,				
			o.CustomerID,
			o.ProductID,
			o.SalesPersonID,
			o.OrderDate,
			o.Sales,
			o.Quantity,
			coalesce(c.FirstName,'')+' '+coalesce(c.LastName,'') as Customer,
			c.Country,
			c.Score,
			p.Product, 
			p.Price, 
			p.Category,
			coalesce(e.FirstName,'')+' '+coalesce(e.LastName,'') employee, 
			e.Gender, 
			e.Salary
		from Sales.Orders o
		left join Sales.Customers c on o.CustomerID = c.CustomerID
		left join Sales.Products p on p.ProductID = o.ProductID
		left join Sales.Employees e on e.EmployeeID = o.SalesPersonID
		WHERE C.Country != 'USA'
	);

