--Seiten 	8192 bytes davon 8060 Nutzlast 
--i.d.R musss ein DS reinpassen

--8 Seiten am Stück sind ein Block



create table t1 (sp1 char(4100), id int identity)
GO


insert into t1  values ('XY')
GO 20000	--Zeit sek 


																    haben immer 8192 

dbcc showcontig ('t1')
--- Gescannte Seiten.............................: 20000
-- Mittlere Seitendichte (voll).....................: 50.79%

--beheben: Datentyp , Kompression (40-60%)	, echts DB Redesign

--ZIEL: reduziere Seiten




--HDD!



	create table t5 (sp1 char(4100), id int identity)
GO



 declare @i as int = 1
Begin tran
 while @i <= 20000
 begin 
	
	insert into t5 select @i
	set @i+=1
 end
commit


select * from customers c 
	inner join orders o on 
			c.customerid = o.customerid



select * from customers c 
	inner hash join orders o on 
			c.customerid = o.customerid




select * from customers c 
	inner loop join orders o on 
			c.customerid = o.customerid


--Merge	 join
--nested Loop
--hash join

