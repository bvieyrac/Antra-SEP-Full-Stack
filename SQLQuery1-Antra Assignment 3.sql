USE Northwind
GO

/*
SELECT City from Employees
SELECT City from Customers
*/

--1
SELECT E.City
FROM Employees E
WHERE E.City IN
(SELECT C.City
FROM Customers C)

--2
SELECT DISTINCT C.City
FROM Customers C
WHERE C.City NOT IN
(SELECT E.City
FROM Employees E)

SELECT DISTINCT C.City
FROM Customers C LEFT JOIN Employees E ON C.City = E.City

--3
SELECT P.ProductName, SUM(OD.Quantity) AS 'Total Ordered'
FROM Products P JOIN [Order Details] OD on P.ProductID = OD.ProductID
GROUP BY P.ProductName

--4
SELECT C.City, SUM(P.ProductID) AS TotalProducts
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID JOIN [Order Details] OD ON OD.OrderID = O.OrderID JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY C.City

--5


--6
SELECT C.City, COUNT(DISTINCT P.ProductName) AS TotalProducts
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID JOIN [Order Details] OD ON OD.OrderID = O.OrderID JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY C.City
HAVING COUNT(DISTINCT P.ProductName) > 2


--7

--8
SELECT TOP 5 P.ProductName, AVG(P.UnitPrice) AvgPrice, C.City , SUM(OD.Quantity) TotalQuantity
FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID JOIN [Order Details] OD ON OD.OrderID = O.OrderID JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY P.ProductName, C.City, OD.Quantity
ORDER BY TotalQuantity DESC

--9
SELECT E.City
FROM Employees E
WHERE E.City NOT IN(SELECT O.ShipCity
FROM Orders O)

--10

--11
DISTINCT



