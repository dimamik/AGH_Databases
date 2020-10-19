/* Setting default database */
use northwind

/* Str 29/57  */

/* Zad 1 */

-- select ContactName, Address
-- from Customers

/* Zad 2 */

-- select LastName, HomePhone
-- from Employees

/* Zad 3 */

-- SELECT ProductName, UnitPrice
-- from Products

/* Zad 4 */

-- select CategoryName,Description
-- from Categories

/* Zad 5 */

-- select CompanyName, HomePage
-- from Suppliers

/*  Str 34/57 */

/* Zad 1 */

-- select CompanyName, Address
-- from Customers
-- where City='London'

/* Zad 2 */

-- select CompanyName, Address
-- from Customers
-- where Country = 'France' or Country='Spain'

/* Zad 3 */

-- select ProductName,UnitPrice
-- from Products
-- where UnitPrice BETWEEN 20 and 30

/* Zad 4 */

-- select ProductName,UnitPrice
-- from Products
-- where CategoryID in (
--     select CategoryID
--     from Categories
--     where CategoryName LIKE '%Meat%'
-- )

/* Zad 5  V1*/

-- select ProductName,UnitsInStock
-- from Products
-- where SupplierID in (
--     select SupplierID
--     from Suppliers
--     where CompanyName='Tokyo Traders'
-- )

/* Zad 5 V2 */

-- select ProductName,UnitsInStock
-- from Products
-- where SupplierID = 4

/* Zad 6  */

-- select ProductName 
-- from Products
-- where Discontinued=1 or UnitsInStock<=0

/* Str 38/57 */

/* Zad 1 */

-- select * 
-- from Products
-- where QuantityPerUnit like '%bottle%'


/* Zad 2 */

-- select *
-- from Employees
-- where LastName like '[B-L]%'
-- ORDER BY LastName

/* Zad 3 */

-- select *
-- from Employees
-- where LastName like '[BL]%'
-- ORDER BY LastName

/* Zad 4 */

-- SELECT CategoryName
-- from Categories
-- where [Description] LIKE '%,%'

/* Zad 5 */

-- select *
-- from Customers
-- where CompanyName LIKE '%store%'

/* Str 44/57 */

/* Zad 1 */

-- SELECT CompanyName, Country
-- from Suppliers
-- where Country in ('Japan','Italy')

/* Zad 2 */

-- select CompanyName,fax
-- from Suppliers
-- where fax is not NULL

/* Zad 3 */

-- SELECT *
-- from Orders
-- where (ShippedDate is null or GETDATE() < ShippedDate) and ShipCountry='Argentina'





/* Sortowania */

-- select *
-- from Suppliers
-- ORDER by Suppliers.SupplierID desc

/* Distinct -> Odnosi sie do calego wyrazenia*/

-- SELECT distinct Country,City
-- from Suppliers
-- ORDER by Country

/* Zmiana nazw kolumnn*/

-- SELECT  City as 'ELO'
-- from Suppliers
-- ORDER by Country

/* Dodatkowy teks */

-- SELECT FirstName,LastName,'ID Number: ',EmployeeID
-- from Employees

/* Kolumny wyliczane */

-- select OrderID,UnitPrice,UnitPrice*1.05 as 'newunitprice' 
-- from [Order Details]

/* Dodawanie Kolumn */

-- select firstname + ' ' +LastName as 'Imie i nazwisko'
-- from [Employees]
