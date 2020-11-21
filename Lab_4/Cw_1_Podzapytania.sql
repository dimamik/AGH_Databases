        /* Subqueries */

/* Podzapytania do tabel */
/* Przykłady */

/* Na miejscu tabeli */
-- USE northwind 
-- SELECT T.orderid, T.customerid 
-- FROM ( SELECT orderid, customerid
--         FROM orders ) AS T 

/* Jako wyrażenie */
-- USE northwind
-- select ProductName,UnitPrice,
--     (
--     select AVG(UnitPrice)
--     from Products
--     ) as average,
--     UnitPrice - (
--     select AVG(UnitPrice)
--     from Products
--     ) as DIFFERENCE
-- from Products

/* Jako warunek */
-- USE northwind 
-- SELECT productname, UnitPrice 
--      ,( SELECT AVG(unitprice) FROM products) AS average 
--      ,unitprice-(SELECT AVG(UnitPrice) FROM products) AS difference 
-- FROM products 
-- WHERE unitprice > ( SELECT AVG(unitprice) FROM products) 

/* Podzapytania skorelowane: 
1. Zewnętrzne zapytanie 
przekazuje dane do zapytania 
wenętrznego.
2. Zapytanie wewnętrzne 
wykorzystuje te dane od 
wygenerowania wyniku
3. Zapytanie wewnętrzne zwraca 
ten wynik do zapytania 
zewnętrznego
4. Proces jest powtarzany dla 
każdego wiersza zapytania 
wewnętrznego -> Back to step 1
*/
-- USE northwind 
--  SELECT productname, unitprice 
--      ,( SELECT AVG(unitprice)  
--             FROM products as p_wew 
--         WHERE p_zew.categoryid = p_wew.categoryid ) AS average     
--  FROM products as p_zew 


-- USE northwind 
-- SELECT productname, UnitPrice 
--      ,( SELECT AVG(UnitPrice) FROM products as p_wew 
--         WHERE p_zew.categoryid = p_wew.categoryid ) AS
--      average     
--  FROM products as p_zewn 
-- WHERE UnitPrice >  
--         ( SELECT AVG(UnitPrice) FROM products as p_wew 
--         WHERE p_zew.category_id = p_wew.categoryid )  

/* Dla każdego produktu podaj maksymalną liczbę zamówionych jednostek  */
-- USE northwind 
-- SELECT DISTINCT productid, quantity 
--  FROM [order details] AS ord1 
--  WHERE quantity = ( SELECT MAX(quantity) 
--                      FROM [order details] AS ord2 
--                      WHERE ord1.productid = ord2.productid 
-- ) 
-- ORDER BY productid

/* To samo ale z group by */

-- select productid, max(quantity) 
-- from [order details] 
-- group by productid 
-- order by productid

/* JOIN,EXISTS,IN: */
SELECT DISTINCT lastname, e.employeeid 
 FROM orders AS o 
 INNER JOIN employees AS e 
  ON o.employeeid = e.employeeid 
 WHERE o.orderdate = '9/5/1997'

SELECT lastname, employeeid 
 FROM employees AS e 
 WHERE EXISTS (SELECT * FROM orders AS o 
                WHERE e.employeeid = o.employeeid 
                 AND  o.orderdate = '9/5/97') 

                 SELECT lastname, employeeid 
 FROM employees AS e 
 WHERE employeeid in (SELECT employeeid FROM orders AS o 
                 WHERE  o.orderdate = '9/5/97')