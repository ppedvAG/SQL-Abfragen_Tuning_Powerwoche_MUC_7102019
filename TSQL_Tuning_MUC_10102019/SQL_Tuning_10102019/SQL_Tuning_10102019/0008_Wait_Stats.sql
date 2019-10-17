/*

Datentypen gut einschätzen .. nicht masslos übertreiben --> auf HDD --> RAM
DB Redesign Redundanz


DS kommen in Seiten (8192/8060)
in seite passen max 700 DS
8 zusammenhängende Seiten --> Block


--Füllgrad der Seiten
dbcc showcontig('t1')

10000000  89%


Tabellen aufteilen 
		auf Dateigruppen  -->HDD



		splitten mit part Sicht:
		 --> HDD

		Partitionierung --> HDD


MAXDOP (Plankosten)		 --> CPU

max 8 : sonst 50%







*/
--Wait_Stats-- Wichtige Systemsicht: 
--Worauf muss der SQL Server warten

--ABfrage frodert Ressource Zeit. Ab jetzt wird die Zeit gemessen
--Ressource wird frei (MEssung), nun muss CPU Arbeit erledigen, allerdings ist
--diese noch nicht bereit ....jetzt kann CPU beginnen (Messung)

--Ressource wo bist du.....
---- hier!         50ms (wait_time - siganl_time)
--CPU mach mal.......
--ok was los...... 10ms (Signal_Wait_time)
--Gesamte Wartezeit 60 ms

---ist Signal_time sehr hoch (25%) dann cpu Bottleneck

--> Script



select * from sys.dm_os_wait_Stats	  where wait_type like 'CX%'
--CPU Wartezeit (Signalzeit < 25%

--|0--------------!50ms-----30ms|