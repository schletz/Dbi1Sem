# Erstellen einer Stundenplan Datenbank

1. Erstellen Sie für jede csv Datei des Archives *Stdplan20180906.zip* eine Access Tabelle. Achten 
   Sie dabei auf die Spaltenbezeichnungen, den verwendeten Datentyp und ob eine Eingabe erforderlich ist.
1. Erstellen Sie in jeder Tabelle einen geeigneten Primärschlüssel. Manche Tabellen haben schon 
   Spalten, die dafür geeignet sind. Falls nicht, legen Sie einen AutoWert mit dem Spaltennamen **ID** an.
1. Erstellen Sie Beziehungen zwischen den Tabellen. Aktivieren Sie dabei die Option 
   *Referentielle Integrität*
1. Kopieren Sie die Daten von der CSV Datei in die Access-Tabelle, indem Sie die CSV Datei in einem
   Editor öffnen. Danach kopieren Sie alles mittels `STRG+C` und `STRG+V` in die erstellte Tabelle.
   Da das Trennzeichen der Tabulator ist, wird dies als Spaltentrennung erkannt.
   
## Hinweise
- Die Datentypen und längen müssen exakt ident sein, wenn Sie eine Beziehung zwischen den Spalten herstellen.
- Der Datensatz in der Stundenplantabelle mit dem Raum *~B3.08MF~B5.09* wird ein Problem verursachen:
  Dieser Raum ist nicht in der Raumtabelle eingetragen. Beheben Sie dieses Problem durch Löschen des
  Datensatzes in der Stundenplan Tabelle.