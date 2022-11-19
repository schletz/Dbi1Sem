# IF in SQL: Die CASE Anweisung

> Die nachfolgenden Abfragen beziehen sich auf die Schuldatenbank. Sie können die Datei
> [hier als SQLite Datenbank](../Schule.db) laden. Wenn Sie die Datenbank in einem Oracle
> oder SQL Server Docker Container laufen lassen möchten, finden Sie die Anleitung im Kurs
> [Dbi2Sem](https://github.com/schletz/Dbi2Sem#informationen-zum-start)

![](../schuldb20200209.png)

Bis jetzt haben wir Bedingungen in SQL nur in der *WHERE* oder *HAVING* Klausel geschrieben.
Manchmal möchte man aber auch Spalten ergänzen, die aufgrund anderer Werte ermittelt werden.
Betrachten wir die Tabelle *Klasse*. Sie hat 2 Spalten: Klassensprecher (*K_Klaspr*) und
Stellvertreter (*K_Klasprstv*). Wir möchten nun eine Abfrage erstellen, die die Klassen und die Info,
ob eine Klasse einen Klassensprecher und einen Stellvertreter hat, in der Spalte *HatVertreter*
ausgeben.

Schreiben wir diese Bedingung in die *WHERE* Klausel, können wir dieses Ziel nicht erreichen,
denn wir wollen ja alle Klassen der Schule ausgeben. Die Lösung ist ein *CASE* Ausdruck:

```sql
SELECT k.K_Nr, k.K_Klaspr, k.K_Klasprstv,
CASE WHEN k.K_Klaspr IS NOT NULL AND k.K_Klasprstv IS NOT NULL
	THEN 1
	ELSE 0
END AS HatVertreter
FROM Klasse k;
```

```
| K_Nr   | K_Klaspr | K_Klasprstv | HatVertreter |
| ------ | -------- | ----------- | ------------ |
| 1AFITN | 1971     | 1990        | 1            |
| 1AHBGM | 2199     | 2203        | 1            |
| 1AHIF  | 2478     | 2480        | 1            |
| 1AHKUI | 1012     | 1027        | 1            |
| 1AHMNA | 1042     |             | 0            |
| 1AHMNG | 1072     | 1068        | 1            |
```

Die Syntax ist zwar etwas gewöhnugsbedürftig, aber wenn wir sie mit einem if Befehl in Java oder C#
gegenüberstellen, ist der Aufbau gleich.

![](case_and_if_1018.png)

Statt geschweifte Klammern wird der Block mit *END* beendet. Die Anweisungen unter *THEN* und *ELSE*
kann man sich wie bei einem *return* vorstellen. Die Werte, die hier geschrieben werden, werden
für die erstellte Spalte verwendet.

Wir können natürlich auch - so wie *if* Anweisungen in Programmieren - *CASE* Anweisungen verschachteln.
Damit können wir z. B. bei den Gegenständen ausgeben, für welche Gruppe (x, y, z oder keine)
sie gelten. Endet der Gegenstand oder die Bezeichnung mit x, y oder z, so wollen wir x, y oder z
als Gruppe zurückgeben.


```sql
SELECT *,
CASE WHEN g.G_Nr LIKE '%x' OR g.G_Bez LIKE '%x'
    THEN 'x'
    ELSE
        CASE WHEN g.G_Nr LIKE '%y' OR g.G_Bez LIKE '%y'
            THEN 'y'
            ELSE 
                CASE WHEN g.G_Nr LIKE '%z' OR g.G_Bez LIKE '%z'
                    THEN 'z'
                    ELSE NULL
                END
        END
END AS Gruppe
FROM Gegenstand g;
```

```
| G_Nr  | G_Bez                  | Gruppe |
| ----- | ---------------------- | ------ |
| AINF  | Angew. Informatik      |        |
| AM    | ANGEW. MATHEMATIK      |        |
| AMEC  | Angewandte Mechatronik |        |
| AMx   | ANGEW. MATHEMATIK      | x      |
| AMx-E | Mathematik ESF x       | x      |
| AMy   | ANGEW. MATHEMATIK      | y      |
| AP4   | Atelier und Produktion |        |
```

In einem *CASE* Ausdruck kann auch ein Spaltenwert zurückgegeben werden. Wir wollen
für alle Unterrichtsstunden, wo kein Raum eingetragen ist (*Stunde.St_Raum* ist NULL) den Stammraum
der Klasse (*Klasse.K_Stammraum*) eintragen, wenn dieser im C-Gebäude ist. Beachte den
*LEFT JOIN* zwischen Stunde und Raum. Er ist wichtig, da wir die Stunden ohne Raum ja behalten
wollen.

```sql
SELECT s.*,
CASE WHEN s.St_Raum IS NULL AND k.K_Stammraum LIKE 'C%'
    THEN k.K_Stammraum 
    ELSE s.St_Raum
END AS Raum
FROM Stunde s LEFT JOIN Raum r ON (s.St_Raum = r.R_ID)
              INNER JOIN Klasse k ON (s.St_Klasse = k.K_Nr);
```

```
| St_Stunde | St_Tag | St_Lehrer | St_Klasse | St_Gegenstand | St_Raum | Raum  |
| --------- | ------ | --------- | --------- | ------------- | ------- | ----- |
| 1         | 2      | HAV       | 4CHIF     | POS1          |         | C4.10 |
| 1         | 2      | HL        | 5AHBGM    | GOM3          | C2.06   | C2.06 |
| 1         | 2      | HOT       | 1CHIF     | GGP           | C5.09   | C5.09 |
| 1         | 2      | HOV       | 3BHBGM    | PRE           |         | C2.08 |
```

Eine nicht so auf der Hand liegende Verwendung von *CASE* ist die Verwendung in Aggregatsfunktionen
wie *SUM()*. Wir wollen die Anzahl der männlichen und weiblichen SchülerInnen ausgeben. Mit einer Gruppierung
und *COUNT* konnten wir das bisher schon lösen, allerdings wollen wir das Ergebnis in *einer Zeile*
zurückgeben lassen.

Die Lösung ist dieser Ausdruck:

```sql
SELECT 
	SUM(CASE WHEN s.S_Geschlecht = 1 THEN 1 ELSE 0 END) AS StudentsMale,
	SUM(CASE WHEN s.S_Geschlecht = 2 THEN 1 ELSE 0 END) AS StudentsFemale
FROM Schueler s; 
```

```
| StudentsMale | StudentsFemale |
| ------------ | -------------- |
| 1568         | 1024           |
```

Die beiden *SUM()* Funktionen summieren eine Liste, die nur aus 1 oder 0 besteht. In der Spalte
*StudentsMale* ist für jeden männlichen Schüler (*S_Geschlecht* ist 1) eine 1, sonst eine 0. Bei
den weiblichen Schülerinnen ist es umgekehrt. Somit liefert uns die Summenfunktion die Anzahl.

> Hinweis: Ob die Abfrage langsamer als die *GROUP BY* und *COUNT* Variante ist, kann nicht allgemein
> angegeben werden. Es kommt auf die Indexierungen der Felder, also ob die Werte der Spalte sortiert 
> in einem Index vorliegen, an.
