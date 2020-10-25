/* Database Configuration */
use Northwind

/* Przykłądy z Ćwiczenia: */

/* Wybieramy TOP 5 pozycji */
-- USE northwind
-- SELECT  TOP 5orderid, productid, quantity
-- FROM [order details]
-- ORDER BY quantity DESC

/* Wybieramy TOP 5 i tie, czyli wszystkie o ostatniej wartosci (tu bedzie po quantity) */
-- USE northwind
-- SELECT TOP 5 WITH TIES orderid, productid, quantity
-- FROM [order details]
-- ORDER BY quantity DESC

/* COUNT (*), żeby policzyć wierszy, zlicza wartości NULL*/
-- SELECT *
-- FROM employees

/* COUNT, tylko calkowicie wypelnione*/
-- SELECT COUNT(reportsto)
-- FROM employees

/* AVG -- Policz średnią cenę jednostkową dla wszystkich produktów:*/
-- SELECT AVG(unitprice)
-- FROM products

/* SUM --  Pokaż sumaryczną ilość sprzedanych produktów: */
-- SELECT SUM(quantity)
-- FROM [order details]



/* CWICZENIE 7/22*/

/* Zad 1  Podaj liczbę produktów o cenach mniejszych niż 10$ lub 
większych niż 20$*/
-- SELECT COUNT(*)
-- from Products
-- where UnitPrice<10 or UnitPrice>20

/* Zad 2 Podaj maksymalną cenę produktu dla produktów o cenach 
poniżej 20$*/

-- select TOP 1 UnitPrice
-- from Products
-- where UnitPrice<20
-- ORDER BY UnitPrice DESC

/* Zad 2 Sposób 2 */
-- select MAX(UnitPrice)
-- from Products
-- where UnitPrice<20

/* Zad 3  Podaj maksymalną, minimalną i średnią cenę produktu dla 
produktów sprzedawanych w butelkach (‘bottle’) */
-- select MAX(UnitPrice) as 'Maksymalna Cena',MIN(UnitPrice) as 'Minimalna Cena',AVG(UnitPrice) as 'Średnia Cena'
-- from Products
-- where QuantityPerUnit Like '%bottle%'

/* Zad 4 Wypisz informację o wszystkich produktach o cenie powyżej średniej*/

/* Rozbic na dwa podzapytania */
-- select AVG(UnitPrice)
-- from Products

/* AVG = 28,8663 */
-- select *
-- from Products
-- where UnitPrice > 28.8663
-- ORDER BY UnitPrice 

/* Zad 5 Podaj wartość zamówienia o numerze 10250*/
-- select SUM(UnitPrice*Quantity * (1-Discount))
-- from [Order Details]
-- where OrderID=10250

-- select * 
-- from [Order Details]
-- where OrderID=10250

/* Przyklady Grupowanie Danych */
-- select *
-- from orderhist

-- SELECT productid,SUM(quantity) AS total_quantity
-- FROM orderhist
-- GROUP BY productid

-- SELECT productid
-- ,SUM(quantity) AS total_quantity
-- FROM orderhist
-- WHERE productid = 2
-- GROUP BY productid

-- SELECT productid, SUM(quantity) AS total_quantity
-- FROM [order details]
-- GROUP BY productid

/* CWICZENIA 11/22*/

/* Zad 1  Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia. Posortuj zamówienia wg maksymalnej ceny produktu*/
-- select MAX(UnitPrice) as 'Maksymalna Cena Zamawianego Produktu'
-- from [Order Details]
-- GROUP BY OrderID
-- ORDER BY [Maksymalna Cena Zamawianego Produktu]

-- select *
-- from [Order Details]

/* Zad 2 Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia*/
-- select MAX(UnitPrice) as 'Maksymalna Cena', MIN(UnitPrice) as 'Minimalna Cena'
-- from [Order Details]
-- GROUP BY OrderID

/* Zad 3  Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów*/
-- select COUNT(*) as 'Liczba Zamówień Dostarczanych przez -> ', ShipVia
-- from Orders
-- GROUP BY ShipVia

/* Zad 4  Który ze spedytorów był najaktywniejszy w 1997 roku?*/
-- select TOP 1 COUNT(*) as 'Liczba Zamówień ', ShipVia
-- from Orders
-- where ShippedDate Like '%1997%'
-- GROUP BY ShipVia
-- ORDER BY [Liczba Zamówień] DESC

/* Przyklady GROUP BY + HAVING */

-- USE northwind
-- SELECT productid, SUM(quantity) AS total_quantity
-- FROM [order details]
-- GROUP BY productid
-- HAVING SUM(quantity)>1200

/*CWICZENIE 14/22*/

/* Zad 1 Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5*/
-- SELECT OrderID,COUNT(*)
-- from [Order Details]
-- GROUP BY OrderID
-- Having COUNT(*)> 5

/* Zad 2  Wyświetl klientów, dla których w 1998 roku zrealizowano więcej niż 8 zamówień (wyniki posortuj malejąco wg łącznej kwoty za dostarczenie zamówień dla każdego z SQL – operacje agregacji
łącznej kwoty za dostarczenie zamówień dla każdego z klientów)*/
-- SELECT CustomerID
-- from Orders
-- where ShippedDate LIKE '%1998%'
-- GROUP by CustomerID
-- Having COUNT(*)>8
-- ORDER BY SUM(Freight) DESC

/* Przykład Generowanie Wartości zagregowanych w zbiorach wynikowych */
-- SELECT productid, orderid, SUM(quantity) AS total_quantity
-- FROM orderhist
-- GROUP BY productid, orderid
-- WITH ROLLUP
-- ORDER BY productid, orderid

-- SELECT orderid, productid, SUM(quantity) AS total_quantity
-- FROM [order details]
-- WHERE orderid < 10250
-- GROUP BY orderid, productid
-- ORDER BY orderid, productid

/* ROLLUP -> Czyli wszystkie ze wszystkimi*/
-- SELECT orderid, productid, SUM(quantity) AS total_quantity
-- FROM [order details]
-- WHERE orderid < 10250
-- GROUP BY orderid, productid
-- WITH ROLLUP
-- ORDER BY orderid, productid

-- SELECT *
-- from [Order Details]

/* CUBE ->*/
-- SELECT productid, orderid, SUM(quantity) AS total_quantity
-- FROM orderhist
-- GROUP BY productid, orderid
-- WITH CUBE 
-- ORDER BY productid, orderid

-- SELECT *
-- from orderhist


/* GROUPING */
-- SELECT productid, GROUPING (productid)
-- ,orderid, GROUPING (orderid)
-- ,SUM(quantity) AS total_quantity
-- FROM orderhist
-- GROUP BY productid, orderid
-- WITH CUBE 
-- ORDER BY productid, orderid

/* COMPUTE  (Cos nie gra)*/

-- SELECT productid, orderid
-- ,quantity 
-- FROM orderhist
-- ORDER BY productid, orderid
-- COMPUTE SUM(quantity) BY productid
-- COMPUTE SUM(quantity)