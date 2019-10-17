--Sichten

--Logik kapseln
--



create table t2 (id int, Stadt int, land int)

insert into t2
select 1,10,100
UNION 
select 2,20,200
UNION
select 3,30,300
GO

select * from t2


create view vt2
as
select * from t2
GO


select * from vt2


alter table t2 add fluss int

update t2 set fluss = id *1000

select * from t2


select * from vt2	  --Fluss fehlt

alter table t2 drop column land



select * from vt2	  --in Land ???? stehen dioe Werte von Fluss???


--wie kann man das machen, das das nie passiert?

--schemabinding

create  view vt2 with schemabinding --Stern nicht mehr erlaubt
as
select id, stadt , land from dbo.t2

drop view vt2
drop table t2 





 create view vt3
 as
SELECT      Customers.CompanyName, Customers.ContactName, Employees.LastName, 
			Employees.FirstName, Customers.Country, Customers.City, Orders.OrderID,
			Orders.OrderDate, Products.ProductName, 
                         [Order Details].UnitPrice, [Order Details].Quantity
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID
						 

select distinct  companyname from vt3 where country = 'UK'

select companyname from customers where country = 'UK'


--Fazit: tu nie sichten zweckentfremden...
--Abfragen an sicht in der Tabellen verwendet werden aber für dioe Ausgabe unwichtig sind

--Schreibe Sichten immer mit schambinding.. kann nur noch korrekt sein









