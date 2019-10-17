/*
 DB besteht aus Files (Daten und Log)
 Datenfiles bestehen aus Seiten (8192 bytes/8060 Nutzlast) und Blöcken (8 zusammenhängende Seiten)

 DB Design : Normalisierung (= Nornalfall)
   Redundanz ( ist schnell aber Pflege doppelter Daten)
   Generalisierung 


   gezielte Redundanz kann enorm beschleunigen : Rechnungssumme zB
   #temptables = Redundanz

   aber Achtung auf Seitenauslastung achten
   sehr breite Tabellen anstatt mehrerer Tabellen evtl schlechte Idee
   Kunden (140Spalten) oder Kunden (20Spalten) + Kunden Sonstiges(120Spalten)

   --dbcc shocontig()
   sys.dm_db_index_physical_Stats

   !!! Seiten kommen 1 :1 in den RAM

   daher auch Datentypen wichtig..  Nchar() oder char() oder gar varchar 




*/




