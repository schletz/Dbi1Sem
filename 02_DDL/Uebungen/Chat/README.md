<!-- markdownlint-disable MD045 -->
# Übung: Ein kleiner Chat

Erstellen Sie eine leere SQL Server oder Oracle Datenbank. Bilden Sie danach das folgende Datenmodell
mittels *CREATE TABLE* Statements ab:

![](03_chat_modell.png)

## Anlegen einer leeren Datenbank

### SQL Server (HIF)

Um eine Datenbank in SQL Server über die Shell anzulegen, öffne Docker Desktop und öffne die Shell
des SQL Server Containers. Danach kann mit folgendem Befehl die Datenbank *ChatDb* angelegt werden:

```bash
/opt/mssql-tools/bin/sqlcmd -U sa -P SqlServer2019 -Q "DROP DATABASE IF EXISTS ChatDb; CREATE DATABASE ChatDb;"

```

Dabei wird angenommen, dass *SqlServer2019* das sa Passwort ist, das beim Erstellen des Containers
mit *docker run* angegeben wurde.

### Oracle User (Kolleg)

Um einen User in Oracle über die Shell anzulegen, öffne Docker Desktop und öffne die Shell
des Oracle Containers. Danach kann mit folgendem Befehl der User *ChatDb* mit dem
Passwort *oracle* angelegt werden:

```bash
sqlplus system/oracle@//localhost/XEPDB1 <<< "
    DROP USER ChatDb CASCADE;
    CREATE USER ChatDb IDENTIFIED BY oracle;
    GRANT CONNECT, RESOURCE, CREATE VIEW TO ChatDb;
    GRANT UNLIMITED TABLESPACE TO ChatDb;
"

```

Dabei wird angenommen, dass *oracle* das system Passwort ist, das beim Erstellen des Containers
mit *docker run* angegeben wurde.


## SQL Skript

Zur Überprüfung verwenden Sie die nachfolgende Vorlage des SQL Skriptes. Es sind nach den *CREATE TABLE*
Anweisungen immer *INSERT* Anweisungen vorgegeben, die entweder funktionieren oder abgelehnt werden sollen.
So können Sie die Korrektheit überprüfen.

<details>
<summary>Skript für SQL Server anzeigen (HIF)</summary>

```sql
-- *************************************************************************************************
-- SQL DDL Übung
-- *************************************************************************************************
DROP TABLE IF EXISTS Link;
DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS Useraccount;

-- *************************************************************************************************
-- TABELLE Useraccount
-- *************************************************************************************************
-- 1. U_ID ist der Primärschlüssel.
-- 2. U_Email, U_Firstname und U_Lastname dürfen nicht NULL sein.
-- 3. Die Länge der Mailadresse in U_Email muss mindestens 10 Zeichen lang sein.
--    Verwenden Sie die Funktion LENGTH() in Oracle, um die Länge des Strings zu prüfen.
-- 4. Die Mailadresse darf nicht mehrfach vergeben werden.
CREATE TABLE Useraccount (
    -- FÜGEN SIE HIER IHRE TABELLENDEFINITION EIN.
);

SET IDENTITY_INSERT Useraccount ON;
-- Diese INSERT Statements sollen funktionieren
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname) VALUES (1, 'mail1@spengergasse.at', 'Firstname1', 'Lastname1');
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname) VALUES (2, 'mail2@spengergasse.at', 'Firstname2', 'Lastname2');
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname) VALUES (3, 'mail3@spengergasse.at', 'Firstname3', 'Lastname3');
-- Diese Statements sollen abgelehnt werden
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname) VALUES (1, 'mail4@spengergasse.at', 'Firstname4', 'Lastname4'); -- PK Constraint
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname) VALUES (5, 'mail1@spengergasse.at', 'Firstname5', 'Lastname5'); -- UNIQUE Mail Constraint
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname) VALUES (6, 'to@short', 'Firstname6', 'Lastname6');              -- Mail Length Constraint
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname) VALUES (7, NULL, 'Firstname7', 'Lastname7');                    -- Mail NULL Constraint
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname) VALUES (8, 'mail8@spengergasse.at', NULL, 'Lastname8');         -- Firstname NULL Constraint
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname) VALUES (9, 'mail9@spengergasse.at', 'Firstname9', NULL);        -- Lastname NULL Constraint

-- Korrekte Ausgabe des SELECT Statements (Datumsausgaben können im Format abweichen)
-- U_ID U_Email                 U_Firstname     U_Lastname
-- 1    mail1@spengergasse.at   Firstname1      Lastname1
-- 2    mail2@spengergasse.at   Firstname2      Lastname2
-- 3    mail3@spengergasse.at   Firstname3      Lastname3
SELECT * FROM Useraccount ORDER BY U_ID;

-- *************************************************************************************************
-- TABELLE MESSAGE
-- *************************************************************************************************
-- 1. M_ID ist der Primärschlüssel.
-- 2. M_Sender ist ein Fremdschlüssel für eine Useraccount-ID.
-- 3. M_Recipient ist ein Fremdschlüssel für eine Useraccount-ID.
-- 4. M_Sender, M_Recipient, M_Text, M_DateSended dürfen nicht NULL sein.
-- 5. M_DateConfirmed muss größer als M_DateSendet sein, falls eines eingefügt wird.
-- 6. M_Sender und M_Recipient dürfen nicht gleich sein.
CREATE TABLE Message (
    -- FÜGEN SIE HIER IHRE TABELLENDEFINITION EIN.
);
-- Diese INSERT Statements sollen funktionieren
SET IDENTITY_INSERT Message ON;
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (1, 1, 2, 'Message1', '2019-03-13T08:00:00', NULL);
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (2, 1, 3, 'Message2', '2019-03-13T09:00:00', NULL);
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (3, 2, 3, 'Message3', '2019-03-13T10:00:00'), '2019-03-13T11:00:00';
-- Diese Statements sollen abgelehnt werden
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (1, 1, 2, 'Message4', '2019-03-13T08:00:00', NULL);     -- PK Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (11, 1, 2, 'Message5', '2019-03-13T08:00:00'), '2019-03-13T07:00:00'; -- Confirmed Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (12, 1, 1, 'Message6', '2019-03-13T08:00:00', NULL);    -- Recipient Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (13, NULL, 2, 'Message7', '2019-03-13T08:00:00', NULL); -- Sender NULL Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (14, 1, NULL, 'Message8', '2019-03-13T08:00:00', NULL); -- Recipient NULL Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (15, 1, 2, NULL, '2019-03-13T08:00:00', NULL);          -- Message NULL Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (16, 1, 2, 'Message10', NULL, NULL);                    -- DateSended NULL Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (17, 1, 10, 'Message11', '2019-03-13T08:00:00', NULL);  -- FK Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (18, 11, 2, 'Message12', '2019-03-13T08:00:00', NULL);  -- FK Constraint

-- Korrekte Ausgabe des SELECT Statements (Datumsausgaben können im Format abweichen)
-- M_ID M_Sender    M_Recipient M_Text      M_DateSended                M_DateConfirmed
-- 1    1           2           Message1    2019-03-13 08:00:00.000     NULL
-- 2    1           3           Message2    2019-03-13 09:00:00.000     NULL
-- 3    2           3           Message3    2019-03-13 10:00:00.000     2019-03-13 11:00:00.000
SELECT * FROM Message ORDER BY M_ID;

-- *************************************************************************************************
-- TABELLE Link
-- *************************************************************************************************
-- 1. L_ID ist der Primärschlüssel.
-- 2. L_Message ist der Fremdschlüssel für die Message-ID.
-- 3. L_Message, L_Url dürfen nicht NULL sein.
-- 4. Es dürfen keine gleichen Url Werte (L_Url) in einer Message (L_Message) sein.
CREATE TABLE Link (
    -- FÜGEN SIE HIER IHRE TABELLENDEFINITION EIN.
);
-- Diese INSERT Statements sollen funktionieren
SET IDENTITY_INSERT Link ON;
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (1, 1, 'http://www.url.at/file1');
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (2, 2, 'http://www.url.at/file1');
-- Diese Statements sollen abgelehnt werden
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (1, 1, 'http://www.url.at/file2');     -- PK Constraint
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (3, 100, 'http://www.url.at/file3');   -- FK Constraint
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (4, NULL, 'http://www.url.at/file4');  -- Message NULL Constraint
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (5, 1, NULL);                          -- Url NULL Constraint
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (6, 1, 'http://www.url.at/file1');     -- UNIQUE Constraint

-- Korrekte Ausgabe des SELECT Statements (Datumsausgaben können im Format abweichen)
-- L_ID L_Message   L_Url
-- 1    1           http://www.url.at/file1
-- 2    2           http://www.url.at/file1
SELECT * FROM Link ORDER BY L_ID;

```
</details>

<details>
<summary>Skript für Oracle anzeigen (Kolleg)</summary>

```sql
-- *************************************************************************************************
-- SQL DDL Übung
-- *************************************************************************************************
DROP TABLE Link;
DROP TABLE Message;
DROP TABLE Useraccount;

-- *************************************************************************************************
-- TABELLE Useraccount
-- *************************************************************************************************
-- 1. U_ID ist der Primärschlüssel.
-- 2. U_Email, U_Firstname und U_Lastname dürfen nicht NULL sein.
-- 3. Die Länge der Mailadresse in U_Email muss mindestens 10 Zeichen lang sein.
--    Verwenden Sie die Funktion LENGTH() in Oracle, um die Länge des Strings zu prüfen.
-- 4. Die Mailadresse darf nicht mehrfach vergeben werden.
CREATE TABLE Useraccount (
    -- FÜGEN SIE HIER IHRE TABELLENDEFINITION EIN.
);

-- Diese INSERT Statements sollen funktionieren
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname) VALUES (1, 'mail1@spengergasse.at', 'Firstname1', 'Lastname1');
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname)  VALUES (2, 'mail2@spengergasse.at', 'Firstname2', 'Lastname2');
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname)  VALUES (3, 'mail3@spengergasse.at', 'Firstname3', 'Lastname3');
-- Diese Statements sollen abgelehnt werden
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname)  VALUES (1, 'mail4@spengergasse.at', 'Firstname4', 'Lastname4'); -- PK Constraint
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname)  VALUES (5, 'mail1@spengergasse.at', 'Firstname5', 'Lastname5'); -- UNIQUE Mail Constraint
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname)  VALUES (6, 'to@short', 'Firstname6', 'Lastname6');              -- Mail Length Constraint
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname)  VALUES (7, NULL, 'Firstname7', 'Lastname7');                    -- Mail NULL Constraint
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname)  VALUES (8, 'mail8@spengergasse.at', NULL, 'Lastname8');         -- Firstname NULL Constraint
INSERT INTO Useraccount (U_ID, U_Email, U_Firstname, U_Lastname)  VALUES (9, 'mail9@spengergasse.at', 'Firstname9', NULL);        -- Lastname NULL Constraint

-- Korrekte Ausgabe des SELECT Statements (Datumsausgaben können im Format abweichen)
-- U_ID U_Email                 U_Firstname     U_Lastname
-- 1    mail1@spengergasse.at   Firstname1      Lastname1
-- 2    mail2@spengergasse.at   Firstname2      Lastname2
-- 3    mail3@spengergasse.at   Firstname3      Lastname3
SELECT * FROM Useraccount ORDER BY U_ID;

-- *************************************************************************************************
-- TABELLE MESSAGE
-- *************************************************************************************************
-- 1. M_ID ist der Primärschlüssel.
-- 2. M_Sender ist ein Fremdschlüssel für eine Useraccount-ID.
-- 3. M_Recipient ist ein Fremdschlüssel für eine Useraccount-ID.
-- 4. M_Sender, M_Recipient, M_Text, M_DateSended dürfen nicht NULL sein.
-- 5. M_DateConfirmed muss größer als M_DateSendet sein, falls eines eingefügt wird.
-- 6. M_Sender und M_Recipient dürfen nicht gleich sein.
CREATE TABLE Message (
    -- FÜGEN SIE HIER IHRE TABELLENDEFINITION EIN.
);
-- Diese INSERT Statements sollen funktionieren
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (1, 1, 2, 'Message1', TO_TIMESTAMP('2019-03-13T08:00:00', 'YYYY-MM-DD"T"HH24:MI:SS'), NULL);
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (2, 1, 3, 'Message2', TO_TIMESTAMP('2019-03-13T09:00:00', 'YYYY-MM-DD"T"HH24:MI:SS'), NULL);
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (3, 2, 3, 'Message3', TO_TIMESTAMP('2019-03-13T10:00:00', 'YYYY-MM-DD"T"HH24:MI:SS')), TO_TIMESTAMP('2019-03-13T11:00:00', 'YYYY-MM-DD"T"HH24:MI:SS');

-- Diese Statements sollen abgelehnt werden
-- PK Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (1, 1, 2, 'Message4', TO_TIMESTAMP('2019-03-13T08:00:00', 'YYYY-MM-DD"T"HH24:MI:SS'), NULL);
-- Confirmed Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (11, 1, 2, 'Message5', TO_TIMESTAMP('2019-03-13T08:00:00', 'YYYY-MM-DD"T"HH24:MI:SS')), TO_TIMESTAMP('2019-03-13T07:00:00', 'YYYY-MM-DD"T"HH24:MI:SS');
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (12, 1, 1, 'Message6', TO_TIMESTAMP('2019-03-13T08:00:00', 'YYYY-MM-DD"T"HH24:MI:SS'), NULL);    -- Recipient Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (13, NULL, 2, 'Message7', TO_TIMESTAMP('2019-03-13T08:00:00', 'YYYY-MM-DD"T"HH24:MI:SS'), NULL); -- Sender NULL Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (14, 1, NULL, 'Message8', TO_TIMESTAMP('2019-03-13T08:00:00', 'YYYY-MM-DD"T"HH24:MI:SS'), NULL); -- Recipient NULL Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (15, 1, 2, NULL, TO_TIMESTAMP('2019-03-13T08:00:00', 'YYYY-MM-DD"T"HH24:MI:SS'), NULL);          -- Message NULL Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (16, 1, 2, 'Message10', NULL, NULL);                    -- DateSended NULL Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (17, 1, 10, 'Message11', TO_TIMESTAMP('2019-03-13T08:00:00', 'YYYY-MM-DD"T"HH24:MI:SS'), NULL);  -- FK Constraint
INSERT INTO Message (M_ID, M_Sender, M_Recipient, M_Text, M_DateSended, M_DateConfirmed)
    VALUES (18, 11, 2, 'Message12', TO_TIMESTAMP('2019-03-13T08:00:00', 'YYYY-MM-DD"T"HH24:MI:SS'), NULL);  -- FK Constraint

-- Korrekte Ausgabe des SELECT Statements (Datumsausgaben können im Format abweichen)
-- M_ID M_Sender    M_Recipient M_Text      M_DateSended                M_DateConfirmed
-- 1    1           2           Message1    2019-03-13 08:00:00.000     NULL
-- 2    1           3           Message2    2019-03-13 09:00:00.000     NULL
-- 3    2           3           Message3    2019-03-13 10:00:00.000     2019-03-13 11:00:00.000
SELECT * FROM Message ORDER BY M_ID;

-- *************************************************************************************************
-- TABELLE Link
-- *************************************************************************************************
-- 1. L_ID ist der Primärschlüssel.
-- 2. L_Message ist der Fremdschlüssel für die Message-ID.
-- 3. L_Message, L_Url dürfen nicht NULL sein.
-- 4. Es dürfen keine gleichen Url Werte (L_Url) in einer Message (L_Message) sein.
CREATE TABLE Link (
    -- FÜGEN SIE HIER IHRE TABELLENDEFINITION EIN.
);
-- Diese INSERT Statements sollen funktionieren
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (1, 1, 'http://www.url.at/file1');
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (2, 2, 'http://www.url.at/file1');
-- Diese Statements sollen abgelehnt werden
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (1, 1, 'http://www.url.at/file2');     -- PK Constraint
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (3, 100, 'http://www.url.at/file3');   -- FK Constraint
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (4, NULL, 'http://www.url.at/file4');  -- Message NULL Constraint
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (5, 1, NULL);                          -- Url NULL Constraint
INSERT INTO Link (L_ID, L_Message, L_Url) VALUES (6, 1, 'http://www.url.at/file1');     -- UNIQUE Constraint

-- Korrekte Ausgabe des SELECT Statements (Datumsausgaben können im Format abweichen)
-- L_ID L_Message   L_Url
-- 1    1           http://www.url.at/file1
-- 2    2           http://www.url.at/file1
SELECT * FROM Link ORDER BY L_ID;

```
</details>