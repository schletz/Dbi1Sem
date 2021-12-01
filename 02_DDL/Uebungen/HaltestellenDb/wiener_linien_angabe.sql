-- *************************************************************************************************
-- 2. PRÜFUNG IN SQL: CREATE TABLE
--
-- NAME:   (ZUNAME) (Vorname)
-- Klasse: 3CAIF
-- *************************************************************************************************

-- Nur für SQLite
PRAGMA foreign_keys = ON;

-- *************************************************************************************************
-- CREATE TABLE ANWEISUNGEN
-- Fügen Sie hier Ihre Anweisungen ein.
-- *************************************************************************************************

DROP TABLE Steig;
DROP TABLE Haltestelle;
DROP TABLE Linie;

CREATE TABLE Linie (

);


CREATE TABLE Haltestelle (

);

CREATE TABLE Steig (

);

-- *************************************************************************************************
-- INSERT ANWEISUNGEN ZUM PRÜFEN DER TABELLEN
-- *************************************************************************************************
--
-- TABELLE LINIE
--
-- Diese Anweisungen sollen funktionieren:
DELETE FROM Steig;
DELETE FROM Haltestelle;
DELETE FROM Linie;
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Verkehrsmittel)
    VALUES (214433717,	'D',	10,		'ptTram');
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Echtzeit,Verkehrsmittel) 
    VALUES (214433687,	'U1',	1,	1,	'ptMetro');

-- Diese Anweisungen schlagen fehl:
-- PK Constraint:  Abort due to constraint violation (UNIQUE constraint failed: Linie.Linien_id)
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Echtzeit,Verkehrsmittel)
    VALUES (214433717,	'100A',	10,		1,		'ptTram');
-- Bezeichnung NULL: Abort due to constraint violation (NOT NULL constraint failed: Linie.Bezeichnung)
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Echtzeit,Verkehrsmittel)
    VALUES (1,			NULL,	10,		1,		'ptTram');   
-- Reihenfolge NULL: Abort due to constraint violation (NOT NULL constraint failed: Linie.Reihenfolge)
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Echtzeit,Verkehrsmittel)
    VALUES (2,			'102A',	NULL,	1,		'ptTram');   
-- Echtzeit NULL: Abort due to constraint violation (NOT NULL constraint failed: Linie.Echtzeit)
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Echtzeit,Verkehrsmittel) 
	VALUES (3,			'103A',	112,	NULL,	'ptBusCity');
-- Verkehrsmittel NULL: Abort due to constraint violation (NOT NULL constraint failed: Linie.Verkehrsmittel)
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Echtzeit,Verkehrsmittel)
    VALUES (4,			'104A',	10,		1, 		NULL);
-- Bezeichnung nicht eindeutig:  Abort due to constraint violation (UNIQUE constraint failed: Linie.Bezeichnung)
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Echtzeit,Verkehrsmittel)
    VALUES (5,			'D',	10,		1,		'ptTram');
-- Reihenfolge NULL: Abort due to constraint violation (NOT NULL constraint failed: Linie.Reihenfolge)
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Echtzeit,Verkehrsmittel)
    VALUES (6,			'106A',	NULL,	1,		'ptTram');
-- Verkehrsmittel falsch: Abort due to constraint violation (CHECK constraint failed: Linie)
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Echtzeit,Verkehrsmittel) 
	VALUES (7,			'107A',	112,	1,		'invalid');
-- Echtzeit falsch:  Abort due to constraint violation (CHECK constraint failed: Linie)
INSERT INTO Linie (Linien_id,Bezeichnung,Reihenfolge,Echtzeit,Verkehrsmittel) 
	VALUES (8,			'108A',	112,	2,		'ptBusCity');

-- Korrekte Ausgabe
-- |Linien_id|Bezeichnung|Reihenfolge|Echtzeit|Verkehrsmittel|
-- |---------|-----------|-----------|--------|--------------|
-- |214433687|U1         |1          |1       |ptMetro       |
-- |214433717|D          |10         |0       |ptTram        |
SELECT * FROM Linie l ORDER BY l.Linien_id;

--
-- TABELLE HALTESTELLE
--
-- Diese Anweisungen sollen funktionieren:
DELETE FROM Steig;
DELETE FROM Haltestelle;
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (345540619,'Absberggasse','Wien',90001,NULL,NULL);
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (378056605,'Hlawkagasse','Wien',90001,48.1791264615246,16.3828722805315);
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (214666497,'Oberlaa','Wien',90001,48.142442551082,16.3999582372354);
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (230828919,'Neulaa','Wien',90001,48.1457452971493,16.3864835079736);
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (230828920,'Neulaa','Klosterneuburg',90002,NULL,NULL);
   
-- Diese Anweisungen schlagen fehl: 
-- PK Constraint: Abort due to constraint violation (UNIQUE constraint failed: Haltestelle.Haltestellen_id)
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (345540619,	'Spengergasse',	'Wien'	,90001,	48.1759576523513,	16.3906067751277);
-- Name NULL Constraint
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (1,			NULL,			'Wien',	90001,	48.1759576523513,	16.3906067751277);
-- Gemeinde NULL Constraint: Abort due to constraint violation (NOT NULL constraint failed: Haltestelle.Gemeinde)
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (2,			'Spengergasse',	NULL,	90001,	48.1759576523513,	16.3906067751277);
-- Gemeinde_id NULL Constraint:  Abort due to constraint violation (NOT NULL constraint failed: Haltestelle.Gemeinde_id)
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (3,			'Spengergasse',	'Wien',	NULL,	48.1759576523513,	16.3906067751277);
-- WGS Koordinaten - beide müssen NULL oder NOT NULL sein: Abort due to constraint violation (CHECK constraint failed: Haltestelle)
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (4,			'Spengergasse',	'Wien',	90001,	NULL,				16.3906067751277);
-- Selber Haltestellenname in der Gemeinde:  Abort due to constraint violation (UNIQUE constraint failed: Haltestelle.Name, Haltestelle.Gemeinde_id)
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (5,			'Neulaa',		'Wien',	90001,	48.1457452971493,	16.3864835079736);
-- Ungültige Gemeindekennzahl (6 Stellen):  Abort due to constraint violation (CHECK constraint failed: Haltestelle)
INSERT INTO Haltestelle (Haltestellen_id,Name,Gemeinde,Gemeinde_id,Wgs84_lat,Wgs84_lon)
    VALUES (6,			'Linz',			'Linz',	100000,	48.1759576523513,	16.3906067751277);   
   
-- Korrekte Ausgabe
-- |Haltestellen_id|Name|Gemeinde|Gemeinde_id|Wgs84_lat|Wgs84_lon|
-- |---------------|----|--------|-----------|---------|---------|
-- |214666497|Oberlaa|Wien|90001|48.142442551082|16.3999582372354|
-- |230828919|Neulaa|Wien|90001|48.1457452971493|16.3864835079736|
-- |230828920|Neulaa|Klosterneuburg|90002|||
-- |345540619|Absberggasse|Wien|90001|||
-- |378056605|Hlawkagasse|Wien|90001|48.1791264615246|16.3828722805315|

SELECT * FROM Haltestelle h ORDER BY h.Haltestellen_id;

--
-- TABELLE STEIG
--
-- Diese Anweisungen funktionieren. Achten Sie darauf, dass die Haltestellen und Linien
-- zuvor eingefügt wurden.
DELETE FROM Steig;
INSERT INTO Steig (Steig_id,Fk_linien_id,Fk_haltestellen_id,Richtung,Reihenfolge,Steig)
	VALUES (378112298,	214433717,	345540619,	'H',	1,	NULL);
INSERT INTO Steig (Steig_id,Fk_linien_id,Fk_haltestellen_id,Richtung,Reihenfolge,Steig)
	VALUES (231116889,	214433687,	214666497,	'H',	1,	'U1-H');

-- Diese Anweisungen funktionieren nicht.
-- PK Constraint: Abort due to constraint violation (UNIQUE constraint failed: Steig.Steig_id)
INSERT INTO Steig (Steig_id,Fk_linien_id,Fk_haltestellen_id,Richtung,Reihenfolge,Steig) 
    VALUES (378112298,	214433717,	345540619,	'H',	1,	NULL);
-- Fk_linien_id darf nicht null sein:  Abort due to constraint violation (NOT NULL constraint failed: Steig.Fk_linien_id)
INSERT INTO Steig (Steig_id,Fk_linien_id,Fk_haltestellen_id,Richtung,Reihenfolge,Steig) 
    VALUES (1,			NULL,		214666497,	'H',	1,	'U1-H');
-- Fk_haltestellen_id darf nicht null sein: Abort due to constraint violation (NOT NULL constraint failed: Steig.Fk_haltestellen_id)
INSERT INTO Steig (Steig_id,Fk_linien_id,Fk_haltestellen_id,Richtung,Reihenfolge,Steig) 
    VALUES (2,			214433717,	NULL,		'H',	1,	'U1-H');
-- Fk_linien_id als Foreign Key: Abort due to constraint violation (FOREIGN KEY constraint failed)
INSERT INTO Steig (Steig_id,Fk_linien_id,Fk_haltestellen_id,Richtung,Reihenfolge,Steig) 
    VALUES (3,			0,			345540619,	'H',	1,	NULL);
-- Fk_haltestellen_id als Foreign Key: Abort due to constraint violation (FOREIGN KEY constraint failed)
INSERT INTO Steig (Steig_id,Fk_linien_id,Fk_haltestellen_id,Richtung,Reihenfolge,Steig) 
    VALUES (4,			214433717,	0,	'H',	1,	NULL);
-- Richtung darf nicht null sein:  Abort due to constraint violation (NOT NULL constraint failed: Steig.Richtung)
INSERT INTO Steig (Steig_id,Fk_linien_id,Fk_haltestellen_id,Richtung,Reihenfolge,Steig)
	VALUES (5,			214433717,	345540619,	NULL,	1,	'U1-H');
-- Richtung ist ungültig (nicht H oder R):  Abort due to constraint violation (CHECK constraint failed: Steig)
INSERT INTO Steig (Steig_id,Fk_linien_id,Fk_haltestellen_id,Richtung,Reihenfolge,Steig) 
    VALUES (6,			214433717,	345540619,	'X',	1,	NULL);

-- Korrekte Ausgabe:
-- |Steig_id|Fk_linien_id|Fk_haltestellen_id|Richtung|Reihenfolge|Steig|
-- |--------|------------|------------------|--------|-----------|-----|
-- |231116889|214433687|214666497|H|1|U1-H|
-- |378112298|214433717|345540619|H|1||
   
SELECT * FROM Steig s ORDER BY s.Steig_id;
