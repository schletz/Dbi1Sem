# Filterabfragen

## [Zu den Folien](02_Abfragen.pdf)

> Die nachfolgenden Abfragen beziehen sich auf die Schuldatenbank. Sie können die Datei
> [hier als SQLite Datenbank](../Schule.db) laden. Wenn Sie die Datenbank in einem Oracle
> oder SQL Server Docker Container laufen lassen möchten, finden Sie die Anleitung im Kurs
> [Dbi2Sem](https://github.com/schletz/Dbi2Sem#informationen-zum-start)

![](../schuldb20200209.png)

**(1)** Welche Klassen sind Klassen der Höheren Informatik (enden mit HIF)? Sortieren Sie nach der Klassenbezeichnung.
**(2)** Welche Klassen gehören zum 1. Jahrgang (beginnen mit 1). Sortieren Sie nach der Klassenbezeichnung.
**(3)** Welche Klassen hat Griesmayer (GT) als Klassenvorstand.
**(4)** Welche Schuljahre beginnen im Jahr 2009? Verwenden Sie dafür die Funktion *Year()*, die Sie auf die Spalte
   *Sja_Datumvon* anwenden. Filtern Sie diese berechnete Spalte dann nach den Wert 2009.
**(5)** Wie lange dauern die verschiedenen Schuljahre? Geben Sie die alle Spalten aus Schuljahre und eine
   berechnete Spalte *AnzTage* aus. Subtrahieren Sie hierfür einfach die Datumswerte, die Differenz
   wird in Tagen geliefert.
**(6)** Welche Staaten sind kein EU Land? Diese Staaten haben in der Tabelle *Staaten* den Wert NULL in der
   Spalte *Sta_Euland*.
**(7)** Welche Lehrer sind männlich (*L_Geschlecht* ist 1) und haben ein Gehalt von über 700 Euro?
**(8)** Welche Schüler besuchen Biomedizin- und Gesundheitstechnik? Diese Schüler haben *HBG* in ihrer
   Klassenbezeichnung. Sortieren Sie zuerst nach *S_Zuname* und dann nach *S_Vorname*.
**(9)** Welche Schüler der Abteilung HIF (haben HIF im Klassennamen) haben den Vornamen Michael oder Alexander.
   Verwenden Sie für die Filterung des Vornamens die Funktion *IN*.
**(10)** Gibt es Lehrer, bei denen der Wert von *L_Stundengehalten* größer als der in *L_Stundengewuenscht* ist?
   Ignorieren Sie dabei Werte, wo *L_Stundengewuenscht* NULL ist.
   Hinweis: Erstellen Sie eine Spalte, die die Differenz zwischen den Werten berechnet. Filtern Sie dann
   nach den Datensätzen, die kleiner als 0 sind.

