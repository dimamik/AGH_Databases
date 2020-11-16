    /* Generating database from examples: */
/* CREATE DATABASE Joindb;
CREATE TABLE Produce(
    prod_id INT ,
    PRIMARY KEY (prod_id),
    prod_name varchar(255)
);
CREATE TABLE Buyers(
    buyer_id INT,
    buyer_name VARCHAR(255),
    PRIMARY KEY (buyer_id)
);

CREATE TABLE Sales(
    buyer_id INT FOREIGN KEY REFERENCES Buyers(buyer_id),
    prod_id INT FOREIGN KEY REFERENCES Produce(prod_id),
    qty int
);
 */
use Joindb

/* Przykład 1 - Wybieranie z dwóch i więcej tablic*/

-- SELECT buyer_name, sales.buyer_id, qty
-- FROM buyers, sales
-- WHERE buyers.buyer_id = sales.buyer_id

/* Przykład 2 - użycie aliasu nazwy tabel*/

-- SELECT buyer_name, s.buyer_id, qty
-- FROM buyers AS b, sales AS s
-- WHERE b.buyer_id = s.buyer_id


    /* Łączenie danych z wielu tabel */

/* 1. Iloczyn Kartezjański */

-- SELECT b.buyer_name AS [b.buyer_name],
-- b.buyer_id AS [b.buyer_id], 
-- s.buyer_id AS [s.buyer_id], 
-- qty AS [s.qty]
-- FROM buyers AS b, sales AS s

/* 2. Złączenie Warunkowe */

-- SELECT b.buyer_name AS [b.buyer_name], 
-- b.buyer_id AS [b.buyer_id], 
-- s.buyer_id AS [s.buyer_id], 
-- qty AS [s.qty]
-- FROM buyers AS b, sales AS s
-- WHERE s.buyer_id = b.buyer_id

    /* 3. Join -
Słowo kluczowe JOIN wskazuje, że tabele są łączone i określa w jaki sposób 
JOIN + ON - specyfikuje warunki połączenia (Jako warunki połączenia wykorzystywane są przeważnie klucze 
główne i obce) */

/* PODSTAWOWA SKŁANIA JOIN
SELECT column_name [,column_name ...]
FROM <joined_table> ...

<joined_table> ::=
<table_source><join_type><table_source>ON<search_condition>
|<table_source>CROSS JOIN<table_source>
|<joined_table>

<join_type>::=
[INNER|{{LEFT|RIGHT|FULL}[OUTER]}] [<join_hint>] JOIN
 */

/* INNER JOIN - Rozszerza wartości z tablicy o powtarzającym się klucze przez wartości z tablicy o nie powtarzającym się klucze (Wybiera automatycznie)
 */

-- SELECT buyer_name, sales.buyer_id, qty
-- FROM buyers  INNER JOIN sales
-- ON buyers.buyer_id = sales.buyer_id

-- select *
-- from Sales

-- USE northwind
-- SELECT productname, companyname
-- FROM suppliers
--     INNER JOIN Products
--     ON products.supplierid = suppliers.supplierid

-- USE northwind
-- SELECT DISTINCT companyname, orderdate
-- FROM orders
-- INNER JOIN customers
-- ON orders.customerid = customers.customerid
-- WHERE orderdate > '3/1/98'

/* LEFT OUTER JOIN- 
 */
-- USE joindb
-- SELECT buyer_name, sales.buyer_id, qty
-- FROM  buyers LEFT OUTER JOIN Sales
-- ON buyers.buyer_id = sales.buyer_id

-- select *
-- from Buyers

-- select *
-- from Sales


-- USE northwind
-- SELECT companyname, customers.customerid, orderdate
-- FROM customers
-- LEFT OUTER JOIN orders
-- ON customers.customerid = orders.customerid
-- ORDER BY CustomerID

-- select *
-- from Customers


-- select *
-- from Orders


    /* ĆWICZENIA 18/34*/

/* Zad 1 - Napisz polecenie, które wyświetla listę dzieci będących 
członkami biblioteki. Interesuje nas imię, nazwisko i data urodzenia dziecka. */

-- use library
-- SELECT member.firstname, member.lastname, juvenile.birth_date , member.member_no
-- from juvenile
-- LEFT OUTER JOIN member
-- ON juvenile.member_no = member.member_no


-- select firstname, lastname, birth_date from juvenile 
-- inner join member on member.member_no=juvenile.member_no

-- Can be used inner join

/* Zad 2 -  Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek*/

-- use library
-- SELECT DISTINCT title.title
-- from loanhist
-- LEFT JOIN title
-- ON title.title_no = loanhist.title_no
-- where due_date is NULL

-- select distinct title from title inner join loan on loan.title_no=title.title_no

/* Zad 3 -  Podaj informacje o karach zapłaconych za przetrzymywanie 
książki o tytule ‘Tao Teh King’.  Interesuje nas data oddania 
książki, ile dni była przetrzymywana i jaką zapłacono karę */

-- use library
-- select in_date,
-- DATEDIFF(day,in_date,due_date) as 'Przetrzymanych dni',fine_paid,in_date,due_date
-- from loanhist
-- LEFT JOIN title
-- ON loanhist.title_no = title.title_no
-- where title.title = 'Tao Teh King' and fine_paid is not NULL

-- select title, due_date, fine_paid, datediff(day, in_date,due_date) from loanhist 
-- inner join title on title.title_no=loanhist.title_no 
-- where title like 'Tao Teh King' and fine_paid is not null

/* Zad 4 -  Napisz polecenie które podaje listę książek (numery ISBN) zarezerwowanych przez osobę o nazwisku: Stephen A. Graff*/

-- use library
-- select reservation.isbn
-- from reservation
-- LEFT JOIN member
-- ON member.member_no = reservation.member_no
-- where (member.firstname +' ' + member.middleinitial + '. '+ member.lastname) LIKE 'Stephen A. Graff'

-- select isbn, lastname from reservation 
-- inner join member on member.member_no=reservation.member_no
-- where firstname='Stephen' and lastname='Graff' and middleinitial='A'


/* Zad 5 -  Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20 a 30, dla każdego produktu podaj dane adresowe dostawcy*/

-- use Northwind
-- select Products.ProductName, Products.UnitPrice, Suppliers.Address
-- from Products
-- LEFT JOIN Suppliers
-- ON Suppliers.SupplierID = Products.SupplierID
-- where Products.UnitPrice BETWEEN 20 and 30

-- select productname, unitprice, Address from products inner join suppliers on suppliers.supplierID=products.SupplierID
-- where unitprice between 20 and 30


/* Zad 6 -  Wybierz nazwy produktów oraz informacje o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders*/

-- use Northwind
-- select Products.ProductName, Products.UnitsInStock
-- from Products
-- INNER JOIN Suppliers
-- ON Suppliers.SupplierID = Products.SupplierID
-- where Suppliers.CompanyName = 'Tokyo Traders'

-- select productname, unitsinstock from products
-- inner join suppliers on suppliers.SupplierID=products.SupplierID
-- where companyname='Tokyo Traders'


/* Zad 7 - Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe */

-- use Northwind;
-- with
--     tmp_tab
--     as
--     (
--         select DISTINCT Customers.CustomerID as CID
--         from Customers
--             LEFT JOIN Orders
--             ON Orders.CustomerID = Customers.CustomerID
--         where DATEPART(YEAR,Orders.OrderDate) = 1997
--     )
-- select Customers.Address
-- from tmp_tab
--     RIGHT JOIN Customers
--     ON tmp_tab.CID = Customers.CustomerID
-- where tmp_tab.CID is NULL

-- select customers.customerid, Address 
-- from customers
-- left OUTER join Orders 
-- on customers.CustomerID=orders.CustomerID and year(orderdate)=1997 
-- where orderid is null 

/* Zad 5 -  Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie  ma w magazynie*/

-- use Northwind
-- SELECT DISTINCT Suppliers.CompanyName, Suppliers.Phone
-- from Products
-- LEFT JOIN Suppliers
-- ON Products.SupplierID = Suppliers.SupplierID
-- where isnull(unitsinstock,0)=0 or Discontinued=1

-- select companyname, phone from Suppliers
-- inner join products on products.SupplierID=Suppliers.SupplierID
-- where isnull(unitsinstock,0)=0

/* CROSS JOIN - Daje iloczyn Kartezjański zbiorów
 */
-- use Joindb
-- SELECT buyer_name, qty
-- FROM buyers
-- CROSS JOIN sales

-- select *
-- from Buyers

-- select *
-- from Sales

-- USE northwind
-- SELECT suppliers.companyname, shippers.companyname
-- FROM suppliers
-- CROSS JOIN shippers
-- ORDER by suppliers.CompanyName


/* Łączenie więcej niż dwóch tabel */

-- SELECT buyer_name, prod_name, qty
-- FROM buyers
--     INNER JOIN sales
--     ON buyers.buyer_id = sales.buyer_id
--     INNER JOIN produce
--     ON sales.prod_id = produce.prod_id

/* Przykład - Napisz polecenie zwracające listę produktów zamawianych w dniu 1996-07-08. */
-- USE northwind
-- SELECT orderdate, productname
-- FROM orders AS O
-- INNER JOIN [order details] AS OD
-- ON O.orderid = OD.orderid
-- INNER JOIN products AS P
-- ON OD.productid = P.productid
-- WHERE orderdate = '7/8/96'


    /* ĆWICZENIE 24/34 */

/* Zad 1 -Wybierz nazwy i ceny produktów (baza northwind) o cenie 
jednostkowej pomiędzy 20 a 30, dla każdego produktu 
podaj dane adresowe dostawcy, interesują nas tylko 
produkty z kategorii ‘Meat/Poultry’ */

-- use Northwind
-- SELECT Products.ProductName,Products.UnitPrice, Suppliers.Address
-- from Products
-- Inner JOIN Categories
-- ON Categories.CategoryID = Products.CategoryID
-- inner join Suppliers
-- ON Products.SupplierID = Suppliers.SupplierID
-- where (UnitPrice BETWEEN 20 and 30) and CategoryName LIKE 'Meat/Poultry'

-- select productname, unitprice, address from products
-- inner join suppliers s on s.supplierid =products.SupplierID
-- inner join Categories c on c.CategoryID=products.CategoryID
-- where unitprice between 20 and 30 and categoryname like 'Meat/Poultry'

/* Zad 2 - Wybierz nazwy i ceny produktów z kategorii ‘Confections’
dla każdego produktu podaj nazwę dostawcy. */

-- use Northwind
-- SELECT Products.ProductName,Products.UnitPrice, Suppliers.CompanyName
-- from Products
-- Inner JOIN Categories
-- ON Categories.CategoryID = Products.CategoryID
-- inner join Suppliers
-- ON Products.SupplierID = Suppliers.SupplierID
-- where CategoryName LIKE 'Confections'

-- select productname, unitprice, CompanyName from products
-- inner join suppliers s on s.supplierid =products.SupplierID
-- inner join Categories c on c.CategoryID=products.CategoryID
-- where categoryname like 'Confections'

/* Zad 3 - Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki dostarczała firma ‘United Package’ */
-- use Northwind
-- SELECT distinct Customers.CompanyName, Customers.Phone
-- from Customers
--     inner join Orders
--         ON Orders.CustomerID = Customers.CustomerID
--     inner join Shippers
--         ON Shippers.ShipperID = Orders.ShipVia
-- where year(Orders.ShippedDate) = 1997 and Shippers.CompanyName='United Package'

-- select distinct customers.CompanyName, customers.Phone
-- from Customers
--     inner join orders o on o.CustomerID=customers.CustomerID and year(shippeddate)=1997
--     inner join shippers s on s.ShipperID=o.ShipVia and s.CompanyName='United Package'

/* Zad 4 - Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty  z kategorii ‘Confections’ */
-- use Northwind
-- select distinct Customers.CompanyName, Customers.Phone
-- from Customers
--     INNER JOIN Orders
--         ON Orders.CustomerID = Customers.CustomerID
--     INNER JOIN [Order Details]
--         ON [Order Details].OrderID = Orders.OrderID
--     INNER JOIN Products
--         ON [Order Details].ProductID = Products.ProductID
--     INNER JOIN Categories
--         ON Products.CategoryID = Categories.CategoryID and CategoryName='Confections'

-- select distinct c.CompanyName, c.Phone from Customers c
-- inner join orders o on o.CustomerID=c.CustomerID
-- inner join [Order Details] oo on oo.OrderID=o.OrderID
-- inner join products p on p.ProductID=oo.ProductID
-- inner join categories cc on cc.CategoryID=p.CategoryID and categoryname='Confections'


/* Zad 5 - Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki. Interesuje nas imię, nazwisko, data urodzenia dziecka i adres zamieszkania dziecka. */

-- use library
-- SELECT m.firstname,m.lastname,j.birth_date, a.street + ' ' + a.city + ' ' + a.[state] as Adress
-- from juvenile j
--     inner join member m
--         on m.member_no = j.member_no
--     inner join adult a
--         on j.adult_member_no = a.member_no

-- select m.firstname,m.lastname,j.birth_date,a.street+' '+a.city+ ' '+a.state as Address from member as m
-- inner join juvenile j on j.member_no=m.member_no
-- inner join adult a on a.member_no=j.adult_member_no

/* Zad 6 -  Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki. Interesuje nas imię, nazwisko, data członkami biblioteki. Interesuje nas imię, nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imię i nazwisko rodzica.  */

-- use library
-- SELECT m.firstname,m.lastname,j.birth_date, a.street + ' ' + a.city + ' ' + a.[state] as Adress, ma.firstname + ' '+ m.lastname as Parent
-- from juvenile j
--     inner join member m
--         on m.member_no = j.member_no
--     inner join adult a
--         on j.adult_member_no = a.member_no
--     inner join member ma
--         on a.member_no = ma.member_no



/* Łączenie tabeli samej ze sobą - self join -> kupujące takie same produkty*/

/* Przykład 1*/

-- USE joindb

-- SELECT a.buyer_id AS buyer1,
-- a.prod_id,b.buyer_id AS buyer2
-- FROM sales AS a
--     JOIN sales AS b
--     ON a.prod_id = b.prod_id

-- select *
-- from sales

/* Przykład 2 -> Zlikwidujemy duplikaty*/

-- USE joindb
-- SELECT a.buyer_id AS buyer1, a.prod_id
-- ,b.buyer_id AS buyer2
-- FROM sales AS a
--     JOIN sales AS b
--     ON a.prod_id = b.prod_id
-- WHERE a.buyer_id < b.buyer_id

/* Przykład 3 - Napisz polecenie, które pokazuje pary pracowników 
zajmujących to samo stanowisko.*/

-- USE northwind
-- SELECT a.employeeid, LEFT(a.lastname,10) AS name
-- ,LEFT(a.title,10) AS title,b.employeeid, LEFT(b.lastname,10) AS name
-- ,LEFT(b.title,10) AS title
-- FROM employees AS a
-- INNER JOIN employees AS b
-- ON a.title = b.title
-- WHERE a.employeeid < b.employeeid

    /* ĆWICZENIE 30/34 */

/* Zad 1 - Napisz polecenie, które wyświetla pracowników oraz ich 
podwładnych. */

-- use Northwind
-- select prac.LastName + ' ' + prac.FirstName as Boss, podwl.LastName + ' '+ podwl.FirstName as Podwladny
-- from Employees as prac
--     right join Employees as podwl
--     on podwl.ReportsTo = prac.EmployeeID

-- select e.firstname+' '+e.lastname, ee.firstname+' '+ee.lastname from employees as e
-- inner join employees as ee on ee.reportsto=e.EmployeeID
-- group by e.firstname+' '+e.lastname, ee.firstname+' '+ee.lastname with rollup 
-- having e.firstname+' '+e.lastname is not null and ee.firstname+' '+ee.lastname is not null

/* Zad 2 - Napisz polecenie, które wyświetla pracowników, którzy nie 
mają podwładnych.*/

-- use Northwind
-- select prac.FirstName  + ' ' + prac.LastName as Boss
-- from Employees as prac
--     left join Employees as podwl
--     on podwl.ReportsTo = prac.EmployeeID
--     where podwl.ReportsTo is NULL
-- order by Boss

-- select e.firstname+' '+e.lastname from employees as e
-- left join employees as ee on ee.reportsto=e.EmployeeID
-- group by e.firstname+' '+e.lastname having count(ee.employeeid)=0

/* Zad 3 - Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci urodzone przed 1 stycznia 1996  */

-- use library
-- select distinct a.member_no,a.city + ' ' + a.street + ' ' + a.[state]
-- from adult as a
--     inner join juvenile as j
--     on j.adult_member_no = a.member_no and birth_date<'1996/01/01'

-- use library
-- --3.3
-- select distinct a.member_no, a.street+' '+a.city+ ' '+a.state as Address from adult as a
-- inner join juvenile j on j.adult_member_no=a.member_no and j.birth_date < '1996/01/01'

/* Zad 4 - Napisz polecenie, które wyświetla adresy członków 
biblioteki, którzy mają dzieci urodzone przed 1 stycznia 1996. Interesują nas tylko adresy takich członków biblioteki, którzy aktualnie nie przetrzymują książek. */

-- use library
-- select distinct a.member_no,a.city + ' ' + a.street + ' ' + a.[state]
-- from adult as a 
--     inner join juvenile as j 
--     on j.adult_member_no = a.member_no and  birth_date<'1996/01/01' 
--     left join loan as l 
--     on l.member_no = a.member_no  
--     where (l.member_no is null or l.due_date>GETDATE()) 
-- order by member_no 

-- select distinct a.member_no, a.street+' '+a.city+ ' '+a.state as Address from adult as a
-- inner join juvenile j on j.adult_member_no=a.member_no and j.birth_date < '1996/01/01'
-- left join loan l on l.member_no=a.member_no group by a.member_no, a.street+' '+a.city+ ' '+a.state having count(l.isbn)=0
-- order by member_no

-- select *
-- from loan
-- order by due_date

        /* ŁĄCZENIE ZBIORÓW WYNIKOWYCH -
Użyj operatora UNION do tworzenia pojedynczego zbioru 
wynikowego z wielu zapytań
     Każde zapytanie musi mieć:
     zgodne typy danych
     taką samą liczbę kolumn 
     taki sam porządek kolumn w select-list
    
Operator EXCEPT -> Różnica prawostronna zbiorów
    
    */

/* Przykład */
-- USE northwind
-- SELECT (firstname + ' ' + lastname) AS name
-- ,city, postalcode
-- FROM employees
-- UNION
-- SELECT companyname, city, postalcode
-- FROM customers

    /* ĆWICZENIE  32/34*/

/* Zad 1 -  Napisz polecenie które zwraca imię i nazwisko (jako pojedynczą kolumnę – name), oraz informacje o adresie: ulica, miasto, stan kod (jako pojedynczą kolumnę – address) dla wszystkich dorosłych członków biblioteki*/
-- use library
-- select firstname, lastname, a.street+' '+a.city+ ' '+a.state+' ' +a.zip
-- from member as m
--     inner join adult as a
--     on a.member_no=m.member_no

/* Zad 2 - Napisz polecenie które zwraca informację o użytkownikach biblioteki o nr 250, 342, i 1675 (nr, imię i nazwisko członka biblioteki o nr 250, 342, i 1675 (nr, imię i nazwisko członka biblioteki) oraz informacje o  zarezerwowanych książkach (isbn, data) */
-- use library
-- select m.member_no,m.firstname,m.lastname,r.isbn,r.log_date
-- from member m
--     left join reservation r
--     on r.member_no = m.member_no
-- where m.member_no in (250,342,1675)

-- select m.member_no, firstname, lastname, r.isbn, r.log_date from member m
-- left join reservation r on r.member_no=m.member_no
-- where m.member_no=250 or m.member_no=342 or m.member_no=1675
-- group by m.member_no, firstname, lastname, r.isbn, r.log_date

/* Zad 3 - Podaj listę członków biblioteki mieszkających w Arizonie (AZ), którzy mają  więcej niż dwoje dzieci zapisanych do biblioteki */

-- use library
-- select m.firstname,m.lastname,count(j.adult_member_no) as 'Liczba dzieci'
-- from adult a
--     JOIN member m
--     on m.member_no = a.member_no
--     JOIN juvenile j
--     on j.adult_member_no = a.member_no and a.[state]='AZ'
-- GROUP BY m.member_no
-- having count(j.adult_member_no)>2


-- select m.member_no, m.firstname+m.lastname from member m
-- inner join adult a on a.member_no=m.member_no and a.state='AZ'
-- left join juvenile j on j.adult_member_no=a.member_no
-- group by m.member_no, m.firstname+m.lastname having count(j.adult_member_no)>2

/* Zad 4 - Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają  więcej niż dwoje dzieci zapisanych do biblioteki oraz takich którzy mieszkają w Kaliforni i mają więcej niż troje dzieci zapisanych do biblioteki */

-- use library
-- select a.member_no
-- from adult a
--     inner JOIN juvenile j
--     on j.adult_member_no = a.member_no and a.[state]='AZ'
-- GROUP BY a.member_no
-- having count(j.adult_member_no)>2
-- UNION
-- select a.member_no
-- from adult a
--     inner JOIN juvenile j
--     on j.adult_member_no = a.member_no and a.[state]='CA'
-- GROUP BY a.member_no
-- having count(j.adult_member_no)>3


-- select m.member_no, m.firstname+m.lastname from member m
-- inner join adult a on a.member_no=m.member_no and a.state='AZ'
-- left join juvenile j on j.adult_member_no=a.member_no
-- group by m.member_no, m.firstname+m.lastname having count(j.adult_member_no)>2
-- UNION
-- select m.member_no, m.firstname+m.lastname from member m
-- inner join adult a on a.member_no=m.member_no and a.state='CA'
-- left join juvenile j on j.adult_member_no=a.member_no
-- group by m.member_no, m.firstname+m.lastname having count(j.adult_member_no)>3

/* ĆWICZENIE 34/34 .wk */

-- use northwind
--5.1
-- use Northwind
-- select categoryname, companyname,  sum(quantity) as 'Liczba zamówionych jednostek' 
-- from categories c
--     inner join products p 
--     on p.CategoryID=c.CategoryID
--     inner join [Order Details] oo 
--     on oo.ProductID=p.ProductID
--     inner join Orders o 
--     on o.OrderID=oo.OrderID
--     inner join customers cc 
--     on cc.CustomerID=o.CustomerID
-- group by categoryname, companyname

--5.2
-- use Northwind
-- select od.OrderID, companyname, sum(quantity) as Quantity from [Order Details] od
--     inner join Orders o 
--     on o.OrderID=od.OrderID
--     inner join Customers c 
--     on c.CustomerID=o.CustomerID
-- group by od.OrderID, c.CustomerID, companyname 
-- order by od.OrderID

--5.3
-- select oo.OrderID, companyname, sum(quantity) as Quantity from [Order Details] oo
-- inner join Orders o on o.OrderID=oo.OrderID
-- inner join Customers c on c.CustomerID=o.CustomerID
-- group by oo.OrderID, c.CustomerID, companyname
-- having sum(quantity)>250
--  order by oo.OrderID

--5.4
-- use Northwind
-- select distinct companyname, productname 
-- from customers c
--     inner join orders o 
--     on o.CustomerID=c.CustomerID
--     inner join [Order Details] oo 
--     on oo.OrderID=o.OrderID
--     inner join Products p 
--     on p.ProductID=oo.ProductID

--5.5
-- use Northwind
-- select distinct c.companyname, o.orderid, sum(od.quantity*od.unitprice*(1-od.discount)) as 'Wartość zamówienia' 
-- from customers c
--     left join orders o 
--     on o.CustomerID=c.CustomerID
--     left join [Order Details] od 
--     on od.OrderID=o.OrderID
-- group by c.companyname, o.orderid

-- use library
--5.6
-- use library
-- select firstname, lastname 
-- from member m
-- left join loan l on l.member_no=m.member_no
-- left join loanhist lh on lh.member_no=m.member_no
-- group by m.member_no, firstname, lastname
-- having count(l.member_no)=0 and count(lh.member_no)=0
