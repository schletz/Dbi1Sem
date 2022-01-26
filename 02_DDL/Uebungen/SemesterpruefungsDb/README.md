# Eine Datenbank zur Prüfungsverwaltung

Themenbereich: CREATE TABLE  

Fügen Sie in die Datenbank [Sempruef.db](Sempruef.db) folgende Tabellen mit Hilfe von CREATE TABLE Anweisungen
ein. Die angezeigten Daten geben Ihnen einen Überblick, welche Daten dort gespeichert werden sollen.

(1) Erstellen Sie eine Tabelle *Lesson*. Sie soll speichern, welcher Lehrer welche Klasse in welchem
Fach zu welchen Zeitpunkt unterrichtet.

| LE_ID	| LE_Lehrer	| LE_Klasse	| LE_Fach	| LE_Tag	| LE_Stunde	| 
| -----	| ---------	| ---------	| -------	| ------	| ---------	| 
| 1001 	| BAK      	| 3AHIF    	| D      	| 1     	| 1        	| 
| 1002 	| BAK      	| 3AHIF    	| D      	| 1     	| 2        	| 
| 1003 	| MEA      	| 3AHIF    	| AM     	| 2     	| 1        	| 
| 1004 	| MEA      	| 3AHIF    	| AM     	| 2     	| 2        	| 
| 1005 	| ZIE      	| 3AHIF    	| POS    	| 3     	| 1        	| 
| 1006 	| ZIE      	| 3AHIF    	| POS    	| 3     	| 2        	| 
| 1007 	| MEA      	| 3AHIF    	| POS    	| 3     	| 1        	| 
| 1008 	| MEA      	| 3AHIF    	| POS    	| 3     	| 2        	| 

Stellen Sie mit Constraints sicher, dass folgende Regeln eingehalten werden:

- *LE_ID*: Primärschlüssel; ganze Zahl
- *LE_Lehrer*: String, der auf den Primärschlüssel in Lehrer verweist. Maximal 10 Stellen.
- *LE_Klasse*: String, der auf den Primärschlüssel in Klasse verweist. Maximal 10 Stellen.
- *LE_Fach*: String, der auf den Primärschlüssel in Fach verweist. Maximal 10 Stellen.
- *LE_Tag*: Wochentag der Unterrichtsstunde. Zahl (1 = Montag, 6 = Samstag).
- *LE_Stunde*: Unterrichtsstunde von 1 bis 16.
- Lehrer, Klasse und Fach dürfen nicht leer sein.
- Der Tag muss zwischen 1 und 6 sein.
- Die Stunde muss zwischen 1 und 16 sein.
- Pro Lehrer, Tag und Stunde darf es nur 1 Datensatz geben.

(2) Erstellen Sie eine Tabelle *Lernwerkstatt*. In einer Lernwerkstatt betreut ein Lehrer einen Schüler
in einem Fach. Die Tabelle kann so aussehen:

| LW_Schueler	| LW_Fach	| LW_Betreuer	| LW_Anmeldung	    | 
| -----------	| -------	| -----------	| ---------------	| 
| 1004       	| POS    	| LIC        	| 1.11.2019      	| 
| 1004       	| E      	| LIC        	| 1.11.2019      	| 
| 1004       	| D      	| LIC        	| 5.12.2019      	| 
| 1004       	| AM     	| LIC        	| 1.11.2019      	| 
| 1004       	| E      	| DAI        	| 1.11.2019      	| 
| 1004       	| E      	| MEA        	| 3.12.2019      	| 
| 1004       	| POS    	| DAI        	| 3.12.2019      	| 
| 1004       	| AM     	| MEA        	| 3.12.2019      	| 

Stellen Sie mit Constraints sicher, dass folgende Regeln eingehalten werden:

- *LW_Schueler*: Wert, der auf den Primärschlüssel in Schüler verweist. Ganze Zahl.
- *LW_Fach*: String, der auf den Primärschlüssel in Fach verweist. Maximal 10 Stellen.
- *LW_Betreuer*: String, der auf den Primärschlüssel in Lehrer verweist. Maximal 10 Stellen.
- *LW_Anmeldung*: Datumswert.
- *LW_Betreuer* und *LW_Anmeldung* dürfen nicht leer sein.
- *LW_Schueler* und *LW_Fach* sind der Primärschlüssel.

(3) Erstellen Sie eine Tabelle *Arbeitsbericht*. Pro Schüler in der Lernwerkstatt sollen
Arbeitsberichte gespeichert werden können. Diese Tabelle sieht z. B. so aus:

| AB_Id	| AB_Schueler	| AB_Fach	| AB_Text          	| AB_Datum 	| 
| -----	| -----------	| -------	| -----------------	| ---------	| 
| 1001 	| 1004       	| POS    	| if Abfragen.     	| 1.11.2019	| 
| 1002 	| 1004       	| E      	| Vokabel abprüfen.	| 1.11.2019	| 
| 1003 	| 1004       	| POS    	| Schleifen üben.  	| 8.11.2019	| 
| 1004 	| 1004       	| E      	|               	| 8.11.2019	| 

Stellen Sie mit Constraints sicher, dass folgende Regeln eingehalten werden:

- *AB_Id*: Primärschlüssel. Ganzzahliger Wert.
- *AB_Schueler*: Wert, der auf die Spalte LW_Schueler in Lernwerkstatt verweist. Ganze Zahl.
- *AB_Fach*: String, der auf die SPalte LW_Fach in Lernwerkstatt verweist. Maximal 10 Stellen.
- *AB_Text*: Lehrstoff. Maximal 255 Stellen, darf auch leer sein.
- *AB_Datum*: Datum, wann die Stunde statt gefunden hat.
- *AB_Schueler* und *AB_Fach* müssen gemeinsam auf den Primärschlüssel in Lernwerkstatt verweisen.

(4) Fügen Sie die oben abgebildeten Datensätze mittels INSERT Anweisung in die Datenbank ein.

Verwenden Sie als Vorlage das folgende SQL Skript und speichern es unter Ihrem Accountnamen.
Das Skript muss auch mehrmals vollständig ausführbar sein.

```sql
-- *************************************************************************************************
-- Übung un SQL: CREATE TABLE und INSERT Kommandos
-- Vor- und Zuname:
-- *************************************************************************************************

PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS Lesson;
DROP TABLE IF EXISTS Lernwerkstatt;
DROP TABLE IF EXISTS Arbeitsbericht;

CREATE TABLE Lesson(

);

CREATE TABLE Lernwerkstatt(

);

CREATE TABLE Arbeitsbericht(

);

-- *************************************************************************************************
-- INSERT ANWEISUNGEN
-- *************************************************************************************************


```
