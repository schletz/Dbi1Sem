# OUTER JOIN

## [Zu den Folien](04_OuterJoin.pdf)

> Die nachfolgenden Abfragen beziehen sich auf die Schuldatenbank. Sie können die Datei
> [hier als SQLite Datenbank](../Schule.db) laden. Wenn Sie die Datenbank in einem Oracle
> oder SQL Server Docker Container laufen lassen möchten, finden Sie die Anleitung im Kurs
> [Dbi2Sem](https://github.com/schletz/Dbi2Sem#informationen-zum-start)

![](../schuldb20200209.png)

**(1)** Zeigen Sie aus der Tabelle *Lehrer* den Lehrernamen mit dem Text aus *Ges_Lehrerlehrerin* (Tabelle *Geschlecht*) an. Setzen Sie diese Aufgabe mit INNER oder OUTER JOIN um. Gibt es Unterschiede bei der Ausgabe
   zwischen den Abfragen? Begründen Sie warum (oder warum nicht)?
**(2)** Welche Klassen haben keine Schüler? Geben Sie *K_Nr* und *K_Jahrsem* aus.
**(3)** Zeigen Sie alle Lehrer (Kürzel, Vorname, Zuname) an. Wenn ein Lehrer Klassenvorstand ist zeigen Sie den Abteilungsleiter dieser Klasse (Vor- und Zuname) an.
**(4)** Welche Lehrer sind zwar Klassenvorstand, nicht aber Abteilungsvorstand (*Abt_Leiter*)?
**(5)** Welche Religionsbekenntnisse wurden nie einem Schüler zugewiesen? Geben Sie alle Spalten aus *Religionen* aus.
**(6)** Kommen in der Spalte *K_Vorstand* Werte vor, die nicht in *L_Nr* der Tabelle *Lehrer* vorkommen? Geben Sie *K_Vorstand* aus. Überlegen Sie sich zuerst das Ergebnis 
   und beweisen Sie dies dann mit Hilfe einer Abfrage.
