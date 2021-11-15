# DBI für das 1. Semester des Kollegs bzw. Aufbaulehrganges

![](lehrstoff.png)

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
