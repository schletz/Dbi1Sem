# DBI für das 3. Semester des Kollegs bzw. Aufbaulehrganges oder den 2 und 3. Jahrgang der HIF

## Lehrinhalte

<table>
    <tr>
        <th>1</th> <th>2</th> <th>3</th> <th>4</th> <th>5</th>
    </tr>
    <tr>
        <td colspan="3" valign="top">
            <b>1</b> <a href="10_Modellierung/README.md">Datenmodellierung</a>
            <ol>
                <li><a href="10_Modellierung/plantuml.md">PlantUML und VS Code als Modellierungswerkzeug.</a></li>
                <li><a href="10_Modellierung/SqlServer/README.md">SQL Server als Docker Image (für HIF Klassen).</a></li>
                <li><a href="10_Modellierung/Dbeaver/README.md">DBeaver als Datenbankeditor.</a></li>
                <li><a href="10_Modellierung/10_Intro.md">Die Datenbank als strukturierter Informationsspeicher.</a></li>
                <li><a href="10_Modellierung/20_PlantUmlErModel.md">Das erste ER Model mit PlantUML.</a></li>
                <li><a href="10_Modellierung/30_RelationsAndKeys.md">Beziehungen und Schlüssel: Ein erstes Kennenlernen.</a></li>
                <li><a href="10_Modellierung/40_Keys.md">Schlüsselattribute</a></li>
            </ol>
        </td>    
        <td colspan="2" valign="top">
            <b>2</b> SQL
            <ol>
                <li>Filterungen mit WHERE</li>
                <li>INNER JOIN Anweisungen</li>
                <li>OUTER JOIN Anweisungen</li>
                <li>Gruppierungen</li>
                <li>Having</li>
                <li>Übungsdatenbanken dazu
                <ul>
                    <li><a href="01_SQL Basics/Uebungen/FilialDb">Filialen Datenbank</a></li>
                    <li><a href="01_SQL Basics/Uebungen/TeamsDb">Abgabenverwaltung</a></li>
                    <li><a href="01_SQL Basics/Uebungen/HaendlerDb">Händlerdatenbank</a></li>
                    <li><a href="01_SQL Basics/Uebungen/SchneeDb">Schneehöhen (nur Datenbank)</a></li>
                </ul>
                </li>
                <li>DDL (CREATE TABLE Anweisungen)</li>
                <li>DML (INSERT, UPDATE und DELETE Anweisungen)</li>
            </ol>
        </td>
    </tr>
</table>

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
