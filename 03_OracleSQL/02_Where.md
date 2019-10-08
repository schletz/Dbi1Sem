# WHERE in SQL

Ausgehend vom Dump der Schuldatenbank.

```sql
-- Ausgeben von L_Nr und L_Zuname aus Lehrer
SELECT L_Nr, L_Zuname
FROM Lehrer;

-- Ausgeben aller Spalten von Lehrer
SELECT *
FROM Lehrer;

-- Details zu Lehrer CHA
SELECT *
FROM Lehrer
WHERE L_Nr = 'CHA';

-- cha wird nicht gefunden, da es case-sensitive ist.
SELECT *
FROM Lehrer
WHERE L_Nr = 'cha';

-- AND und OR funktionieren wie in Java das && bzw. ||
SELECT *
FROM Lehrer
WHERE L_Zuname = 'Berger' OR L_Zuname = 'Hilbe';

-- Welche Lehrer beginnen mit B?
-- % ist der * in Access, es gibt keine "!
SELECT *
FROM Lehrer
WHERE L_Zuname LIKE 'B%';

-- Welche Lehrer haben keine bzw. eine Sprechstunde?
SELECT *
FROM Lehrer
WHERE l_sprechstunde_tag IS NULL;
SELECT *
FROM Lehrer
WHERE l_sprechstunde_tag IS NOT NULL;

-- Welche Lehrer haben nicht am Mittwoch Sprechstunde?
-- Das <> entspricht dem != in Java.
SELECT *
FROM Lehrer
WHERE L_Sprechstunde_Tag <> 'Mittwoch';

-- Welche Lehrer haben am Mittwoch oder Donnerstag Sprechstunde?
SELECT *
FROM Lehrer
WHERE L_Sprechstunde_Tag = 'Mittwoch' OR L_Sprechstunde_Tag = 'Donnerstag';
SELECT *
FROM Lehrer
WHERE L_Sprechstunde_Tag IN ('Mittwoch', 'Donnerstag');

-- Geben Sie das Gehalt und das Nettogehalt (-20%) des Lehrers aus.
-- Zeigen Sie nur Lehrer an, dessen Gehalt über 400 ist.
-- Mit AS können Sie Spalten umbenennen.
SELECT 
    L_Nr, L_Zuname, L_Vorname, 
    L_Gehalt AS Brutto, L_Gehalt * 0.8 AS Netto
FROM Lehrer
WHERE L_Gehalt > 400;

-- Sie können auch Funktionen verwenden, um Spalten zu vergleichen.
SELECT *
FROM Lehrer
WHERE UPPER(L_Nr) = 'CHA';

-- 1. Welche Klassen sind Kollegklassen (enthalten AIF, BIF oder KIF)
-- Ausgabe: K_NR, K_VORSTAND
-- Anzahl der Datensätze: 8
SELECT K_NR, K_VORSTAND 
FROM KLASSEN 
WHERE K_NR LIKE '%AIF%' OR K_NR LIKE '%BIF%' OR K_NR LIKE '%KIF%';


-- 2. Welche Klassen gehören zum 1. Jahrgang (1...)
-- Ausgabe: K_NR, K_VORSTAND
-- Anzahl der Datensätze: 13
SELECT K_NR, K_VORSTAND 
FROM KLASSEN 
WHERE K_NR LIKE '1%';

-- 3. Welche Klassen hat Griesmayer (GT) oder Jelinek (JEL) als Klassenvorstand?
-- Verwenden Sie zum Filtern den IN Operator.
-- Ausgabe: K_NR, K_VORSTAND
-- Anzahl der Datensätze: 5
SELECT K_NR, K_VORSTAND 
FROM KLASSEN 
WHERE K_VORSTAND IN ('GT', 'JEL');

-- 4. Welche Schuljahre beginnen im Jahr 2018
-- Ausgabe: SJA_BEZEICHNUNG, SJA_DATUMVON, SJA_DATUMBIS geordnet nach SJA_DATUMVON
-- Hinweis: Verwenden Sie die Oracle Funktion EXTRACT, wie auf 
-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions050.htm
-- beschrieben.
-- Anzahl der Datensätze: 3
SELECT SJA_BEZEICHNUNG, SJA_DATUMVON, SJA_DATUMBIS
FROM SCHULJAHRE
WHERE EXTRACT(year FROM SJA_DATUMVON) = 2018
ORDER BY SJA_DATUMVON;

-- 5. Wie lange dauern die verschiedenen Schuljahre in Monaten, wenn 1 Monat immer 30 Tage hat?
-- Runden Sie das Ergebnis auf 1 Dezimalstelle.
-- Ausgabe: SJA_BEZEICHNUNG, SJA_DATUMVON, SJA_DATUMBIS, DAUER (Spalte ist so zu benennen)
-- Hinweis: Oracle rechnet intern bei - mit Tagen.
-- Informationen zu ROUND gibt es auf https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions135.htm
-- Anzahl der Datensätze: 3
SELECT SJA_BEZEICHNUNG, SJA_DATUMVON, SJA_DATUMBIS, ROUND((SJA_DATUMBIS - SJA_DATUMVON)/30,1) AS Dauer
FROM SCHULJAHRE
ORDER BY SJA_DATUMVON;

-- 6. Welche Schüler besuchen Biomedizin- und Gesundheitstechnik?
-- Diese Schüler haben HBGM im Klassennamen.
-- Ausgabe: S_NR, S_ZUNAME, S_VORNAME, S_GESCHLECHT, S_KLASSE
-- Sortierung nach Klasse, dann nach Zuname und dann nach Vorname.
-- Anzahl der Datensätze: 50
SELECT S_NR, S_ZUNAME, S_VORNAME, S_GESCHLECHT, S_KLASSE
FROM SCHUELER
WHERE S_KLASSE LIKE '%HBGM%'
ORDER BY S_KLASSE, S_ZUNAME, S_VORNAME;

-- 7. Welche Schüler der Abteilung HIF (haben HIF in der Klassenbezeichnung) haben den Vornamen Michael
-- Ausgabe: S_NR, S_ZUNAME, S_VORNAME, S_GESCHLECHT, S_KLASSE
-- Anzahl der Datensätze: 1
SELECT S_NR, S_ZUNAME, S_VORNAME, S_GESCHLECHT, S_KLASSE
FROM SCHUELER
WHERE S_KLASSE LIKE '%HIF%' AND S_Vorname = 'Michael';

-- 8. Welche Schüler wohnen an einem „weg“ (z.B. am Rosenweg) in den Bezirken 2, 12, 21, 22 oder 23?
-- Ausgabe: S_NR, S_ZUNAME, S_VORNAME, S_POSTORT, S_STRASSE, S_HAUSNUMMER, S_POSTLEITZAHL
-- Anzahl der Datensätze: 7
SELECT S_NR, S_ZUNAME, S_VORNAME, S_POSTORT, S_STRASSE, S_HAUSNUMMER, S_POSTLEITZAHL
FROM SCHUELER
WHERE S_STRASSE LIKE '%weg' AND S_POSTLEITZAHL IN (1020, 1120, 1210, 1220, 1230);

-- 9. Welche Schüler wohnen nicht in Wien und sind vor 1993 geboren
-- Ausgabe: S_NR, S_ZUNAME, S_VORNAME, S_POSTORT, S_STRASSE, S_HAUSNUMMER, S_POSTLEITZAHL
-- Hinweis: Extrahieren Sie wieder das Jahr aus S_GEBDATUM
-- Anzahl der Datensätze: 32
SELECT S_NR, S_ZUNAME, S_VORNAME, S_STRASSE, S_HAUSNUMMER, S_POSTLEITZAHL
FROM SCHUELER
WHERE S_POSTORT <> 'Wien' AND EXTRACT(year FROM S_GEBDATUM) < 1993;

-- 10. Geben Sie die Namen der Schüler und die Länge des Vor- und Nachnamens zusammen aus.
-- Sortieren Sie die Ausgabe nach dieser Länge absteigend, also der längste Namen kommt zuerst.
-- Ausgabe: S_ZUNAME, S_VORNAME, LAENGE (Spalte ist so zu benennen)
-- Hinweis: LENGTH ist auf https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions076.htm beschrieben.
-- Anzahl der Datensätze: 484
SELECT S_ZUNAME, S_VORNAME, LENGTH(S_ZUNAME)+LENGTH(S_VORNAME) AS LAENGE
FROM SCHUELER
ORDER BY LENGTH(S_ZUNAME)+LENGTH(S_VORNAME) DESC;

-- 11. Welcher Lehrer hat ein Jahresgehalt von mehr als 9000 €? In L_GEHALT steht das Monatsgehalt,
-- und die Gehälter werden 14 mal pro Jahr ausgezahlt.
-- Ausgabe: L_NR, L_ZUNAME, L_VORNAME, JAHRESGEHALT (Spalte ist so zu benennen)
-- Sortierung nach Jahresgehalt absteigend.
-- Anzahl der Datensätze: 11
SELECT L_NR, L_ZUNAME, L_VORNAME, 14*L_GEHALT AS JAHRESGEHALT
FROM LEHRER
WHERE 14*L_GEHALT > 9000
ORDER BY L_GEHALT DESC;
```