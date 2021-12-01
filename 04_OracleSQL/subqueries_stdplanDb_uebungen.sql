UNTERABFRAGEN, DIE EINEN WERT LIEFERN

-- AUFGABE 2
-- Wie viele Stunden haben die HIF Klassen in Deutsch, Englisch und Mathematik.
-- Als Deutsch sind die Fächer D, Dx, Dy zu werten.
-- Als Englisch sind die Fächer E1, E1x, E1y zu werten.
-- Als Mathematik sind die Fächer AM, AMx, AMy zu werten.
-- Hinweis: Verwende den IN Operator in der WHERE Klausel, um nach den Gegenständen zu filtern.
-- Ausgabe: Klasse, AnzD, AnzE, AnzAM

-- AUFGABE 3
-- Erstelle eine Liste aller Lehrer mit ihrer letzten Unterrichtsstunde (MAX von Stunde).
-- Ausgabe: L_ID, Zuname, Vorname, LetzteStdMO, LetzteStdDI, LetzteStdMI, LetzteStdDO, LetzteStdFR, LetzteStdSA



UNTERABFRAGEN MIT IN
-- AUFGABE 1
-- Welche Lehrer haben am Dienstag und am Mittwoch Unterricht? 
-- Ausgabe: Lehrer (ID), Lehrer Zuname, Lehrer Vorname, Lehrer Email

-- AUFGABE 2
-- Welche Lehrer, die Klassenvorstände einer HIF Klasse sind, unterrichten die Fächer E1 oder E1x oder E1y? Die Klassenvorstände findest du in der Tabelle Klassen.
-- Ausgabe: Lehrer (ID), Lehrer Zuname, Lehrer Vorname, Lehrer Email

-- AUFGABE 3
-- Erstelle eine Liste aller Lehrer mit der Information, an welchen Tagen und in welcher Stunde sie ein Loch im Stundenplan haben. Hinweis: Um das herauszufinden, prüfe, ob sie in der Stunde davor und in der
-- Stunde danach Unterricht haben.
-- Hinweis 2: Um alle Tage und Stunden zu bekommen (ist notwendig), erstelle vorher eine View:
-- CREATE VIEW vAlleStunden AS
-- SELECT U_Tag, U_Stunde FROM tunterricht GROUP BY U_Tag, U_Stunde
-- Ausgabe: Lehrer (ID), Zuname, Vorname, Tag, Stunde

-- AUFGABE 4
-- Am Montag wird in der 6. und 7. Stunde eine Konferenz aller POS Lehrer (unterrichten "POS*") abgehalten. 
-- Dafür braucht AV Skolud eine Liste aller POS Lehrer mit 2 zusätzlichen Spalten: die Klasse, die sie am MO in der 6. Stunde und eine Spalte, welche Klasse sie am MO in der 7. Stunde unterrichten. Dafür erstelle zuerst eine Abfrage, welche Lehrer welche Klassen am MO in der 6. Stunde unterrichten. Danach eine zweite Abfrage, welche Lehrer welche Klassen am MO in der 7. Stunde unterrichten.
-- Ausgabe: Lehrer (ID), Zuname, Vorname, Klasse am MO in der 6. Stunde, Klasse am MO in der 7. Stunde.

-- AUFGABE 5
-- Welche Englischlehrer (unterrichten die Fächer E1 oder E1x oder E1y) der HIF unterrichten auch Klassen, die nicht in der HIF sind?
-- Ausgabe: Lehrer (ID), Zuname, Vorname, Email

-- AUFGABE 6
-- Für die Englisch Matura dürfen nur Personen für die Aufsicht eingeteilt werden, die einen 5. Jahrgang in der HIF unterrichten, aber keine Englischlehrer sind 
-- (unterrichten nie ein Fach, welches E1, E1x oder E1y heißt). Welche Lehrer kommen also als Aufsicht in Frage?
-- Ausgabe: Lehrer (ID), Zuname, Vorname, Email

UNTERABFRAGEN IN FROM

-- Welche Lehrer hat eine Klasse in der letzten Stunde des Tages? Beachte, dass dies auch mehrere sein können.
-- Beispiel: Die 2BHIF hat am MI in der 7. Stunde DBI mit SZ und GRJ. Daher ist für diese Klasse am MI
-- 2BHIF  3   7   SZ    Schletz   Michael
-- 2BHIF  3   7   GRB   Gruber   Bettina
-- auszugeben.
-- Ausgabe: Klasse, Tag, LetzteStunde, Lehrer-ID, Zuname, Vorname
-- Löse das Beispiel auf 2 Arten: Einmal mit dem IN Operator in der WHERE Klausel und einmal mit einer Subquery im FROM.

-- Gib alle Klassen aus, die in den Räumen mit der meisten Kapazität und der Raumart "Stammklasse" Unterricht haben.
-- Beispiel: Raum A1.05 ist die Stammklasse mit der größten Kapazität. Daher sind alle Klassen auszugeben, die
-- in A1.05 Unterricht haben.
-- Ausgabe: Raum, Klasse
-- Löse das Beispiel auf 2 Arten: Einmal mit dem IN Operator in der WHERE Klausel und einmal mit einer Subquery im FROM.

-- Es soll eine Liste erstellt werden, die die Anzahl der Unterrichtsstunden der Lehrer pro Wochentag ausgibt. 
-- Da in der Stundenplan Tabelle jedoch für eine Stunde mehrere Datensätze vorhanden sein können (Religion wird
-- manchmal mit mehreren Klassen kombiniert), müssen diese Datensätze zuerst zusammengeführt werden.
-- Ausgabe: Lehrer-ID, Zuname, Vorname, Email, Tag, Anzahl der Stunden

-- Wie viele Freistunden hat ein Lehrer pro Tag? Dafür ermittle alle Stunden, wobei pro Lehrer, Tag und Stunde
-- nur 1 Datensatz zurückgegeben werden darf. Danach berechne mit der Formel LetzteStunde-ErsteStunde+1-AnzahlStunden
-- den korrekten Wert.
-- Ausgabe: Lehrer-ID, Zuname, Vorname, Email, Tag, Anzahl der Freistunden

-- Es soll eine Liste erstellt werden, die die Anzahl der Unterrichtsstunden jeder Klasse pro Wochentag ausgibt. 
-- Da in der Stundenplan Tabelle jedoch für eine Stunde mehrere Datensätze vorhanden sein können (eine Klasse hat
-- mehrere Lehrer pro Fach), müssen diese Datensätze zuerst zusammengeführt werden.
-- Ausgabe: Klasse, Tag, Anzahl der Stunden

-- Zu jener Klasse, die die meisten Stunden pro Tag hat, soll der Lehrer der letzten Stunde ausgegeben werden.
-- Beispiel: Am Montag hat die Klasse X 8 Stunden, die Klasse Y 7 Stunden und die Klasse Z auch 8 Stunden.
-- Dann soll zur Klasse X und zur Klasse Y der Lehrer am Montag in der 8. Stunde ausgegeben werden.
-- Ausgabe: Klasse, Stunde, Lehrer-ID, Fach

