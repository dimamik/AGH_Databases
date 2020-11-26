/* Cw_1 1/5 */

/* Zad 1 -  Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki dostarczała firma United Package*/
-- use Northwind
-- select distinct c.CompanyName,c.Phone,c.CustomerID
-- from Customers as c
-- where exists
--     (
--         select *
--         from Orders as o 
--         join Shippers as s
--             on s.ShipperID=o.ShipVia
--         where YEAR(o.ShippedDate)=1997 and s.CompanyName='United Package' and o.CustomerID = c.CustomerID
--     )
 
-- use Northwind
-- SELECT DISTINCT ​Customers.​CompanyName​, ​Customers.​Phone 
-- FROM ​Customers 
-- INNER JOIN ​Orders O ​on ​Customers.​CustomerID ​= O.​CustomerID 
-- INNER JOIN ​Shippers ​S on ​O.​ShipVia ​= ​S​.​ShipperID 
-- WHERE ​year​(​ShippedDate​) = ​1997 ​AND S​.​CompanyName ​= ​'United Package'​; ​--a 

/* Zad 2 -  Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii Confections.. */
-- use Northwind
-- select distinct c.CompanyName, c.Phone
-- from Customers as c
-- where exists(
--     select *
--     from Orders as o
--         join [Order Details] as od
--         on od.OrderID=o.OrderID
--         join Products as p
--         on od.ProductID = p.ProductID
--         join Categories as cat
--         on cat.CategoryID = p.CategoryID
--         where (
--             cat.CategoryName = 'Confections' and
--             c.CustomerID = o.CustomerID
--         )
-- )

-- SELECT DISTINCT ​C.​CompanyName​, ​C.​Phone 
-- FROM ​Customers ​AS ​C 
-- INNER JOIN ​Orders O ​on ​C.​CustomerID ​= O.​CustomerID 
-- INNER JOIN ​[Order Details] OD ​on ​OD.​OrderID ​= O.​OrderID 
-- INNER JOIN ​Products P ​on ​OD.​ProductID ​= P.​ProductID 
-- INNER JOIN ​Categories C2 ​on ​P.​CategoryID ​= C2.​CategoryID 
-- WHERE ​C2.​CategoryName ​= ​'Confections'​; ​--2.1a 

/* Zad 3 - Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii Confections.*/
-- use Northwind
-- select distinct c.CompanyName, c.Phone
-- from Customers as c
-- where not exists(
--     select *
--     from Orders as o
--         join [Order Details] as od
--         on od.OrderID=o.OrderID
--         join Products as p
--         on od.ProductID = p.ProductID
--         join Categories as cat
--         on cat.CategoryID = p.CategoryID
--         where (
--             cat.CategoryName = 'Confections' and
--             c.CustomerID = o.CustomerID
--         )
-- )

-- SELECT DISTINCT ​C.​CompanyName​, ​C.​Phone 
-- FROM ​Customers ​AS ​C 
-- WHERE NOT ​EXISTS ​(​SELECT ​O.​CustomerID ​FROM ​Orders O ​WHERE 
-- O.​CustomerID ​= C.​CustomerID ​AND 
--    ​EXISTS​(​SELECT D​.​OrderID ​FROM ​[Order Details] ​D WHERE D​.​OrderID ​= 
-- O.​OrderID ​AND 
--    ​EXISTS​(​SELECT ​P.​ProductID ​FROM ​Products P ​WHERE ​P.​ProductID ​= 
-- D​.​ProductID ​AND 
--    ​EXISTS​(​SELECT ​C2.​CategoryID ​FROM ​Categories C2 ​WHERE ​C2.​CategoryID ​= 
-- P.​CategoryID ​AND ​C2.​CategoryName ​= ​'Confections'​))))​; ​--2.2b 

/* Cw 2 2/5 */
/* Zad 1 - Dla każdego produktu podaj maksymalną liczbę zamówionych jednostek */
-- select p.ProductName,(
--     select top 1 MAX(od.Quantity)
--     from [Order Details] as od
--     where od.ProductID = p.ProductID
--     group by od.ProductID
--     order by MAX(od.Quantity) desc
    
-- )
-- from Products as p
-- order by ProductID

-- SELECT ​P.​ProductName​, ​( 
--    ​SELECT ​MAX​(OD.​Quantity​) 
--    ​FROM ​[Order Details] OD 
--    ​WHERE ​OD.​ProductID ​= P.​ProductID 
--    ​) ​AS ​'makslzj' 
-- FROM ​Products P​; ​--3.1b 

/* Zad 2 -  Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu*/
-- SELECT p.ProductName,p.UnitPrice,(
--     select AVG(pp.UnitPrice) 
--     from Products as pp
-- ) as average
-- from Products as p
-- where (
--     p.UnitPrice < (
--         select AVG(pp.UnitPrice) 
--         from Products as pp
--     )
-- )

/* ZADANIE DODATKOWE! -> BEZ PODZAPYTAŃ ZROBIĆ TE SAME ZADANIA */
-- TODO
-- SELECT ​P.​ProductName​, ​P.​UnitPrice 
-- FROM ​Products P 
-- WHERE ​P.​UnitPrice ​< ( 
--    ​SELECT ​AVG​(​UnitPrice​) ​FROM ​Products 
--    )​; ​--3.2 

/* Zad 3 - Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu danej kategorii */
-- SELECT p.ProductName,p.UnitPrice
-- from Products as p
-- where (
--     p.UnitPrice < (
--         select AVG(pr.UnitPrice)
--         from Products as pr
--         where p.CategoryID = pr.CategoryID
--         -- GROUP by CategoryID useless but shows 
--     )
-- )

-- SELECT ​P.​ProductID​, ​P.​ProductName 
-- FROM ​Products ​AS ​P 
-- WHERE ​P.​UnitPrice ​< ( 
--    ​SELECT ​AVG​(​UnitPrice​) 
--    ​FROM ​Products ​AS ​P2 
--    ​WHERE ​P2.​CategoryID ​= P.​CategoryID 
--    ​) ​--3.3 

/* Cw 3 3/5 */
/* Zad 1 - Dla każdego produktu podaj jego nazwę, cenę, średnią cenę wszystkich produktów oraz różnicę między ceną produktu a średnią ceną wszystkich produktów*/
-- select p.ProductName, p.UnitPrice, (
--     select AVG(Products.UnitPrice)
--     from Products
-- ) as average_price_of_all,(
--     select p.UnitPrice - AVG(Products.UnitPrice)
--     from Products
-- ) as DIFFERENCE
-- from Products as p

-- SELECT ​P.​ProductName​, ​P.​UnitPrice​, 
--       ​(​SELECT ​AVG​(​UnitPrice​) 
--           ​FROM ​Products) ​AS ​'averagePrice'​, 
--       ​P.​UnitPrice ​- (​SELECT ​AVG​(​UnitPrice​) ​FROM ​Products) ​AS ​'difference' 
-- FROM ​Products ​AS ​P​; ​--4.1 

/* Zad 2 -  Dla każdego produktu podaj jego nazwę kategorii, nazwę produktu, cenę, średnią cenę wszystkich produktów danej kategorii oraz 
różnicę między ceną produktu a średnią ceną wszystkich produktów danej kategorii */
-- select c.CategoryName, p.ProductName, p.UnitPrice, (
--     select AVG(pp.UnitPrice)
--     from Products as pp
--     where pp.CategoryID = p.CategoryID
-- ) as avg_cat,(
--     select p.UnitPrice -  AVG(pp.UnitPrice)
--     from Products as pp
--     where pp.CategoryID = p.CategoryID
-- ) as difference
-- from Products as p
--     join Categories as c
--     on c.CategoryID = p.CategoryID
 
-- SELECT ​(​SELECT ​C.​CategoryName 
--           ​FROM ​Categories ​AS ​C
--           ​WHERE ​C.​CategoryID ​= P.​CategoryID​) ​AS ​'CategoryName'​, 
--       ​P.​ProductName​, ​P.​UnitPrice​, 
--       ​(​SELECT ​AVG​(P2.​UnitPrice​) 
--           ​FROM ​Products ​AS ​P2 
--           ​WHERE ​P2.​CategoryID ​= P.​CategoryID​) ​AS ​'AveragePriceByCategory'​,
--       ​P.​UnitPrice ​- (​SELECT ​AVG​(P2.​UnitPrice​) 
--                        ​FROM ​Products ​AS ​P2 
--                        ​WHERE ​P2.​CategoryID ​= P.​CategoryID​) ​AS ​'difference' 
-- FROM ​Products ​AS ​P 

/* Cw 4 4/5 */
/* Zad 1 -   Podaj łączną wartość zamówienia o numerze 1025 (uwzględnij cenę za przesyłkę)*/
select o.Freight + (
    select SUM(UnitPrice*Quantity*(1-Discount))
    from [Order Details] od
    where od.OrderID = 10250
)
from Orders o
where o.OrderID=10250

-- SELECT ​O.​Freight ​+ (​SELECT ​SUM​(OD.​UnitPrice​*OD.​Quantity​*(​1​-OD.​Discount​)) 
-- FROM ​[Order Details] ​AS ​OD 
-- WHERE ​OD.​OrderID ​= O.​OrderID 
-- GROUP BY ​OD.​OrderID​) 
-- FROM ​Orders ​AS ​O 
-- WHERE ​O.​OrderID ​= ​10250​; ​--5.1 

/* Zad 2 -  Podaj łączną wartość zamówień każdego zamówienia (uwzględnij cenę za przesyłkę)*/
-- select o.OrderID, o.Freight + (
--     select SUM(UnitPrice*Quantity*(1-Discount))
--     from [Order Details] od
--     where od.OrderID = o.OrderID
-- )
-- from Orders o

-- SELECT ​O.​OrderID​, ​O.​Freight ​+ (​SELECT 
-- SUM​(OD.​UnitPrice​*OD.​Quantity​*(​1​-OD.​Discount​)) 
-- FROM ​[Order Details] ​AS ​OD 
-- WHERE ​OD.​OrderID ​= O.​OrderID 
-- GROUP BY ​OD.​OrderID​) 
-- FROM ​Orders ​AS ​O​; ​--5.2 

/* Zad 3 -   Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe*/
-- use Northwind
-- select c.Address
-- from Customers as c
-- where not exists
--     (
--         select distinct *
--         from Orders as o 
--         where YEAR(o.OrderDate)=1997 and o.CustomerID = c.CustomerID
--     )
 

-- SELECT ​C.​Address 
-- FROM ​Customers ​AS ​C 
-- WHERE ​C.​CustomerID ​NOT IN ​( 
--    ​SELECT ​O.​CustomerID 
--    ​FROM ​Orders ​AS ​O 
--    ​WHERE ​year​(O.​OrderDate​) = ​1997 
--    ​)​;​--5.3 

/* Zad 4 -  Podaj produkty kupowane przez więcej niż jednego klienta*/
use Northwind
select p.ProductName as name
from Products p
where exists(
    select * 
    from [Order Details] od
    join Orders o
    on od.OrderID = o.OrderID
    group by o.CustomerID
    having COUNT(*)>1
)
order by name
 

-- select ​P.​ProductName​ as name, ​count​(​*​) 
-- from ​Products ​as ​p 
-- inner join ​[Order Details] od ​on ​od.​ProductID ​= p.​ProductID 
-- inner join ​Orders O ​on ​od.​OrderID ​= O.​OrderID 
-- group by ​p.​ProductName 
-- having ​count​(​*​) > ​1​; 

/* CW_5 5/5 */
/* Zad 1 -  Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika (przy obliczaniu wartości zamówień uwzględnij cenę za przesyłkę*/

-- select e.FirstName, e.LastName,(
--     select SUM(od.Quantity*od.UnitPrice*(1-od.Discount))
--     from [Orders] o
--     join [Order Details] od
--     on o.OrderID = od.OrderID
--     where e.EmployeeID = o.EmployeeID
-- ) + (
--     select SUM(Ord.Freight)
--     from Orders ord
--     where e.EmployeeID = ord.EmployeeID
    
-- )
-- from Employees e

/* Zad 2 .WK */
-- SELECT TOP ​1 ​E.​FirstName ​+ ​' ' ​+ e.​LastName ​as ​'name'​, ​( 
--        ​SELECT ​SUM​

-- (OD.​UnitPrice​*od.​quantity​*(​1​-od.​Discount​)) 
--        ​from ​Orders ​AS ​O 
--                 ​INNER JOIN ​[Order Details] ​as ​OD ​ON ​O.​OrderID ​= OD.​OrderID 
--        ​WHERE ​E.​EmployeeID ​= O.​EmployeeID ​AND ​year​(O.​ShippedDate​) = ​1997 
--    ​) ​AS ​'value' 
-- FROM ​Employees ​as ​e 
-- ORDER BY value DESC ​--6.2

/* Zad 3 .WK */
-- SELECT ​E.​FirstName ​+ ​' ' ​+ E.​LastName ​AS ​'name'​, ​( 
--         ​SELECT ​SUM​

-- (OD.​UnitPrice​*od.​quantity​*(​1​-od.​Discount​)) 
--         ​from ​Orders ​AS ​O 
--                  ​INNER JOIN ​[Order Details] ​as ​OD ​ON ​O.​OrderID ​= OD.​OrderID 
--         ​WHERE ​E.​EmployeeID ​= O.​EmployeeID​) + 
--         (​SELECT ​sum​

-- (O.​Freight​) 
--         ​from ​Orders ​as ​o 
--         ​WHERE ​o.​EmployeeID ​= e.​EmployeeID​) 
-- FROM ​Employees ​AS ​E 
-- WHERE ​e.​EmployeeID ​IN ​(​select distinct ​a.​EmployeeID 
--                       ​from ​Employees ​as ​a 
--                        ​inner join ​Employees ​as ​b ​on ​a.​EmployeeID ​= b.​ReportsTo​) 

/* Zad 4 .WK */
-- SELECT ​E.​FirstName ​+ ​' ' ​+ E.​LastName ​AS ​'name'​, ​( 
--         ​SELECT ​SUM​

-- (OD.​UnitPrice​*od.​quantity​*(​1​-od.​Discount​)) 
--         ​from ​Orders ​AS ​O 
--                  ​INNER JOIN ​[Order Details] ​as ​OD ​ON ​O.​OrderID ​= OD.​OrderID 
--         ​WHERE ​E.​EmployeeID ​= O.​EmployeeID​) + 
--         (​SELECT ​sum​

-- (O.​Freight​) 
--         ​from ​Orders ​as ​o 
--         ​WHERE ​o.​EmployeeID ​= e.​EmployeeID​) 
-- FROM ​Employees ​AS ​E 
-- WHERE ​e.​EmployeeID ​IN ​(​select distinct ​a.​EmployeeID 
--                       ​from ​Employees ​as ​a 
--                                ​left join ​Employees ​as ​b ​on ​a.​EmployeeID ​= b.​ReportsTo ​where ​b.​EmployeeID ​is null​)​; 