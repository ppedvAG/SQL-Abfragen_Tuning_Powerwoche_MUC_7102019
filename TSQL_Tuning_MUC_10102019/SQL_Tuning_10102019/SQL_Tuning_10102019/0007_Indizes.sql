--Indizes

/*
CL IX
NON CL IX
-------------------------------
x eindeutiger IX
x zusammengestzter
x IX mit eingeschl. Spalten
x ind. Sicht
partitionierter IX
x gefilterten IX
x abdeckende IX		  ´(opt. Situation)
realen hypothetischer IX
------------------- nicht bei SQL 2008/12
Columnstore IX


Tatsächlich nur 3 verschiedene IX, alles andere sind mehr oder wengier Optionen.
Clustered IX  = Tabelle
NON CL IX = Strukturen auf bestehende Tabelle
Tabelle ohne CL XI = HEAP

CL = nur 1 mal pro Taballe. Daten werden physikalisch auf der Platte sortiert
abgelegt. Das ist auch der Grund , warum Daten sortiert erscheinen
bei Aufruf ohne order by ...

				 
NCL IX speichert kopierte Spaltenwerte und baut einen "Baum" darauf auf
kann es gut 1000 Stück pro Tabelle geben.

CL IX gut bei Bereichsabfragen
NCL IX gut bei geringen ? Resultset (gering = Formel kann auch weit unter 10 % liegen)
 
 */

select * from orders

select * from kunden

--PK wird per default immer als CL IX angelegt !!!
--muss aber nicht sein. PK erfordert nur Eindeutigkeit
--PK braucht man auch nur für Beziehungen


--Indizes

select * into uk3 from uk2

set statistics io, time on



select id from uk3 where id = 100
--Tab Scan  43015 Seiten ... 	   CPU-Zeit = 96 ms, verstrichene Zeit = 25 ms.

--NIX_ID    eindeutig
select id from uk3 where id = 100		 --3 Seiten --0 ms

 --aber sobald weiter Spalte gesucht wird.. Lookup
select id, city from uk3 where id = 100		 --3 Seiten --0 ms


--Lookup wegbringen

--NIX_ID_CITY		eindeutiger zusammengesetzter NGR IX
select id, city from uk3 where id = 100	

--wieder Lookup
select id, city, country  from uk3 where id = 100	
--Konsequenz?
--Idee: NIX_* 
--Gute Idee, aber: max 16 Spalten,  max 900byte

--NIX_ID_inklCICY
select id, city from uk3 where id = 100	 --kein KLookup
--es können 1023 Spalten eingeschlossen werden...
--im Gegfensatz zu IX zusamm.  16 Spalten

--select top 1 * from uk3
select id, city from uk3 where freight< 2 and orderid < 10260

--NIX_FR_OID_inkl_idci

CREATE NONCLUSTERED INDEX NIX_FROID_INKL_CIID
ON [dbo].[uk3] ([Freight],[OrderID])
INCLUDE ([City],[id])

--2 Indizes
select id, city from uk3 where freight< 1 or orderid < 10249



--gefilterter IX   auf Belin.. hat sich das gelohnt?
--Alternative_ IX mit allen Städten

select country, city, freight
from uk3
where freight < 2 and city = 'berlin'

--NIX1  NIX2
--beide machen Seek
----Anzahl der Ebenden--weniger ist besser!

 --

select country, count(*) from uk3
group by country

-- 7149,  700..136

create view v1
as
 select country, count(*) as Anzahl from uk3
group by country


select * from v1		 --gleich


alter view v1	with schemabinding
as
 select country, count_big(*) as Anzahl from dbo.uk3
group by country



select * from v1
--2 Seiten..0ms


--Frage: was wäre wenn, 1,1 Billiarden
--gleich schnell.. Archivdaten

--2 gleiche tabellen
select * into uk5 from uk2
select * into uk6 from uk2


select top 1 * from uk2

--Abfrage, spalte, agg from where 
--Anzahl aller Bestellungen pro Stadt, aber nur die wo am zwischen 1 und 31.12.1997

--GIX_Odate		..342MB 
select city, count(*) from uk5 
	where orderdate between '1.12.1996' and '31.12.1996'
	group by city


 --3,7 MB		   1:1 im RAM
select city, count(*) from uk6 
	where orderdate between '1.12.1996' and '31.12.1996'
	group by city



--DMVs

select * from sys.dm_db_index_usage_stats

--A B C
-- ABC ACB BCA BAC BCA  1032


--Brent Ozar

sp_blitzindex

EXEC dbo.sp_BlitzIndex @DatabaseName='Northwind', @SchemaName='dbo', @TableName='ptab';


ALTER TABLE [Northwind].[dbo].[ptab] REBUILD;



select * from sys.dm_db_index_physical_Stats
	(db_id(), object_id('uk2'), NULL, NULL, 'detailed')


dbcc showcontig('uk2')				 --43048

select * from uk2 where id <> 100	    ---57210	statt 43292
--forward Secrod counts-- zusätzliche Seiten in den neue Spaltendaten abgelegt werden
--kommt nur beim HEAP vor-- > CL IX!

update uk2 set freight = 10 where id = 10
--Sperren	  : alle!
--mit IX nur einen Zeilesperre


--Table SCAN vs CL IX SCAN... schneller ist: egal

--CL IX SEEK vs TABLE SCAN: CL IX SEEK
--NCL IX SEEK vs NCL IX SCAN: SEEK
--NCL IX SCAN vs TABLE SCAN: IX SCAN

--LOOKUP: IX SEEK mit LOOK auf HEAP
--        IX SEEK mit LOOK auf CL IX

--NCL IX SEEK auf HEAP



--Proc von TAG1:

alter proc gpKundensuche  @Kunde nvarchar(10) = '%'
as
select 	* from customers where customerid like @kunde + '%'


exec gpKundensuche 'A'

						 
select * from profile	 order by cpu desc


select * from customers where customerid like 'ALFKI' --ideal NCL IX SEEK


select * from customers where customerid like '%%' --SCAN ..aber nicht hier


--Warum i9st PROC gut: der Plan wir dmit dem ersten AUfruf fix kompiliert hinterlegt

dbcc freeproccache


alter proc gpidsuche @id int
as
select * from uk2 where id < @id


exec gpidsuche 1000000

--achte bei proc auf: nicht benutzerfreundlich!! mal viel mal wenig

--in der proc Verweis auf andere Proc



--F

select * from orders
	where  year(orderdate) = 1997	--scan		


select * from orders
	where  datepart(yy; orderdate) = 1997 --scan


	where birthdate < dateadd(yy, getdate() , -18)

select * from orders
	where  orderdate between '1.1.1997' and '31.12.1997 23:58:59.999'




select * from uk2 where id < 2

exec gpidsuche 2




 exec gpKundensuche 'ALFKI'

  --variablen immer größer einschätzen, da sie nur zur Hälfte berechmet werden (--> RAM)
 declare @var1 as varchar(150) ---25 zeichen

 order by 










































