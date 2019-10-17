--HDD besser nutzen


/*

 DB besteht aus meist mind 2 Dateien (mdf und ldf)

 Es ist mögich, dss wir mehr Dateien verwenden und diese auf versch HDD ablegen


*/


Create table kunden (id int) on STAMM

create table bestllungen (id int) on HOT

--Dateigruppen ..ndf dateien

--Salamitaktik

-- wir haben 2 Tabellen A und B . beide sind ablosut identisch
--aber A hat 10000 DS und B hat 1000000


--welche wird bei Abfragen schneller sein:

--11 gleich..gleich
--wohl eher die kleinere ...

--Umsatz

--u2019
--u2018
--u2017


--Partitionierte Sicht

create table u2019 (id int identity, jahr int, spx int)			   --on hdd1

create table u2018 (id int identity, jahr int, spx int)

create table u2017 (id int identity, jahr int, spx int)

create table u2016 (id int identity, jahr int, spx int)

select * from umsatz --error



create view umsatz
as
select * from u2019
UNION ALL				 -- suche nicht nach doppelten DS!!
select * from u2018
UNION ALL
select * from u2017
UNION ALL
select * from u2016


select * from umsatz where jahr = 2019			   --mist! alle tabwellen werden verwendet!!

ALTER TABLE dbo.u2016 
ADD CONSTRAINT	CK_u2016 CHECK (jahr=2016)

ALTER TABLE dbo.u2017 
ADD CONSTRAINT	CK_u2017 CHECK (jahr=2017)

ALTER TABLE dbo.u2018 
ADD CONSTRAINT	CK_u2018 CHECK (jahr=2018)
GO

ALTER TABLE dbo.u2019 
ADD CONSTRAINT	CK_u2019 CHECK (jahr=2019)
 GO

--im Plan deutlich weniger .. nur noch entpsrechende Tabellen


insert into umsatz ( id,jahr, spx) values (2,2016, 100)	 ;
GO

--		   Hallo!




--Partitionierung	  --physikalisch...


-----------100------------------200-------------------
--    1              2                      3


--partitionierungsfunktion

create partition function fZahl(int)
as
	RANGE LEFT FOR VALUES (100,200)	  ;
	GO


select $partition.fzahl(112) --> 2 



--4 DGruppen : bis100, bis200, rest bis5000

--Partionierungsschema

create partition scheme  schZahl
	as
		partition fzahl to (bis100,bis200,rest)
		--                      1     2      3

create table ptab (id int identity, nummer int, spx char(4100))
	ON schZahl(nummer)


declare @i as int = 1

while @i <=20000
	begin
		insert into ptab values(@i, 'xy')
		set @i+=1
	end


 --Messung
 --Plan: 
 --SEEK   herauspicken  schnell
 --SCAN	  A bis Z 


 select * from ptab	 where id = 112		   --imer noch scan

 set statistics io, time on
 --Anzahl der Seiten
 --in ms CPU Verbauch und Dauer
 --Kompilieraufwand

 select * from ptab where id =112
 --20000 Seiten
 --32 CPU 20 Dauer

 select * from ptab where nummer = 14		--seek auf Heap  ..einen Haufen rauspicken
 --100 Seiten 
 --0 ms

 --Cool ist aber : flexibel

 --neue Grenze: bis5000

 ---------------100-----------200---------------------split ----------------
 --  1                2                3                      

 --PSchema ändern
--F() ändern


alter partition scheme schZahl next used bis5000


select	$partition.fZahl(nummer),
		min(nummer), 
		max(nummer), 
		count(*) 
		from ptab 
	group by 
		$partition.fzahl(nummer)

alter partition function fzahl() split range (5000)


select * from ptab where nummer = 2345		    --nur noch 4800 Seiten statt 19800


--Grenze bei 100 entfernen

--F()
alter partition function fZahl() merge range (100)
--fertig

-----------200-.------5000--------


--Wo sind nun die Daten .. generiere Script (DB-Speicher_partitionierungXy


--Super coole Archivierung

--muss vom TabSchema identisch sein.. nur kein IDENTITY
create table archiv (id int not null, nummer int, spx char(4100)) on bis200

alter table ptab switch partition 1 to archiv

select * from archiv	  --verschoben

select * from ptab where nummer < 200	  --weg


--100MB /Sek
--P1 100000000000000MB...   archivierungsdauer: 0

---------------------------------------------------------------------------


 create partition function fZahl(datetime)
as
	RANGE LEFT FOR VALUES ('31.12.2017' 23:59:59.999,'','').--aufpasssen	  
	GO

--jahresweise 


  create partition function fZahl(varchar(50))
as
	RANGE LEFT FOR VALUES ('MZZZZZZZ','')--aufpasssen	  
	GO


--A bis M   N bis R   S bis Z
--


create partition scheme  schZahl
	as
		partition fzahl to ([PRIMARY],[PRIMARY],[PRIMARY])
		--                      1     2      3




































































