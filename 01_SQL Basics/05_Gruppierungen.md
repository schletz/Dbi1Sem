# Gruppierungen

## :link: [Zu den Folien](05_Gruppierungen.pdf)

> Die nachfolgenden Abfragen beziehen sich auf die Schuldatenbank. Sie können die Datei
> [hier als SQLite Datenbank](../Schule.db) laden. Wenn Sie die Datenbank in einem Oracle
> oder SQL Server Docker Container laufen lassen möchten, finden Sie die Anleitung im Kurs
> [Dbi2Sem](https://github.com/schletz/Dbi2Sem#informationen-zum-start)

![](../schuldb20200209.png)

**(1)** Ermitteln Sie die Anzahl der Klassen pro Schuljahr. Ausgabe: *K_Jahrsem*, Anzahl der Klassen
**(2)** Ermitteln Sie die Anzahl der Klassen pro Schuljahr, allerdings sollen auch Schuljahre ohne Klassen mit
   der Anzahl 0 ausgegeben werden. Ausgabe: *Sja_Nr*, Anzahl der Klassen
**(3)** Geben Sie die Anzahl der Schüler pro Klasse aus. Klassen mit 0 Schüler sollen auch mit der Anzahl 0
   aufscheinen.
**(4)** Ermitteln Sie pro Postleitzahl die Anzahl der männlichen Schüler (*S_Geschlecht* ist 1). Geben Sie *S_Postleitzahl* und die 
   Anzahl aus.
**(5)** Verwenden Sie die vorige Abfrage in einer neuen Abfrage, indem Sie die vorige Abfrage als *EX05_04*
   speichern und wie eine Tabelle in eine neue Abfrage hineinziehen. Beantworten Sie dabei folgende Frage: Wie viele männliche
   Schüler gibt es höchstens in einem PLZ Gebiet. Ausgabe: Anzahl.
**(6)** Ermitteln Sie pro Klasse den Zunamen des ersten und letzten Schülers auf der Schülerliste sowie das 
   Geburtsdatum des jüngsten und ältesten Schülers. Hinweis: *MIN()* und *MAX()* funktionieren auch bei Zeichenketten.
**(7)** An welchen Tagen wurden mehrere Personen geboren, sind also mehrfach bei *S_Gebdatum* vergeben? Ausgabe:
   *S_Gebdatum* und Anzahl der Personen.
**(8)** Geben Sie pro Klasse und Geschlecht die Anzahl der Personen aus.
**(9)** Von wie vielen Klassen ist ein Lehrer der Klassenvorstand? Geben Sie *L_Nr*, *L_Vorname* und *L_Zuname* aus.
   Ist ein Lehrer kein Klassenvorstand, geben Sie 0 aus.
