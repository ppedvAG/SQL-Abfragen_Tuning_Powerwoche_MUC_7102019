--TX	kurz und bündig

--TX --> SPERREN -- 91bytes

--Row
--Page--mehr DS gesperrt als eigtl geändert!!
--Extent--mehr Seiten (DS) gesperrrt als notwwendig
--Table
--DB

--TX dauert 5 min
----beim update Sperre angeben


set transaction isolation level read uncommitted-- neue aber nicht best Daten..

--Repeatable Read  gelesene Daten bleiben konsistent , allerdings INS möglich
--die evtl meine Abfrage ändert

--serializable..kein INS mögich

--Locks auch in Anweisungen möglich with Tablock, rowlock etc...


 --evtl gute Idee: Datensätze nicht sperren, sondern kontrolliern ob geändert wurde
 --aber nicht commitet

 --Google--> --Zeilenversionierung		 --massiv tempdb
--.in memory Tabellen

