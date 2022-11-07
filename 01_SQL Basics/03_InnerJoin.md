# INNER JOIN

## :link: [Zu den Folien](03_InnerJoin.pdf)

> Die nachfolgenden Abfragen beziehen sich auf die Schuldatenbank. Sie können die Datei
> [hier als SQLite Datenbank](../Schule.db) laden. Wenn Sie die Datenbank in einem Oracle
> oder SQL Server Docker Container laufen lassen möchten, finden Sie die Anleitung im Kurs
> [Dbi2Sem](https://github.com/schletz/Dbi2Sem#informationen-zum-start)

![](../schuldb20200209.png)

**(1)** In welcher Abteilung ist der Lehrer Zlabinger der Abteilungsvorstand. Geben Sie alle Spalten
   der Abteilungstabelle aus, filtern aber nach *L_Zuname*.

**(2)** In welchen Klassen (*K_Nr*, *K_jahrsem* ausgeben) sind Schüler, die aus den PLZ Gebieten 1210 oder 1220 kommen?

**(3)** Geben Sie alle Klassen (nur Spalte *K_Nr*) mit dem Langnamen (*Abt_Name*) der Abteilung aus.

**(4)** Geben Sie alle Spalten aus der Tabelle Abteilungen mit dem Namen (*L_Zuname* und *L_Vorname*) des AV (Abt_Leiter) aus.

**(5)** Welche Schüler haben ein evangelisches Religionsbekenntnis (Spalte *Rel_Nr* ist *evab*)? Warum liefert die Abfrage keine Werte?

**(6)** Geben Sie alle Klassen (Ausgabe von *K_Nr*) mit dem Namen des AV (*L_Zuname* und *L_Vorname*) aus.

**(7)** Geben Sie alle Schülerinnennamen (*S_Geschlecht* ist 2) mit dem Namen des KV (*L_Zuname* und *L_Vorname*) aus, falls auch dieser weiblich ist (*L_Geschlecht* ist 2).

**(8)** Geben Sie alle Klassen (Ausgabe von *K_Nr*) mit dem Namen des KV (*L_Zuname* und *L_Vorname*) und des AV (*L_Zuname* und *L_Vorname*) aus? Hinweis: Diese Abfrage benötigt Lehrer 2x.

**(9)** Geben Sie zu den Abteilungen (Ausgabe von *Abt_Name*) aus, in welchen Schuljahren (Ausgabe von *Sja_Bezeichnung*) sie Klassen haben. Hinweis: Führen Sie einen Join zwischen Abteilung, Klasse und Schuljahr durch.
   Warum müssen Sie die Bedingung "nur in welchen Schuljahren sie Klassen haben" nicht extra berücksichtigen?

**(10)** Geben Sie für jeden Schüler (Ausgabe von *S_Zuname* und *S_Vorname*) aus, wie viele Tage er/sie am Ende des jeweiligen Klassenbesuchs alt ist (Differenz von *S_Gebdat* und *K_Datumbis*)

**(11)** Gibt es Fälle, wo Schüler und Lehrer den gleichen Vornamen haben? Geben Sie nur den Vornamen aus.

**(12)** Geben Sie alle Klassen samt Beginndatum und Endedatum aus. Falls *K_Datumvon* bzw. *K_Datumbis* leer ist, verwenden Sie die Spalten aus dem Schuljahr (*Sja_Datumvon* und *Sja_Datumbis*).
   Hinweis: Mit *Nz(Spalte1, Spalte2)* können Sie die erste Spalte, die nicht NULL ist, zurückgeliefert bekommen. In Oracle heißt diese Funktion *COALESCE*.