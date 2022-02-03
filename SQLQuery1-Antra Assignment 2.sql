USE AdventureWorks2019
GO
/* FOR TESTING

use AdventureWorks2019 EXEC sp_changedbowner 'sa'

SELECT *
FROM Production.Product P

SELECT P.ProductSubcategoryID
FROM Production.Product P
WHERE P.ProductSubcategoryID IS NOT NULL

*/
--1
SELECT COUNT(*)
FROM Production.Product P

--2
/*SELECT COUNT(*)
FROM Production.Product P JOIN Production.ProductSubcategory S ON P.ProductSubcategoryID = S.ProductSubcategoryID
*/
SELECT COUNT(*)
FROM Production.Product P
WHERE P.ProductSubcategoryID IS NOT NULL

--3
SELECT P.ProductSubcategoryID, COUNT(P.ProductSubcategoryID) AS TotalProducts
FROM Production.Product P
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID

--4
SELECT COUNT(*)
FROM Production.Product P
WHERE P.ProductSubcategoryID IS NULL

--5
SELECT P.ProductID, SUM(P.Quantity) AS QuantitySum
FROM Production.ProductInventory P
GROUP BY P.ProductID

--6
SELECT P.ProductID, SUM(P.Quantity) AS TheSum
FROM Production.ProductInventory P
WHERE P.LocationID = 40
GROUP BY P.ProductID
HAVING SUM(P.Quantity) < 100

--7
/*
SELECT * 
FROM Production.ProductInventory P
WHERE P.LocationID = 40 
*/
SELECT P.Shelf, P.ProductID, SUM(P.Quantity) AS TheSum
FROM Production.ProductInventory P
WHERE P.LocationID = 40 --AND P.Shelf <> 'N/A'
GROUP BY P.Shelf, P.ProductID
HAVING SUM(P.Quantity) < 100

--8
SELECT AVG(P.Quantity) AS AverageQuantity
FROM Production.ProductInventory P
WHERE P.LocationID = 10

--9
SELECT P.ProductID, P.Shelf, AVG(P.Quantity) AS TheAvg
FROM Production.ProductInventory P
GROUP BY P.ProductID, P.Shelf

--10
SELECT P.ProductID, P.Shelf, AVG(P.Quantity) AS TheAvg
FROM Production.ProductInventory P
WHERE P.Shelf <> 'N/A'
GROUP BY P.ProductID, P.Shelf

--11
SELECT P.Color, P.Class, COUNT(*) AS TheCount, AVG(P.ListPrice) AS AvgPrice
FROM Production.Product P
WHERE P.Color IS NOT NULL AND P.Class IS NOT NULL
GROUP BY P.Color, P.Class

--12
SELECT Cr.Name AS Country, Sp.Name AS Province
FROM Person.CountryRegion Cr JOIN Person.StateProvince Sp ON Cr.CountryRegionCode = Sp.CountryRegionCode

--13
SELECT Cr.Name AS Country, Sp.Name AS Province
FROM Person.CountryRegion Cr JOIN Person.StateProvince Sp ON Cr.CountryRegionCode = Sp.CountryRegionCode
WHERE CR.Name IN ('Germany', 'Canada')

USE Northwind
GO

--14
SELECT P.ProductName , O.OrderDate
FROM Orders O JOIN [Order Details] Od ON O.OrderID = OD.OrderID JOIN Products P ON P.ProductID = OD.ProductID
WHERE O.OrderDate >= '1997-01-01 00:00:00.000'

--15
Select TOP 5 O.ShipPostalCode, SUM(OD.Quantity) SumProductsSold
FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.ShipPostalCode IS NOT NULL
GROUP BY O.ShipPostalCode
ORDER BY SumProductsSold DESC

--16
Select TOP 5 O.ShipPostalCode, SUM(OD.Quantity) SumProductsSold
FROM Orders O JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.ShipPostalCode IS NOT NULL AND O.OrderDate >= '1997-01-01 00:00:00.000'
GROUP BY O.ShipPostalCode
ORDER BY SumProductsSold DESC

--17
--IS a join needed here? A bit vague
SELECT C.City, COUNT(DISTINCT C.CustomerID) AS NumberOfCustomers
FROM Customers C
GROUP BY C.City

-- Joining Customers and Orders
SELECT O.ShipCity, COUNT(DISTINCT C.CustomerID) AS NumberOfCustomers
FROM Orders O JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY O.ShipCity

--18
SELECT C.City, COUNT(C.CustomerID) AS NumberOfCustomers
FROM Customers C
GROUP BY C.City
HAVING COUNT(C.CustomerID) > 2

--19
SELECT DISTINCT C.ContactName
FROM Orders O JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE O.OrderDate > '1998-01-01 00:00:00.000'

--20
SELECT C.ContactName, O.OrderDate
FROM Orders O JOIN Customers C ON O.CustomerID = C.CustomerID
ORDER BY O.OrderDate DESC

--21
SELECT C.ContactName, COUNT(OD.ProductID) AS ProductCount
FROM [Order Details] OD JOIN Orders O ON OD.OrderID = O.OrderID JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.ContactName
ORDER BY ProductCount DESC

--22
SELECT C.CustomerID, COUNT(OD.ProductID) AS ProductCount
FROM [Order Details] OD JOIN Orders O ON OD.OrderID = O.OrderID JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID
HAVING COUNT(OD.ProductID) > 100
ORDER BY ProductCount DESC

--23
/*
SELECT *
FROM Shippers
*/
SELECT DISTINCT Sup.CompanyName AS 'Supplier Company Name', Ship.CompanyName AS 'Shipping Company Name'
FROM Suppliers Sup JOIN Products P ON Sup.SupplierID = P.SupplierID JOIN [Order Details] OD ON  P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID JOIN Shippers Ship ON O.ShipVia = Ship.ShipperID
ORDER BY Sup.CompanyName

--24
SELECT O.OrderDate, P.ProductName
FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID

--25
SELECT E1.FirstName, E2.FirstName
FROM Employees E1 JOIN Employees E2 ON E1.Title = E2.Title
WHERE E1.FirstName <> E2.FirstName

--26
SELECT E2.FirstName + ' ' + E2.LastName AS Managers
FROM Employees E1 JOIN Employees E2 ON E1.ReportsTo = E2.EmployeeID
GROUP BY E2.FirstName, E2.LastName
HAVING COUNT(E2.EmployeeID) > 2

--27
SELECT DISTINCT O.ShipCity
FROM Suppliers Sup JOIN Products P ON Sup.SupplierID = P.SupplierID JOIN [Order Details] OD ON  P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID JOIN Customers C ON C.CustomerID = O.CustomerID
ORDER BY O.ShipCity
