--TX	kurz und b�ndig

--TX --> SPERREN -- 91bytes

--Row
--Page--mehr DS gesperrt als eigtl ge�ndert!!
--Extent--mehr Seiten (DS) gesperrrt als notwwendig
--Table
--DB

--TX dauert 5 min
----beim update Sperre angeben


set transaction isolation level read uncommitted-- neue aber nicht best Daten..

--Repeatable Read  gelesene Daten bleiben konsistent , allerdings INS m�glich
--die evtl meine Abfrage �ndert

--serializable..kein INS m�gich

--Locks auch in Anweisungen m�glich with Tablock, rowlock etc...


 --evtl gute Idee: Datens�tze nicht sperren, sondern kontrolliern ob ge�ndert wurde
 --aber nicht commitet

 --Google--> --Zeilenversionierung		 --massiv tempdb
--.in memory Tabellen

