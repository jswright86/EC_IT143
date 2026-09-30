/***********************************************************************************
*******************************
NAME: Week 3 Question Answers
PURPOSE: Show Answers To Week 3 questions...
MODIFICATION LOG:
Ver Date Author Description
----- ---------- -----------
-------------------------------------------------------------------------------
1.0 09/28/2026 JWRIGHT 1. Built this script for EC IT143
RUNTIME:
Xm Xs
NOTES:
8 Business Questions total, each with their own answers.
***********************************************************************************
*******************************/

--Q1: What are our ten most expensive products based on list price? (Desmond Boafo Donkoh)
Select top 10 Name, ListPrice from Production.Product
order by listPrice Desc;

--Q2: Which products have the highest standard cost? (Desmond Boafo Donkoh)
SELECT TOP 1 ProductLine, StandardCost FROM Production.Product
order by StandardCost DESC;

--Q3: Our management team wants to review product sales performance. Which five products have the highest sales total across all customer orders?(Not specific on revenue or quantity (Wiskendy Simon)

SELECT TOP 5 
	p.ProductID,
	p.Name as ProductName,
	SUM(d.OrderQTY) as TotalQuantity,
	SUM(d.LineTotal) as TotalRevenue
 FROM Sales.SalesOrderDetail d 
 INNER JOIN Production.Product p
 on p.ProductID = d.ProductID
 Group By
	p.ProductID,
	p.Name
Order By
	TotalQuantity DESC;

--Q4: Which sales territories generated the highest sales amounts? How many sales orders did each territory receive? (Joshua Asuquo)

SELECT TOP 10
	s.TerritoryID,
	d.SalesYTD,
	SUM(dd.OrderQTY) as TotalQuantity
FROM Sales.SalesTerritory d
INNER JOIN Sales.SalesOrderHeader s
on s.TerritoryID = d.TerritoryID
INNER JOIN Sales.SalesOrderDetail dd
on dd.SalesOrderID = s.SalesOrderID
Group by 
s.TerritoryID,
d.SalesYTD
Order By d.SalesYTD DESC;

--Q5:Management wants to understand bicycle sales during 2013. Which product categories generated the most revenue each month, and how many units were sold in each category? (Stephen Olaniran)
	--2013 Sales only
	--Category that generated the most revenue each month
	--Quantity of units sold in each category
	--table.column | p.ProductSubcategoryID, pc.Name, sod.OrderQTY, sod.LineTotal, soh.OrderDate, ps.ProductSubcategoryID 

	SELECT 
    MONTH(soh.OrderDate) AS MonthNumber,
    DATENAME(month, soh.OrderDate) AS MonthName,
    pc.Name AS CategoryName,
    SUM(sod.LineTotal) AS MonthlyRevenue,
    SUM(sod.OrderQty) AS MonthlyUnitsSold
FROM Production.Product p
INNER JOIN Production.ProductSubcategory ps
    ON ps.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc
    ON pc.ProductCategoryID = ps.ProductCategoryID
INNER JOIN Sales.SalesOrderDetail sod
    ON sod.ProductID = p.ProductID
INNER JOIN Sales.SalesOrderHeader soh
    ON soh.SalesOrderID = sod.SalesOrderID
WHERE 
    soh.OrderDate >= '2013-01-01' AND soh.OrderDate < '2014-01-01'
    AND pc.Name = 'Bikes' 
GROUP BY 
    MONTH(soh.OrderDate),
    DATENAME(month, soh.OrderDate),
    pc.Name
ORDER BY 
    MonthNumber ASC;

--Q6:Which product subcategories produced the highest sales revenue? Include the total quantity sold and average selling price for each subcategory. (Juridia Romero)
--Top 10 Product subcategories in sales revenue
--Total quantity sold for Each
--AVG Selling Price for Each
SELECT TOP 10
    ps.Name AS Subcategory,
    SUM(sod.LineTotal) AS SalesRevenue,
    SUM(sod.OrderQty) AS QuantitySold,
    AVG(sod.UnitPrice - sod.UnitPriceDiscount) AS AverageSellingPrice
FROM Sales.SalesOrderDetail sod
INNER JOIN Production.Product p
    ON p.ProductID = sod.ProductID
INNER JOIN Production.ProductSubcategory ps
    ON ps.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY
    ps.Name
ORDER BY
    SalesRevenue DESC;

--Q7: Which tables in the AdventureWorks database contain a column named ProductID, and what schema does each table belong to? (Tamunotonye Gogo)

SELECT DISTINCT
       TABLE_SCHEMA,
       TABLE_NAME,
       COLUMN_NAME
      
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = N'ProductID';

--Q8:  Can you find the names of all tables in AdventureWorks that have a column named CustomerID? (Ubong Nelson)
SELECT
       TABLE_SCHEMA,
       TABLE_NAME,
       COLUMN_NAME
      
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = N'CustomerID';
