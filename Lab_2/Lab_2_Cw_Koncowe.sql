/* AGREGATY ĆWICZENIE KOŃCOWE */
use Northwind


    /* Cwiczenie 1 2/4*/

/* Zad 1 -   Napisz polecenie, które oblicza wartość sprzedaży dla każdego 
zamówienia i wynik zwraca posortowany w malejącej kolejności 
(wg wartości sprzedaży).*/

-- select OrderID, ROUND(SUM(UnitPrice*Quantity * (1-Discount)),5) as 'Wartosc Sprzedazy'
-- from [Order Details]
-- GROUP by OrderID
-- order by [Wartosc Sprzedazy] DESC

/* Zad 2 - Zmodyfikuj zapytanie z punktu 1., tak aby zwracało pierwszych 10 
wierszy*/

-- select TOP 10 OrderID, ROUND(SUM(UnitPrice*Quantity * (1-Discount)),5) as 'Wartosc Sprzedazy'
-- from [Order Details]
-- GROUP by OrderID
-- order by [Wartosc Sprzedazy] DESC

/* Zad 3 - Zmodyfikuj zapytanie z punktu 2., tak aby zwracało 10 pierwszych 
produktów wliczając równorzędne. Porównaj wyniki. */
-- ??
-- select TOP 10 WITH TIES  OrderID, ROUND(SUM(UnitPrice*Quantity * (1-Discount)),5) as 'Wartosc Sprzedazy'
-- from [Order Details]
-- GROUP by OrderID
-- order by [Wartosc Sprzedazy] DESC


    /* CWICZENIE 2  3/4*/

/* Zad 1  -  Podaj liczbę zamówionych jednostek produktów dla produktów o 
identyfikatorze < 3*/
-- Pierwsze rozumowanie:

    -- SELECT SUM(Quantity) 
    -- from [Order Details]
    -- where ProductID<3
    -- group by ProductID

-- Drugie rozumowanie
-- SELECT ProductID, COUNT(*) as 'liczba jedn'
-- from [Order Details]
-- where ProductID<3
-- group by ProductID

-- SELECT *
-- from [Order Details]

/* Zad 2 - Zmodyfikuj zapytanie z punktu 1. tak aby podawało liczbę 
zamówionych jednostek produktu dla wszystkich produktów*/

-- Pierwsze rozumowanie

-- SELECT SUM(Quantity) 
-- from [Order Details]
-- group by ProductID


-- Drugie rozumowanie

-- SELECT ProductID, COUNT(*) as 'liczba jedn'
-- from [Order Details]
-- group by ProductID

/* Zad 3 -  Podaj wartość zamówienia dla każdego zamówienia, dla którego
łączna liczba zamawianych jednostek produktów jest > 250 */

-- SELECT SUM(UnitPrice * Quantity * (1-Discount)) as 'ORDER PRICE'
-- from [Order Details]
-- group by ProductID
-- having SUM(Quantity) > 250


    /* CWICZENIE 3 4/4*/

/* Zad 1 -  Napisz polecenie, które oblicza sumaryczną ilość zamówionych 
towarów i porządkuje wg productid i orderid oraz wykonuje kalkulacje rollup.*/

-- SELECT ProductID,OrderID, sum(Quantity)
-- from [Order Details]
-- GROUP BY ProductID,OrderID
-- WITH ROLLUP
-- ORDER BY ProductID,OrderID

-- select *
-- from [Order Details]

/* Zad 2 - Zmodyfikuj zapytanie z punktu 1., tak aby ograniczyć wynik tylko do 
produktu o numerze 50. */

-- SELECT ProductID,OrderID, sum(Quantity)
-- from [Order Details]
-- GROUP BY ProductID,OrderID
-- WITH ROLLUP
-- Having ProductID=50
-- ORDER BY ProductID,OrderID

/* Zad 3 -  Jakie jest znaczenie wartości null w kolumnie productid i orderid? */

-- NULL jest "meta-symbolem", ktory pokazuje, ze bierzemy sume wszystkich wierszy

/* Zad 4 -  Zmodyfikuj polecenie z punktu 1. używając operator cube zamiast 
rollup. Użyj również funkcji GROUPING na kolumnach productid i 
orderid do rozróżnienia między sumarycznymi i szczegółowymi 
wierszami w zbiorze */

-- Pierwszy (banalny) sposón
-- SELECT ProductID,OrderID, sum(Quantity) as 'SUM', GROUPING(ProductID) as 'Grouping_Product_ID', GROUPING(OrderID) as 'Grouping_orderID'
-- from [Order Details]
-- GROUP BY ProductID,OrderID
-- WITH CUBE
-- ORDER BY ProductID,OrderID

-- Drugi (.wk)
-- select
--    CASE 
-- 	  WHEN GROUPING(ProductID) = 1 THEN 'All products' 
--       ELSE CONVERT(varchar, ProductID)
--    END ProductID,
--    CASE 
-- 	  WHEN GROUPING(OrderID) = 1 THEN 'All orders' 
--       ELSE CONVERT(varchar, OrderID)
--    END OrderID,
--    sum(Quantity) as number
-- from [Order Details]
-- group by ProductID, OrderID
-- with cube 
-- order by ProductID, OrderID

/* Zad 5 -  Które wiersze są podsumowaniami? */

-- Wiersze, zawierające przynajmniej jedną jedynkę (Tam, gdzie jedynka - po tym grupujemy)