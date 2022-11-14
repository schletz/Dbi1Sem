# DBI für das 3. Semester des Kollegs bzw. Aufbaulehrganges oder den 2 und 3. Jahrgang der HIF

## Lehrinhalte

<table>
    <tr>
        <th>Modellierung (3. Semester / III. Jahrgang)</th>
        <th>SQL Basics (3. Semester / II. Jahrgang)</th>
    </tr>
    <tr>
        <td valign="top">
            <ol>
                <li><a href="10_Modellierung/plantuml.md">PlantUML und VS Code als Modellierungswerkzeug.</a></li>
                <li><a href="10_Modellierung/SqlServer/README.md">SQL Server als Docker Image (für HIF Klassen).</a>
                </li>
                <li><a href="10_Modellierung/Dbeaver/README.md">DBeaver als Datenbankeditor.</a></li>
                <li><a href="10_Modellierung/10_Intro.md">Die Datenbank als strukturierter Informationsspeicher.</a>
                </li>
                <li><a href="10_Modellierung/20_PlantUmlErModel.md">Das erste ER Model mit PlantUML.</a></li>
                <li><a href="10_Modellierung/30_RelationsAndKeys.md">Beziehungen und Schlüssel: Ein erstes
                        Kennenlernen.</a></li>
                <li><a href="10_Modellierung/40_Keys.md">Schlüsselattribute</a></li>
                <li><a href="10_Modellierung/50_RelationsInDetail.md">n:m und 1:1 Beziehungen</a></li>
            </ol>
        </td>
        <td valign="top">
            <ul>
                <li>DQL (Data Query Language)
                    <ol>
                        <li><a href="01_SQL Basics/02_Abfragen.md">Filterungen mit WHERE</a></li>
                        <li><a href="01_SQL Basics/03_InnerJoin.md">INNER JOIN Anweisungen</a></li>
                        <li><a href="01_SQL Basics/04_OuterJoin.md">OUTER JOIN Anweisungen</a></li>
                        <li><a href="01_SQL Basics/05_Gruppierungen.md">Gruppierungen</a></li>
                        <li><a href="01_SQL Basics/06_Having.md">Having</a></li>
                        <li><a href="01_SQL Basics/07_Null.md">NULL und dreiwertige Logik</a></li>
                        <li>Übungsdatenbanken dazu
                            <ul>
                                <li><a href="01_SQL Basics/Uebungen/FilialDb">Filialen Datenbank</a></li>
                                <li><a href="01_SQL Basics/Uebungen/TeamsDb">Abgabenverwaltung</a></li>
                                <li><a href="01_SQL Basics/Uebungen/HaendlerDb">Händlerdatenbank</a></li>
                                <li><a href="01_SQL Basics/Uebungen/SemesterpruefungDb">Verwaltung von Prüfungen</a>
                                </li>
                                <li><a href="01_SQL Basics/Uebungen/SchneeDb">Schneehöhen (nur Datenbank)</a></li>
                            </ul>
                        </li>
                    </ol>
                </li>
                <li>DDL (CREATE TABLE Anweisungen)
                    <ol>
                        <li><a href="02_DDL/01_CreateTableCommand.md">Das CREATE TABLE Kommando</a></li>
                        <li><a href="02_DDL/02_CombinedKeys.md">Constraints mit mehreren Spalten und CHECK</a></li>
                        <li><a href="02_DDL/03_DateTime.md">Umgang mit Datum und Zeit</a></li>
                        <li>Übungen dazu
                            <ul>
                                <li><a href="02_DDL/Uebungen/Chat">Ein kleiner Chat</a></li>
                                <li><a href="02_DDL/Uebungen/HaltestellenDb">Haltestellen Datenbank</a></li>
                                <li><a href="02_DDL/Uebungen/PresenceManager">Presence Manager</a></li>
                                <li><a href="02_DDL/Uebungen/SemesterpruefungsDb">Eine Datenbank zur
                                        Prüfungsverwaltung</a></li>
                            </ul>
                    </ol>
                </li>
                <li>DML (INSERT, UPDATE und DELETE Anweisungen)</li>
                <ol>
                    <li><a href="03_DML/01_Insert.md">INSERT INTO Anweisungen</a></li>
                    <li><a href="03_DML/02_Update_Delete.md">Update und Delete</a></li>
                    <li><a href="https://www.sqlite.org/foreignkeys.html">ON DELETE CASCADE und ON UPDATE CASCADE</a>
                    </li>
                </ol>
            </ul>
        </td>
    </tr>
</table>

## Informationen zum Start

### Auf Basis von Oracle (Kollegs)

- [Oracle 21 XE als Docker Image](https://github.com/schletz/Dbi2Sem/blob/master/01_OracleVM/03_Docker/README.md)
- [Installation von DBeaver](https://github.com/schletz/Dbi2Sem/blob/master/01_OracleVM/01_Dbeaver/README.md)
- [Anlegen der Musterdatenbank (SchulDb) in Oracle](https://github.com/schletz/Dbi2Sem/blob/master/SchulDbGenerator/README.md)

### Auf Basis von SQL Server (HIF)
- [SQL Server als Docker Image](https://github.com/schletz/Dbi2Sem/blob/master/01_SQLServer/README.md)
- [Anlegen der Musterdatenbank (SchulDb) in SQL Server](https://github.com/schletz/Dbi2Sem/blob/master/SchulDbGenerator/README.md)

### Optionale Punkte
- [Installation von JetBrains DataGrip](01_OracleVM/02_DataGrip/README.md)
- [Installation von PlantUML in VS Code](03_PlantUml/README.md)


## Synchronisieren des Repositories in einen Ordner

1. Laden Sie von https://git-scm.com/downloads die Git Tools (Button *Download 2.23.0 for Windows*)
herunter. Es können alle Standardeinstellungen belassen werden, bei *Adjusting your PATH environment*
muss aber der mittlere Punkt (*Git from the command line [...]*) ausgewählt sein.
2. Lege einen Ordner auf der Festplatte an, wo Sie die Daten speichern möchten
(z. B. *C:\Schule\DBI\Examples*). Das
Repository ist nur die lokale Version des Repositories auf https://github.com/schletz/Dbi1Sem.git.
Hier werden keine Commits gemacht und alle lokalen Änderungen dort werden bei der
nächsten Synchronisation überschrieben.
3. Führen Sie in diesem Ordner den folgenden Befehl aus:

```text
git clone https://github.com/schletz/Dbi1Sem.git
```

Um Änderungen auf den Rechner zu Übertragen, können Sie die Datei *resetGit.cmd* ausführen.
Alle lokalen Änderungen gehen dabei verloren!