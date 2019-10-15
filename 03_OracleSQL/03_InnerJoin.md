# INNER JOIN in SQL

Ausgehend vom Dump der Schuldatenbank (https://raw.githubusercontent.com/schletz/Dbi1Sem/master/03_OracleSQL/schuldb.sql)
werden folgende Beispiele zum Thema WHERE in SQL Developer gelöst.

![](innerJoin.png)

```sql
-- Liste alle Schüler mit Klasse und Abteilung
SELECT s.S_Nr, s.S_ZUNAME, s.S_VORNAME, k.K_NR, k.K_ABTEILUNG
FROM Schueler s INNER JOIN Klassen k ON (s.S_Klasse = k.K_Nr)
WHERE K_Abteilung = 2;

-- Liste alle Schüler mit Klasse und Abteilungsname
SELECT s.S_Nr, s.S_ZUNAME, s.S_VORNAME, k.K_NR, a.ABT_NAME
FROM Schueler s INNER JOIN Klassen k ON (s.S_Klasse = k.K_Nr)
                INNER JOIN Abteilungen a ON (k.K_ABTEILUNG = a.ABT_ID)
WHERE K_Abteilung = 2;

-- Liste alle Klassen mit KV und AV auf.
-- Besonderheit: Lehrer wird 2x verwendet, deshalb verwenden wir
-- l für den KV und l2 für den AV
SELECT k.K_NR, l.L_ZUNAME AS KVZuname, l.L_VORNAME AS KVVorname,
               l2.L_ZUNAME AS AVZuname, l2.L_VORNAME AS AVVorname
FROM Klassen k INNER JOIN Lehrer l ON (k.K_VORSTAND = l.L_NR)
               INNER JOIN Abteilungen a ON (k.K_ABTEILUNG = a.ABT_ID)
               INNER JOIN Lehrer l2 ON (a.ABT_LEITER = l2.L_NR);

-- Liste alle Klassen und ihren KV. Achtung: Eine Klasse ohne JV (NULL)
-- fällt gänzlich raus!
SELECT k.K_NR, l.L_Zuname, l.L_Vorname
FROM Klassen k INNER JOIN Lehrer l ON (k.K_VORSTAND = l.L_NR);

--    In welcher Abteilung ist der Lehrer Hesina der Abteilungsvorstand
--    Ausgabe: Abteilungen.*
select a.*
from abteilungen a inner join lehrer l on (a.abt_leiter = l.l_nr)
where l.l_zuname = 'Hesina';

--    In welchen Klassen sind Schüler aus dem 21. und 22. Wiener Gemeindebezirk.
--    Ausgabe: K_Nr, K_Jahrsem, S_Nr, S_Zuname, S_Vorname, S_Postleitzahl, S_Postort
select K_Nr, K_Jahrsem, S_Nr, S_Zuname, S_Vorname, S_Postleitzahl, S_Postort
from klassen k inner join schueler s on (k.k_nr = s.s_klasse)
where s_postleitzahl in('1210', '1220');

--    Geben Sie alle Klassen mit dem Namen der Abteilung aus.
--    Ausgabe: Klasse.*, Abt_Name
select k.*, Abt_Name
from abteilungen a inner join klassen k on (k.k_abteilung = a.abt_id);

--    Geben Sie alle Abteilungen mit Namen und Geschlecht des AV (Abteilungsvorstand) aus.
--    Ausgabe: Abteilungen.*, L_Zuname, L_Vorname, L_Geschlecht
select a.*, l_zuname, l_vorname, l_geschlecht
from lehrer l inner join abteilungen a on (l.l_nr = a.abt_leiter);

--    Geben Sie alle Klassen mit dem Namen des AV aus
--    Hinweis: Es ist ein Join zwischen 3 Tabellen nötig!
--    Ausgabe: K_Nr, L_Zuname, L_Vorname
select k_nr, l_zuname, l_vorname
from klassen k inner join abteilungen a on (k.k_abteilung = a.abt_id)
                inner join lehrer l on (a.abt_leiter = l.l_nr);

--    Geben Sie alle Schülerinnennamen (also nur weibliche) mit dem Namen der Klasse und des KV aus, falls auch dieser weiblich ist 
--    (S_Geschlecht bzw L_Geschlecht muss 2 sein)
--    Hinweis: Es ist ein Join zwischen 3 Tabellen nötig!
--    Ausgabe: S_Zuname, S_Vorname, S_Klasse, L_Zuname, L_Vorname

select s_zuname, s_vorname, s_klasse, l_zuname, l_vorname
from schueler s inner join klassen k on (s.s_klasse = k.k_nr)
                inner join lehrer l on (l.l_nr = k.k_vorstand)
where s_geschlecht = 2 and l_geschlecht = 2;
--    Geben Sie alle Klassen mit dem Namen des KV und des AV aus (trickreiche Abfrage, benötigt Lehrer 2mal)
--    Hinweis: Es ist ein Join zwischen 3 Tabellen nötig!
--    Ausgabe: K_Nr, KV_Zuname (Alias für L_Zuname des KV), KV_Vorname (Alias für L_Vorname des KV), AV_Zuname (Alias für L_Zuname des AV), AV_Vorname (Alias für L_Vorname des AV)

select k.k_nr, l.l_zuname as KV_Zuname, l.l_vorname as KV_Vorname, l2.l_zuname as AV_Zuname, l2.l_vorname as AV_Vorname
from lehrer l inner join klassen k on (k.k_vorstand = l.l_nr)
                inner join abteilungen a on (k.k_abteilung = a.abt_id)
                inner join lehrer l2 on (a.abt_leiter = l2.l_nr);

--    Geben Sie alle Klassen aus, dazu das Beginndatum und das Endedatum. Falls das Datum in der Klasse leer ist verwende den Wert aus dem Schuljahr). 
--    Hinweis: Verknüpfen Sie mit der Tabelle Schuljahre und verwenden Sie die Funktion COALESCE mit 2 geeigneten Spalten. Es wird der erste Wert ausgegeben,
--             der nicht NULL ist.
--    Ausgabe: K_Nr, Datumvon, Datumbis

select k_nr, coalesce(k_Datumvon, sja_datumvon), coalesce(k_Datumbis, sja_Datumbis)
from klassen k inner join  schuljahre s on (k.k_jahrsem = s.sja_nr);

--    Geben Sie zu den Abteilungen aus, in welchen Schuljahren sie Klassen haben.
--    Hinweis: Der JOIN mit der Tabelle Klassen filtert automatisch Fälle weg, wo keine Klasse existiert.
--    Ausgabe: Abt_Nr, Sja_Bezeichnung
select abt_nr, sja_bezeichnung
from abteilungen a inner join klassen k on (k.k_abteilung = a.abt_id)
                inner join schuljahre s on (k.k_jahrsem = s.sja_nr);

--    Geben Sie für jeden Schüler aus, wie viele Tage er/sie am Ende des jeweiligen Klassenbesuchs alt ist.
--    Hinweis: Mit - können Sie die Datumsdifferenz in Oracle ermitteln.
--    AUsgabe: S_Zuname, S_Vorname, Alter
select s_zuname, s_vorname, (coalesce(k_Datumbis, sja_datumbis)-s_gebdatum) as "Alter"
from schueler s inner join klassen k on (s.s_klasse = k.k_nr)
                inner join schuljahre sja on (k.k_jahrsem = sja.sja_nr);

--    Gibt es Fälle, wo Schüler und Lehrer den gleichen Vornamen haben
--    Hinweis: Der JOIN Ausdruck kann den Vergleich der Vornamen durchführen.
--    Ausgabe: S_Zuname, S_Vorname, L_Zuname

-- Folgendes Beispiel gibt aus, welcher KV den gleichen Vornamen wie einer
-- seiner Schüler hat.
select s_zuname, s_vorname, l_zuname
from schueler s inner join klassen k on (s.s_klasse = k.k_nr)
                inner join lehrer l on (l.l_nr = k.k_vorstand)
where s_vorname = l_vorname;

-- Dieses Beispiel gibt aus, welcher Schüler den gleichen Vornamen wie
-- irgendein Lehrer hat.
select S_Zuname, S_Vorname, L_Zuname
from schueler s inner join lehrer l on (s.s_vorname = l.l_vorname);

```

## Übung
Schreiben Sie die Übung des Punktes "Abfragen aus mehreren Tabellen (INNER JOIN, basierend auf schuldb1_ablecture3.accdb)"
unter https://github.com/schletz/Dbi1Sem/tree/master/01_Access/Access_Uebungen#3-abfragen-aus-mehreren-tabellen-inner-join-basierend-auf-schuldb1_ablecture3accdb als SQL Anweisungen in
SQL Developer.

