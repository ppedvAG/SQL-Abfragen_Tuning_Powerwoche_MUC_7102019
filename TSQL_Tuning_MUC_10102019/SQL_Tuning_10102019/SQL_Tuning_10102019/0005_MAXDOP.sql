--				
SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.RequiredDate, 
                         Orders.ShippedDate, Orders.Freight, Orders.ShipCity, Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, 
                         Employees.LastName, Employees.FirstName
INTO uk1
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID


--auf 1 MIO aufpumpen
insert into uk1
select * from uk1


--Kopie von UK1
select * into uk2 from uk1

alter table uk2 add id int identity

select top 3 * from uk2



set statistics io, time on

select * from uk2 where id < 50000
-- 594 ms, verstrichene Zeit = 1287 ms.

--ist es eigtl ok, dass er mehr CPUs verwendet?
--ja.. wenn ja wieviele?
--per default: wenn , dann alle
--sonst einen!
--alle ok?

--ab wann nimmt er mehr CPUs..?


--der Standwert von 5 SQL Dollar und 0 = alle CPus macht keinen Sinn
--besser eigtl pro Abfrage ustieren 
--aber es gaht: auf Serverniveau	, auf DB  
--


set statistics io, time on

select country,sum(unitprice*quantity) 
from customers c inner join orders o on c.customerid = o.customerid
inner join [order details] od on od.orderid = o.orderid
group by country	option (maxdop 6)











