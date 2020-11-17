/* Setting default database */
use library

/* Zad 1  Napisz polecenie, które wybiera wszystkie tytuły z tablicy 
title i wyświetla je w porządku alfabetycznym.*/

-- SELECT title
-- from title
-- ORDER BY title


/* Zad 2  Napisz polecenie, które:
     wybiera numer członka biblioteki, isbn książki i wartość 
    naliczonej kary  dla wszystkich wypożyczeń, dla których 
    naliczonej kary  dla wszystkich wypożyczeń, dla których 
    naliczono karę
     stwórz kolumnę wyliczeniową zawierającą podwojoną wartość 
    kolumny fine_assessed
     stwórz alias ‘double fine’ dla tej kolumny*/

-- SELECT member_no,isbn,fine_assessed, fine_assessed*2 as 'double fine'
-- from loanhist
-- where ISNULL(fine_assessed,0)>0


/* Zad 3 do modyfikacji
Napisz polecenie, które
     generuje pojedynczą kolumnę, która zawiera kolumny: imię 
    członka biblioteki, inicjał drugiego imienia i nazwisko dla 
    wszystkich członków biblioteki, którzy nazywają się Anderson
     nazwij tak powstałą kolumnę „email_name” 
     zmodyfikuj polecenie, tak by zwróciło „listę proponowanych 
    loginów e-mail”  utworzonych przez połączenie imienia członka 
    zmodyfikuj polecenie, tak by zwróciło „listę proponowanych 
    loginów e-mail”  utworzonych przez połączenie imienia członka 
    biblioteki, z inicjałem drugiego imienia i pierwszymi dwoma 
    literami nazwiska (wszystko małymi literami). 
     wykorzystaj funkcję SUBSTRING do uzyskania części kolumny 
    znakowej oraz LOWER do zwrócenia wyniku małymi literami
     wykorzystaj operator (+) do połączenia stringów.

Do modyfikacji:
*/

-- select firstname + SPACE(1) + SPACE(1) + middleinitial + SPACE(1) + lastname as 'email_name'
-- from member
-- where lastname='Anderson'


/* Zad 3 po modyfikacji */

-- SELECT LOWER(
--     LTRIM(RTRIM(firstname + middleinitial + SUBSTRING(lastname,1,2))
-- )
-- from member


/* Zad 4  Napisz polecenie, które wybiera title i title_no z tablicy 
title.
     Wynikiem powinna być pojedyncza kolumna o formacie jak w 
    przykładzie poniżej: 
        The title is: Poems, title number 7
     Czyli zapytanie powinno zwracać pojedynczą kolumnę w oparciu 
    o wyrażenie, które łączy 4 elementy:
        stała znakowa ‘The title is:’
        wartość kolumny title
        stała znakowa ‘title number’
        wartość kolumny title_no*/


/* UWAGA! 
    1sp -> Uzycie STR() 
    2sp -> Uzycie CAST()*/

-- select 'The title is: ' + title + ', title number' + STR(title_no)
-- from title


-- select 'The title is: ' + title + ', title number ' + CAST(title_no as varchar)
-- from title

