use Northwind

    /* TOP n - generuje tylko n pierwszych wartości zapytania*/

-- SELECT  TOP 5orderid, productid, quantity
-- FROM [order details]
-- ORDER BY quantity DESC


    /* Funkcje AGREGUJĄCE - pomagają w liczeniu czegoś zbiorowego, ale uwaga na select!*/

/* AVG - AVG
COUNT - liczba wartości w wyrażeniu
COUNT (*) - liczba wybranych wierszy (Nawet NULL)
MAX - max
MIN - MIN
SUM - SUM
STDEV - statystyczne odchylenie wszystkich wartości
STDEVP - statystyczne odchylenie dla populacji
VAR - statystyczna wariancja dla wszystkich wartości
VARP -  statystyczna wariancja dla wszystkich wartości w populacji
*/


    /* GROUP BY - grupujemy po kolumnie, !uwaga! w select odpowiednio mają być pogrupowane wyniki 
    HAVING - pozwala na filtrowanie już zgrupowanych danych
    WHERE - pozwala na filtrowanie danych przed grupowaniem*/

/* select SUM(UnitPrice), CategoryID
from Products
where UnitPrice>5 -- W tym miejscu !UWAGA! filtrujemy dane przed grupowaniem
GROUP BY CategoryID
having sum(UnitPrice)>200 */


        /* Wartości zagregowane w zbiorach wynikowych: */

    /* GROUP BY + ROLLUP -  
is based on generating multiple result sets, each of which (after the first) is the aggregate of the previous result set.
*/

-- SELECT productid, orderid, SUM(quantity) AS total_quantity
-- FROM orderhist
-- GROUP BY productid, orderid
-- WITH ROLLUP

    /* Odpowiednik CUBE ZA POMOCĄ ROLLUP */
-- UNION
-- SELECT productid, orderid, SUM(quantity) AS total_quantity
-- FROM orderhist
-- GROUP BY orderid, productid
-- WITH ROLLUP

-- select *
-- from orderhist



-- SELECT orderid, productid, SUM(quantity) AS total_quantity
-- FROM [order details]
-- WHERE orderid < 10250
-- GROUP BY orderid, productid
-- WITH ROLLUP
-- select *
-- from [order details]
-- ORder by OrderID

    /* GROUP BY + CUBE -
In addition to producing all the rows of a GROUP BY ROLLUP, GROUP BY CUBE adds all the “cross-tabulations” rows.
 */

-- SELECT productid, orderid, SUM(quantity) AS total_quantity
-- FROM orderhist
-- GROUP BY productid, orderid
-- WITH CUBE 
-- select *
-- from orderhist

    /* GROUP BY + CUBE + CROUPING -
Funkcja GROUPING zwraca 1, gdy wartości w określonej kolumnie zostały pogrupowane razem 
operatorem CUBE. 
*/

-- SELECT productid, orderid, SUM(quantity) AS total_quantity, GROUPING(productid) as '(productid)', GROUPING(orderid) as '(orderid)'
-- FROM orderhist
-- GROUP BY productid, orderid
-- WITH CUBE 
-- select *
-- from orderhist

    /* GROUP BY + GROUPING SETS -
    GROUP BY GROUPING SETS((a),(b)) is equivalent to GROUP BY a UNION ALL GROUP BY b*/

-- select CustomerID,EmployeeID
-- from Orders
-- GROUP BY GROUPING SETS (
--     (CustomerID),
--     (EmployeeID)
-- )


    /* COMPUTE / COMPUTE BY - 
The COMPUTE clause is no longer supported in SQL Server 2012. The documentation suggests using ROLLUP instead. :( */
