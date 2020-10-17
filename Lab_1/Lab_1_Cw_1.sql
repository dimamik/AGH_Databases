/* Setting default database */
use library
/* Lab 1 Cw_Koncowe 17.10.2020*/

/*Zad 1 Przyjmujac ze title_no - numer ksiazki
Napisz polecenie select, za pomocą którego uzyskasz tytuł 
i numer książki*/

-- select title,title_no from title


/*Zad 2 Napisz polecenie, które wybiera tytuł o numerze 10*/

-- select title
-- from title
-- where title_no=10


/*Zad 3 Napisz polecenie, które wybiera numer czytelnika i karę 
dla tych czytelników, którzy mają kary między $8 a $9*/

-- select member_no, fine_assessed
-- from loanhist
-- where fine_assessed>=8 and fine_assessed<=9

/* Zad 3 Sposob 2 */

-- select member_no, fine_assessed
-- from loanhist
-- where fine_assessed between 8 and 9


/*Zad 4 Napisz polecenie select, za pomocą którego uzyskasz 
numer książki i autora dla wszystkich książek, których 
autorem jest Charles Dickens lub Jane Austen*/

-- select title_no, author
-- from title
-- where author='Charles Dickens' or author='Jane Austen'


/*Zad 5 Napisz polecenie, które wybiera numer tytułu i tytuł dla 
wszystkich rekordów zawierających string „adventures” 
gdzieś w tytule.*/

-- select title_no, title
-- from title
-- where title like '%adventures%'


/*Zad 6  Napisz polecenie, które wybiera numer czytelnika, karę 
oraz zapłaconą karę dla wszystkich, którzy jeszcze nie zapłacili.
UWAGA! Zakladam ze dane nie zostaja odswiezone
*/

-- select member_no, fine_assessed, fine_paid
-- from loanhist
-- where ISNULL(fine_assessed,0) > ISNULL(fine_paid,0) + ISNULL(fine_waived,0)


/*Zad 7 Napisz polecenie, które wybiera wszystkie unikalne pary 
miast i stanów z tablicy adult.*/

-- select DISTINCT city, state
-- from adult