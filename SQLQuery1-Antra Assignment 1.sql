USE AdventureWorks2019
GO

--1.
Select P.ProductID, P.Name, P.Color, P.ListPrice
From Production.Product as P

--2
Select P.ProductID, P.Name, P.Color, P.ListPrice
From Production.Product as P
Where P.ListPrice <> 0

--3
Select P.ProductID, P.Name, P.Color, P.ListPrice
From Production.Product as P
Where P.Color IS NULL

--4
Select P.ProductID, P.Name, P.Color, P.ListPrice
From Production.Product as P
Where P.Color IS NOT NULL

--5
Select P.ProductID, P.Name, P.Color, P.ListPrice
From Production.Product as P
Where P.Color IS NOT NULL AND P.ListPrice > 0

--6
Select P.Name + ' ' + P.Color
From Production.Product as P
Where P.Color IS NOT NULL

--7
Select TOP 6 'NAME: ' + P.Name + ' -- COLOR: ' + P.Color
From Production.Product as P
Where P.Color IS NOT NULL

--8
Select P.ProductID, P.Name
From Production.Product as P
Where P.ProductID BETWEEN 400 AND 500

--9
Select P.ProductID, P.Name, P.Color
From Production.Product as P
Where P.Color IN ('Black', 'Blue')

--10
-- Can use Select *, but too much info
Select P.ProductID, P.Name, P.Color
From Production.Product as P
Where P.Name LIKE ('S%')

--11
Select P.Name, P.ListPrice
From Production.Product as P
Where P.Name LIKE ('S%')
ORDER BY P.Name

--12
Select P.Name, P.ListPrice
From Production.Product as P
Where P.Name LIKE ('S%') OR P.Name LIKE ('A%')
ORDER BY P.Name

--13
Select P.Name
From Production.Product as P
Where P.Name LIKE ('SPO[^k]%')
ORDER BY P.Name

--14
Select DISTINCT P.Color
From Production.Product as P
ORDER BY P.Color DESC

--15
Select DISTINCT P.ProductSubcategoryID, P.Color
From Production.Product as P
Where P.ProductSubcategoryID IS NOT NULL AND P.Color IS NOT NULL
--ORDER BY P.ProductSubcategoryID
