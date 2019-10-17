--Northwind
--
--Customers (Customerid) nchar(5)

use northwind;
GO

select * from customers;
GO

--1.Aufgabe

exec gpKundenSuche 'ALFKI'

exec gpKundenSuche 'AL'		    --mit AL beginnend

exec gpKundenSuche 'A'			--mit A beginnend


/*
create proc gpKundenSuche @KundenID ....
as
....
*/



-- alle Bestellungen aus dem Jahr 1997 (orderdate)
select * from orders




--Giftliste
--Trigger










