# DBI für das 1. Semester des Kollegs bzw. Aufbaulehrganges

## Lehrinhalte

<table>
    <tr>
        <th>1</th> <th>2</th> <th>3</th> <th>4</th> <th>5</th>
    </tr>
    <tr>
        <td colspan="3" valign="top">
            <b>1</b> Datenmodellierung
            <ol>
                <li>Die Datenbank als strukturierter Informationsspeicher.</li>
                <li>Datenbanktabellen: Der Begriff Schema.</li>
                <li>Datentypen und die NOT NULL Eigenschaft.</li>
                <li>ER Diagramme als Modellierungs- und Darstellungstechnik.</li>
                <li>Primärschlüssel, künstliche und natürliche Schlüssel.</li>
                <li>Relationen zwischen Tabellen: Fremdschlüssel und referentielle Integrität.</li>
                <li>Mehrteilige Schlüssel.</li>
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
