# LEFT JOIN in SQL
```sql
-- Gegeben sind folgende 2 Tabellen. Sie existieren nicht in der DB, beantworten Sie die Fragen
-- daher aufgrund der folgenden Musterdaten:
--      Mitarbeiter                 Verkaeufe      
--      M_ID   M_Zunanme            V_ID   M_ID   V_Gesamtpreis
--  1   1001   Mustermann1          1001   1001   1000
--  2   1002   Mustermann2          1002   1001   2000
--  3   1003   Mustermann3          1003   1001   3000
--  4   1004   Mustermann4          1004   1001   4000
--  5                               1005   1001   5000

-- Wie viele Zeilen liefert
-- SELECT * FROM Mitarbeiter m INNER JOIN Verkaeufe v 
--     ON (m.M_ID = v.M_ID)?
-- 5 Datensätze für MA 1001, 0 für 1002, 0 für 1003, 0 für 1004 
-- ==> 5 Datensätze in Summe.

-- SELECT * FROM Mitarbeiter m LEFT JOIN Verkaeufe v ON (m.M_ID = v.M_ID)?
-- 5 Datensätze für MA 1001, 1 für 1002, 1 für 1003, 1 für 1004.
-- Bei 1002, 1003 und 1004 sind alle V_ Spalten NULL.

-- SELECT * FROM Verkaeufe v LEFT JOIN Mitarbeiter m 
--     ON (m.M_ID = v.M_ID)?
-- 5 Datensätze, da kein Mitarbeiter in der MA Tabelle doppelt
-- vorkommen kann.
```

```sql
-- *************************************************************************************************
-- Geben Sie alle Abteilungen samt Klassen aus.
-- Abteilung 1 und 5 wird nicht ausgegeben, da sie 
-- keine Klassen hat.
SELECT *
FROM `Abteilungen` INNER JOIN `Klassen` 
   ON (`Abt_ID` = K_Abteilung);

-- Diese Abfrage gibt immer alle Abteilungen aus, auch wenn
-- sie keine Klassen hat.  
SELECT *
FROM `Abteilungen` LEFT JOIN `Klassen` 
   ON (`Abt_ID` = K_Abteilung);
-- Die Datenbank befüllt alle Felder aus Klassen (K_Nr, ...)
-- bei Abteilungen ohne Klasse mit NULL.

-- *************************************************************************************************
-- Möchten wir wissen, welche Abteilungen keine Klassen haben,
-- filtern wir K_Nr auf NULL. K_Nr ist ist der Primärschlüssel
-- von Klasse und kann unter normalen Umständen nie NULL sein.
SELECT *
FROM Abteilungen LEFT JOIN Klassen 
   ON (Abt_ID = K_Abteilung)
WHERE K_Nr IS NULL;

-- Geht auch: Der Fremdschlüssel von Abteilungen kann auch auf
-- NULL geprüft werden.
SELECT *
FROM Abteilungen LEFT JOIN Klassen 
   ON (Abt_ID = K_Abteilung)
WHERE K_Abteilung IS NULL;

-- Falsch: K_Datumvon kann auch in der Klassentabelle NULL sein.
SELECT *
FROM Abteilungen LEFT JOIN Klassen 
   ON (Abt_ID = K_Abteilung)
WHERE K_Datumvon IS NULL;

-- Später werden wir dieses Problem auch mit Unterabfragen
-- lösen.
SELECT *
FROM Abteilungen
WHERE Abt_ID NOT IN (SELECT K_Abteilung FROM Klassen);

-- *************************************************************************************************
-- Gib alle Klassen samt Schüler und ihren Staaten aus.
-- Diese Abfrage liefert keine Ergebnisse, da die Spalte
-- S_Staatsbuergerschaft in Schueler immer NULL ist.
SELECT *
FROM Klassen INNER JOIN Schueler ON (K_Nr = S_Klasse)
             INNER JOIN Staaten ON (S_Staatsbuergerschaft = Sta_Nr);

-- Diese Abfrage liefert Daten            
SELECT *
FROM Klassen INNER JOIN Schueler ON (K_Nr = S_Klasse)
             LEFT JOIN Staaten ON (S_Staatsbuergerschaft = Sta_Nr);

-- Der LEFT JOIN am Anfrang bringt nichts, da der zweite
-- INNER JOIN die Daten wieder wegfiltert.
SELECT *
FROM Klassen LEFT JOIN Schueler ON (K_Nr = S_Klasse)
             INNER JOIN Staaten ON (S_Staatsbuergerschaft = Sta_Nr);

             
```

## Übung
Lösen Sie die Beispiele auf https://github.com/schletz/Dbi1Sem/tree/master/01_Access/Access_Uebungen#4-abfragen-aus-mehreren-tabellen-outer-join-basierend-auf-schuldb1_ablecture3accdb
in SQL.