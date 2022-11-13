# NULL und dreiwertige Logik

Seit wir mit Datenbanken arbeiten, haben wir es auch mit Spalten zu tun gehabt, die den Wert
NULL haben können. Das fällt schon auf, wenn wir in einer *WHERE* Bedingung *IS NULL* bzw.
*IS NOT NULL* verwenden müssen, und nicht einfach mit *= NULL* vergleichen können.

Es gibt aber noch andere Fälle, wo ein NULL Wert scheinbar seltsame Ergebnisse liefert. Lege dafür
die folgende Datenbank in SQL Server (HIF) oder Oracle (Kolleg) an.

In *Oracle* öffne zuerst die Shell des Containers und lege den User NullDemoDb an:

```bash
sqlplus system/oracle@//localhost/XEPDB1 <<< "
    DROP USER NullDemoDb CASCADE;
    CREATE USER NullDemoDb IDENTIFIED BY oracle;
    GRANT CONNECT, RESOURCE, CREATE VIEW TO NullDemoDb;
    GRANT UNLIMITED TABLESPACE TO NullDemoDb;
"
```

Verbinde dich dann mit dem SQL Editor zur Datenbank und führe das folgende Skript aus:

<details>
<summary>Skript für SQL Server anzeigen</summary>

```sql
USE master
GO
-- Prevent 'database is in use' error when deleting.
IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = N'NullDemoDb')
BEGIN
    ALTER DATABASE NullDemoDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE NullDemoDb;
END;
GO
CREATE DATABASE NullDemoDb
GO
USE NullDemoDb
GO

CREATE TABLE Patient (
    Id             INTEGER PRIMARY KEY,
    Name           VARCHAR(100) NOT NULL,
    Healthy        CHAR(1),
    Investigations INTEGER,
    Operations     INTEGER,
    Diseases       INTEGER
);

CREATE TABLE DiseasesClass (
    Id            INTEGER PRIMARY KEY,
    DiseasesCount INTEGER,
    Condition     VARCHAR(20)
);

INSERT INTO Patient VALUES (1, 'Hans',   'Y',    NULL, 0,    3);
INSERT INTO Patient VALUES (2, 'Werner',  NULL,  2,    2,    2);
INSERT INTO Patient VALUES (3, 'Thomas', 'N',    0,    0,    NULL);
INSERT INTO Patient VALUES (4, 'Susi',   'N',    NULL, 2,    2);
INSERT INTO Patient VALUES (5, 'Alex',    NULL,  1,    NULL, NULL);
INSERT INTO Patient VALUES (6, 'Kurt',   'Y',    2,    NULL, 1);
INSERT INTO Patient VALUES (7, 'Max',    'Y',    NULL, NULL, NULL);

INSERT INTO DiseasesClass VALUES (1, NULL, 'NOT APPLICABLE');
INSERT INTO DiseasesClass VALUES (2, 0,    'GOOD');
INSERT INTO DiseasesClass VALUES (3, 1,    'OK');
INSERT INTO DiseasesClass VALUES (4, 2,    'POOR');
INSERT INTO DiseasesClass VALUES (5, 3,    'BAD');
INSERT INTO DiseasesClass VALUES (6, 4,    'VERY BAD');
```
</details>

<details>
<summary>Skript für Oracle anzeigen</summary>

```sql
CREATE TABLE Patient (
    Id             INTEGER PRIMARY KEY,
    Name           VARCHAR2(100) NOT NULL,
    Healthy        CHAR(1),
    Investigations INTEGER,
    Operations     INTEGER,
    Diseases       INTEGER
);

CREATE TABLE DiseasesClass (
    Id            INTEGER PRIMARY KEY,
    DiseasesCount INTEGER,
    Condition     VARCHAR2(20)
);

INSERT INTO Patient VALUES (1, 'Hans',   'Y',    NULL, 0,    3);
INSERT INTO Patient VALUES (2, 'Werner',  NULL,  2,    2,    2);
INSERT INTO Patient VALUES (3, 'Thomas', 'N',    0,    0,    NULL);
INSERT INTO Patient VALUES (4, 'Susi',   'N',    NULL, 2,    2);
INSERT INTO Patient VALUES (5, 'Alex',    NULL,  1,    NULL, NULL);
INSERT INTO Patient VALUES (6, 'Kurt',   'Y',    2,    NULL, 1);
INSERT INTO Patient VALUES (7, 'Max',    'Y',    NULL, NULL, NULL);

INSERT INTO DiseasesClass VALUES (1, NULL, 'NOT APPLICABLE');
INSERT INTO DiseasesClass VALUES (2, 0,    'GOOD');
INSERT INTO DiseasesClass VALUES (3, 1,    'OK');
INSERT INTO DiseasesClass VALUES (4, 2,    'POOR');
INSERT INTO DiseasesClass VALUES (5, 3,    'BAD');
INSERT INTO DiseasesClass VALUES (6, 4,    'VERY BAD');
```
</details>

Die Datenbank speichert eine Tabelle *Patient*, die die Anzahl der Untersuchungen (*Investigations*),
Operationen (*Operations*) Erkrankungen (*Diseases*) speichert.
Je nach Anzahl der Erkrankungen wird der Zustand (*Condition*) der Person festgelegt.

![](patient_diseases_1442.png)

## NULL ist nicht 0

Betrachten wir eine Tabelle *Measurements*, die z. B. Messwerte der Temperatur speichert.
Am 11.11.2022 um 12:00 UTC wurden 0° gemessen. Um 13:00 fiel aber der Sensor aus, d. h. es
konnte kein Messwert übertragen werden. Wir wissen daher nicht, wie hoch die Temperatur um diese
Zeit gesesen ist. Daher können wir nur den Wert *NULL* speichern.

**Tabelle Measurements**

| StationId | Date                 | Temperature |
| --------- | -------------------- | ----------- |
| 11082     | 2022-11-11T12:00:00Z | 0           |
| 11082     | 2022-11-11T13:00:00Z | NULL        |

> NULL bedeutet "nicht gemessen" oder "unbekannt". Es könnte jeder beliebige Wert gewesen sein,
> nur haben wir ihn eben nicht bestimmt.

Dadurch dürfen wir NULL nicht einfach durch 0 ersetzen, denn sonst hätte der Datensatz um 13:00 UTC
eine andere Aussage (es sind 0° gemessen worden). Auch das Ersetzen durch andere Werte (z. B. -999)
ist kritisch, da bei einer Berechnung des Mittelwertes diese Zahlen mit einbezogen werden.

## NULL als Abfragekriterium

Fragen wir ab, wie viele Patienten gesund sind (Spalte *Healthy*), erhalten wir wie erwartet
3 Patienten als Antwort:

```sql
SELECT * FROM Patient WHERE Healthy = 'Y';

-- | Id | Name | Healthy | Investigations | Operations | Diseases |
-- |----|------|---------|----------------|------------|----------|
-- | 1  | Hans | Y       | NULL           | 0          | 3        |
-- | 6  | Kurt | Y       | 2              | NULL       | 1        |
-- | 7  | Max  | Y       | NULL           | NULL       | NULL     |
```

Die nächste Abfrage liefert aber ein nicht so vorhersehbares Ergebnis. Wir fragen ab,
welche Patienten *Healthy ungleich Y* haben.

```sql
SELECT * FROM Patient WHERE Healthy <> 'Y';

-- | Id | Name   | Healthy | Investigations | Operations | Diseases |
-- |----|--------|---------|----------------|------------|----------|
-- | 3  | Thomas | N       | 0              | 0          | NULL     |
-- | 4  | Susi   | N       | NULL           | 2          | 2        |
```

Wir bekommen *nur 2 Patienten* als Ergebnis, nämlich alle mit dem Wert *Healthy = N*. Dieses Verhalten
sorgt oft für Verwirrung. Vergleichen wir dafür folgendes Snippet in Java:

```java
String x = "x", y = null;

if (!x.equals(y))
    System.out.println("x is not equal to y.");
else
    System.out.println("x is equal to y.");
```

Die Ausgabe ist *x is not equal to y*. Der Compiler sagt also x und y sind ungleich, wenn
x den Wert "x" und y den Wert *null* hat. Datenbanken haben eine *dreiwertige Logik*. Das bedeutet, dass neben
*true* und *false* noch der Wert *nulll* existiert.

> Merke: In Datenbanken liefern Vergleiche mit *NULL* auch als Ergebnis den Wert *NULL*.

So liefert der Ausdruck *HEALTHY <> 'Y'* für alle Spalten, die den Wert NULL in *Healthy* haben,
auch den Wert *NULL* als Ergebnis.

> Die WHERE Bedingung liefert nur Datensätze, wo das Kriterium *true* liefert und nicht *null*
> oder *false*.

Möchten wir also auch die Patienten ausgeben, die für *Healthy* den Wert *NULL* haben, müssen
wir folgende Abfrage schreiben:

```sql
SELECT * FROM Patient WHERE Healthy <> 'Y' OR Healthy IS NULL;
```

Die *WHERE* Bedingung liefert beim Wert *NULL* durch den Ausdruck *OR Healthy IS NULL* eindeutig
*true* und daher wird die Zeile ausgegeben.

## Die Funktion COALESCE

Die Funktion COALESCE (Aussprache [kəʊəˈles], siehe https://de.pons.com/%C3%BCbersetzung/englisch-deutsch/coalesce)
bedeutet verbinden oder vereinigen. Sie liefert den ersten Parameter, der nicht NULL ist.

```
COALESCE(1,    NULL)   liefert 1
COALESCE(NULL, 2)      liefert 2
COALESCE(1,    2)      liefert 1
COALESCE(NULL, NULL)   liefert NULL
```

Setzen wir sie nun in SQL ein, können wir für jeden Wert in *Healthy*, der NULL ist, einfach den
Wert *?* erzeugen. Hat *Healthy* einen Wert, der nicht *NULL* ist, nimmt COALESCE den ersten Parameter,
also den Wert in *Healthy*.

```sql
SELECT * FROM Patient WHERE COALESCE(Healthy, '?') <> 'Y';

-- | Id | Name   | Healthy | Investigations | Operations | Diseases |
-- |----|--------|---------|----------------|------------|----------|
-- | 2  | Werner | NULL    | 2              | 2          | 2        |
-- | 3  | Thomas | N       | 0              | 0          | NULL     |
-- | 4  | Susi   | N       | NULL           | 2          | 2        |
-- | 5  | Alex   | NULL    | 1              | NULL       | NULL     |
```

Diese Abfrage liefert 4 Patienten, nämlich alle die *N* oder *NULL* in der Spalte *Healthy* haben.

Alle Parameter von COALESCE müssen vom selben Typ oder implizit umzuwandeln sein. Wollen wir
z. B. ein Fragezeichen statt dem Wert NULL in *Diseases* (eine INTEGER Spalte) schreiben,
müssen wir einen expliziten Cast durchführen:

```sql
-- SQL Server
SELECT p.Id, p.Name, COALESCE(CAST(p.Diseases AS VARCHAR), '?') FROM Patient p;

-- Oracle
SELECT p.Id, p.Name, COALESCE(TO_CHAR(p.Diseases), '?') FROM Patient p;
```
## NULL in Berechnungen

In Berechnungen ist das Ergebnis *NULL*, wenn ein Operand *NULL* ist:

```sql
SELECT Id, Diseases, Operations,
    Diseases + 1,
    Diseases - Operations,
    0 * Diseases
FROM Patient;

-- | Id  | Diseases | Operations | Diseases + 1 | Diseases - Operations | 0 * Diseases |
-- | --- | -------- | ---------- | ------------ | --------------------- | ------------ |
-- | 1   | 3        | 0          | 4            | 3                     | 0            |
-- | 2   | 2        | 2          | 3            | 0                     | 0            |
-- | 3   | NULL     | 0          | NULL         | NULL                  | NULL         |
-- | 4   | 2        | 2          | 3            | 0                     | 0            |
-- | 5   | NULL     | NULL       | NULL         | NULL                  | NULL         |
-- | 6   | 1        | NULL       | 2            | NULL                  | 0            |
-- | 7   | NULL     | NULL       | NULL         | NULL                  | NULL         |
```

## NULL in Gruppenfunktionen und Listen

Gruppenfunktionen bearbeiten eine *Liste von Werten*. Wir sehen uns daher an, wie diese Funktionen
reagieren, wenn in der Werteliste ein oder mehrere Werte mit NULL vorkommen.

### In COUNT

Wird in der Funktion *COUNT* eine Spalte angegeben, werden nur Werte gezählt, die nicht NULL
sind.

```sql
SELECT COUNT(*) AS RowsTotal, COUNT(Healthy) AS RowsHealthy, COUNT(*) - COUNT(Healthy) AS RowsHealthyNull
FROM Patient;

-- RowsTotal    RowsHealthy    RowsHealthyNull
-- 7            5              2
```

### In MAX/MIN/AVG

NULL Werte werden einfach ignoriert.

```sql
SELECT
    AVG(Diseases) AS AvgDiseases, MIN(Diseases) AS MinDiseases, MAX(Diseases) AS MaxDiseases
FROM Patient;

-- AvgDiseases    MinDiseases    MaxDiseases
-- 2              1              3
```

Sind alle Werte NULL, liefern diese Funktionen auch NULL:

```sql
SELECT
    AVG(Diseases) AS AvgDiseases, MIN(Diseases) AS MinDiseases, MAX(Diseases) AS MaxDiseases
FROM Patient
WHERE Diseases IS NULL;

-- AvgDiseases    MinDiseases    MaxDiseases
-- NULL              NULL           NULL
```

### IN Operator

Die folgende Abfrage wird nur Patienten, die den Wert 1 in *Diseases* haben liefern. Es kommen
keine Datensätze mit dem Wert NULL in Diseases vor. Der Grund ist schon bei WHERE erklärt:
Der IN Operator fragt ab, ob der Wert der Spalte dem 1. oder 2. oder 3. ... Element der Liste
entspricht. Es wird also wieder ein Vergleich durchgeführt. Da Vergleiche mit NULL nicht *true*
sondern *NULL* liefern, erscheinen diese Werte auch nicht im Ergebnis.

```sql
SELECT * FROM Patient WHERE Diseases IN (NULL, 1);

-- Id    Name    Healthy    Investigations    Operations    Diseases
-- 6     Kurt    Y          2                  NULL         1
```

Mit *COALESCE* könnten wir den Wert NULL auf z. B. -1 abbilden und so die Patienten ausgeben,
die NULL oder 1 in der Spalte Diseases haben:

```sql
SELECT * FROM Patient WHERE COALESCE(Diseases, -1) IN (-1, 1);

-- | Id | Name   | Healthy | Investigations | Operations | Diseases |
-- |----|--------|---------|----------------|------------|----------|
-- | 3  | Thomas | N       | 0              | 0          | NULL     |
-- | 5  | Alex   | NULL    | 1              | NULL       | NULL     |
-- | 6  | Kurt   | Y       | 2              | NULL       | 1        |
-- | 7  | Max    | Y       | NULL           | NULL       | NULL     |
```
## NULL in JOIN Operationen

JOIN Operationen, wo eine Spalte NULL sein kann, wurden in den Übungen schon oft durchgeführt.
Normalerweise wird ein JOIN über die Verknüpfung *Primärschlüssel von A = Fremdschlüssel in B*
durchgeführt. Fremdschlüssel können aber auch NULL sein.

![](join_with_null_1359.png)

Die 4AHIF kommt im Ergebnis nicht vor, da sie als Stammraum (*RoomId*) den Wert NULL hat. Daher
findet sich kein Id Wert in der Tabelle *Room*. Dieses Verhalten entspricht auch dem, was wir
erwarten.

Was aber, wenn zwei NULL Werte im Join aufeinandertreffen? In der Tabelle *Patient* wird die
Anzahl der Erkrankungen (*Diseases*) gespeichert. In der Tabelle *DiseasesClass* wird die
Anzahl auf eine Kategorie (*Condition*) abgebildet:
(NULL = NOT APPLICABLE, 0 = GOOD, 1 = OK, 2 = POOR, 3 = BAD, ...).

Wollen wir nun die Condition für jeden Patienten angeben, können wir einen JOIN ausführen.
Die Join Bedingung ist dann *Patient.Diseases = DiseasesClass.DiseasesCount*. Da die JOIN
Bedingung wie eine *WHERE* Klausel zu behandeln ist, können wir schon vermuten, dass die Patienten
mit dem Wert *NULL* in *Diseases* nicht ausgegeben werden. NULL ist schließlich mit nichts gleich.

![](patient_diseases_join_1440.png)

```sql
SELECT p.Id, p.Name, p.Diseases, d.Condition
FROM Patient p INNER JOIN DiseasesClass d ON (p.Diseases = d.DiseasesCount);

-- | Id | Name   | Diseases | Condition |
-- |----|--------|----------|-----------|
-- | 1  | Hans   | 3        | BAD       |
-- | 2  | Werner | 2        | POOR      |
-- | 4  | Susi   | 2        | POOR      |
-- | 6  | Kurt   | 1        | OK        |
```

Wenn wir also die NULL Spalten verknüpfen wollen, können wir mittels *COALESCE* diesen NULL Werten
für den Vergleich z. B. den Wert -1 zuordnen. Danach kann verglichen werden:

```sql
SELECT p.Id, p.Name, p.Diseases, d.Condition
FROM Patient p INNER JOIN DiseasesClass d ON (COALESCE(Diseases,-1) = COALESCE(DiseasesCount,-1));

-- | Id | Name   | Diseases | Condition      |
-- |----|--------|----------|----------------|
-- | 1  | Hans   | 3        | BAD            |
-- | 2  | Werner | 2        | POOR           |
-- | 3  | Thomas | NULL     | NOT APPLICABLE |
-- | 4  | Susi   | 2        | POOR           |
-- | 5  | Alex   | NULL     | NOT APPLICABLE |
-- | 6  | Kurt   | 1        | OK             |
-- | 7  | Max    | NULL     | NOT APPLICABLE |
```

Eine bessere Lösung ist allerdings die, dass wir in *DiseasesClass* keine Kategorie mit NULL
speichern, sondern diese über COALESCE und einen LEFT JOIN einfach ausgeben lassen.

```sql

SELECT p.Id, p.Name, p.Diseases,
    COALESCE(d.Condition, 'NOT APPLICABLE') AS Condition
FROM Patient p LEFT JOIN DiseasesClass d ON (p.Diseases = d.DiseasesCount);


-- | Id | Name   | Diseases | Condition      |
-- |----|--------|----------|----------------|
-- | 1  | Hans   | 3        | BAD            |
-- | 2  | Werner | 2        | POOR           |
-- | 3  | Thomas | NULL     | NOT APPLICABLE |
-- | 4  | Susi   | 2        | POOR           |
-- | 5  | Alex   | NULL     | NOT APPLICABLE |
-- | 6  | Kurt   | 1        | OK             |
-- | 7  | Max    | NULL     | NOT APPLICABLE |
```

## NULL und String Concatenation

In Oracle und SQL Server ist eine Stringverknüpfung mit einem Operator (+ oder ||) sowie über
die Funktion *CONCAT()* möglich. SQL Server liefert als Ergebnis NULL, wenn ein Teilstring NULL
ist und mit + verknüpft wird. Daher sollte die *CONCAT()* Funktion verwendet werden, sie liefert
auf jedem Datenbanksystem das selbe Ergebnis.

```sql
-- SQL Server
SELECT 'A' + NULL AS Text         -- liefert NULL
SELECT CONCAT('A', NULL) AS Text   -- liefert A

-- Oracle; da bei einem Select immer eine Tabelle angegeben werden muss, verwenden wir die
--         dummy Tabelle DUAL
SELECT 'A' || NULL AS Text FROM DUAL       -- liefert A
SELECT CONCAT('A', NULL) AS Text FROM DUAL -- liefert A
```

