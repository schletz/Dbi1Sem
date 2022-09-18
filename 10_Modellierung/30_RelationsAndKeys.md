# Beziehungen und Schlüssel: Ein erstes Kennenlernen

Bis jetzt können wir einzelne Entity Sets samt ihren Attributen mit PlantUML umsetzen. Der Name
*relationale Datenbank* gibt schon einen Hinweis, dass diese Entity Sets in *Beziehung* stehen.

Im Alltag haben wir diese Beziehung auch schon kennen gelernt. Seit dem ersten Schultag werden wir
mit diversen Listen konfrontiert. Wir leben geradezu in einer Welt von Listen. In unserer Schule
werden z. B. die folgenden 3 Listen häufig verwendet:

**Liste der Räume**

| Nr      | Capacity | Type         |
|---------|----------|------------- |
| C3.14a  |          | WC           |
| C3.04   |          | Lehrerzimmer |
| C3.06   | 24       | Klassenraum  |
| C3.07   | 30       | Klassenraum  |
| C3.08   | 30       | Klassenraum  |
| C3.09   | 30       | Klassenraum  |
| C3.10   | 30       | Klassenraum  |
| B4.14MF | 24       | Labor        |
| B4.15MF | 24       | Labor        |

**Liste der Klassen**

| Name  | ClassTeacher | Room  |
|-------|--------------|-------|
| 3AHIF | DOM          | C3.07 |
| 3BHIF | BOM          |       |
| 4AHIF | NIJ          | C3.08 |
| 5CHIF | MIP          | C3.10 |
| 5ABIF | HAS          | C3.08 |

<small><i>Anm: ClassTeacher ist der Klassenvorstand, Room ist der Stammraum</i></small>

**Liste der SchülerInnen**

| Account | Firstname | Lastname  | Gender | Class |
|---------|-----------|-----------|--------|-------|
| GAL2753 | Harley    | Galey     | w      | 3AHIF |
| MAB7534 | Engracia  | Mabson    | w      | 4AHIF |
| NAN6184 | Demetris  | Nanuccioi | m      | 5CHIF |
| SKE4596 | Sauncho   | Skein     | m      | 3BHIF |
| WOR9417 | Veronica  | Worboys   | w      | 3AHIF |

Wer in SQL schon eine JOIN Anweisung abgesetzt hat, kennt den Sachverhalt: Diese Listen sind nicht
voneinander unabhängig. Es können nur Klassen für SchülerInnen verwendet werden, die auch in der
Liste der Klassen aufscheinen. Gleiches gilt für die Stammräume. Nur vorhandene Räume können verwendet
werden.

Nun setzen wir einmal die Information dieser Listen in PlantUML als Entity um. Klicke auf
den Link unter dem Bild, um die PlantUML Syntax im online Editor zu sehen.

![](https://www.plantuml.com/plantuml/svg/LP112iCW44NtdcBMWTmX9T1kIXTjBZ2CqsR0QD398fJUlSPYQDoC-dtlWrrIZBfCpenY6KWYEJQEdmeQ8CfhLB0IcLI2DuQzYgvm3s62ju6ycbiiistRCdkSaVARNpYiCnlpsS7UOKexYHCVsAR40oEDNAobQCCh_z35vcqrd8Z2ulKeEKjCwgkxkUB_wSBU5dTjs-nTljo-u0i0)
<sup>https://www.plantuml.com/plantuml/uml/LP112iCW44NtdcBMWTmX9T1kIXTjBZ2CqsR0QD398fJUlSPYQDoC-dtlWrrIZBfCpenY6KWYEJQEdmeQ8CfhLB0IcLI2DuQzYgvm3s62ju6ycbiiistRCdkSaVARNpYiCnlpsS7UOKexYHCVsAR40oEDNAobQCCh_z35vcqrd8Z2ulKeEKjCwgkxkUB_wSBU5dTjs-nTljo-u0i0</sup>

Wir haben die Attribute, die nicht NULL sind, korrekt gekennzeichnet. Identifizierende Attribute,
die also in unserer Liste nur einmal vorkommen und immer vorhanden sind, haben wir schon als
Schlüssel eingetragen.

Nun müssen wir den Zusammenhang zwischen den Entity Sets kennzeichnen: die sogenannten *Relationen*.
Ein Hinweis auf den Zusammenhang ist bereits in der Liste gegeben: Es wird auf eine Klasse oder
einen Raum verwiesen.

### Sprachliche Formulierung von Beziehungen, 1:n Beziehung

Aus den Listen können wir 2 Zusammenhänge sprachlich beschreiben:

- Ein Raum ist der Stammraum einer oder mehrerer Klassen.
- Ein Schüler besucht eine Klasse.

Formeller können wir es mit sogenannten *Kardinalitäten* ausdrücken. Es ist lediglich eine
Umformulierung der Sätze:

- **1** Raum ist Stammraum von **n** Klassen. **1** Klasse hat **1** Stammraum.
- **1** Klasse besuchen **n** Schüler. **1** Schüler besucht **1** Klasse.

Wichtig ist, dass für jeden Punkt beide Sätze stimmen. Also dass ein Raum *n* Klassen beheimatet,
aber eine Klasse nur *einen* Stammraum hat. Wir bezeichnen diese Beziehung als *1:n* Beziehung.
Nun betrachten wir den Fall Raum zu Klasse noch genauer. In der Klassenliste fällt auf, dass
manche Klassen keinen Stammraum haben. Daher können wir noch exakter formulieren:

- **1** Raum ist Stammraum von **n** Klassen. **1** Klasse hat **0 oder 1** Stammraum.

### Der Fremdschlüssel

Wir haben nun erkannt, dass 1 Raum Stammraum von n Klassen ist und 1 Klasse 1 Stammraum hat.
Nun müssen diese Datensätze auch technisch zueinander finden. In der Liste der Klassen ist
die Lösung bereits abgebildet: Der Stammraum ist in einer Spalte dort abgebildet. Es ist jedoch
nicht der ganze Datensatz des Raumes dort gespeichert, das wäre unnötig. Es ist nur das
*identifizierende Attribut* des Raumes enthalten.

> **Merke:** Der Fremdschlüssel verweist auf den Primärschlüssel des anderen Entity Sets. Er
> ist immer auf der "n" Seite, da er nur auf einen Wert verweisen kann.

Warum der Fremdschlüssel immer auf der n Seite steht ist auch klar, wenn wir den umgekehrten
Fall betrachten. Der Raum C3.08 kann z. B. der Stammraum der Klassen 4AHIF und 5ABIF sein.
Wir müssten also eine Liste wie "4AHIF,5ABIF" speichern. Das ist natürlich nicht sinnvoll, denn
es würde Abfragen sehr erschweren.


### Alles zusammen: Das ER Diagramm mit Beziehungen

In PlantUML können wir mit einem genau definierten Symbolvorrat alle oben betrachteten
Sachverhalte abbilden. Klicke auf den Link, um den PlantUML Quelltext anzuzeigen.

![](https://www.plantuml.com/plantuml/svg/LKyxRiCm3Drr2iu17BHhOHWf0gH3YWnnnYwip4O2z0baQWZYtgR7w9QBLR9gm_52Ku_lypOzO-1eZL2w8v0wI4F2q1S3UmZwh1Ww7KYozau8Sgpv2aVlBTm4f6zr2EEigcgSMxoWJ3S5F5ql9CJtJDmQxFkPYPOUkAiHFX5AHKKr6nq2rFLktpHPPtGU_7hjR_zYBz30CnmnMlWaHTeY4uE3VKR9VRWwmMK1XGnFu3iAwQrbj3RSVw8b8UQ4BSSk_KuPNwNqqV5Zp9qEFRif_UeTbziRkQI_w9DhBXgKrCEGAqnkfSGofODMglkleL0AJ1kSIJ5eDr-BJVABrlm1)
<sup>https://www.plantuml.com/plantuml/uml/LP11QeKm48RtSufP2xuJF1uMmIvQNBHU82JJ6eY9JCQ5QE_U657KpHWc__Vzf8gYMAR1GMyDeRQi7O6Z7q49oFQt5pIMIOiD7e2yM9dnAuG15y3q5ItdMPPbdhKQbKvtzcKtZmJmTmPhfs8yasgWMxR8wuwKxYbJiwXbV3wRZzThusJp6XwFiEmmW1F-BPD9lmV-JUimURaR6ijH_24kFjNrz4xU45-gR0qlyhtzkcxsmmPL2gNt-mS0</sup>


## Erklärung der Symbole der crow's foot notation

Die Linien zwischen den Entities enden manchmal mit einem "Krähenfuß" (3 Striche). Dies gibt dieser
Notation auch ihren Namen. Die Pfeilenden sind allerdings genau definiert:

- `|o..` bedeutet Zero or one 
- `||..` bedeutet Exactly one 
- `o{..` bedeutet Zero or many
- `|{..` bedeutet One or many

Die Aussage *1 Raum ist Stammraum von n Klassen. 1 Klasse hat 0 oder 1 Stammraum.* wird daher mit folgender Zeile realisiert:

```
Room |o..o{ Class
```

### Zusammenspiel zwischen Pfeil und Attributen

In der Entity *Class* ist das Attribut *RoomNr* nicht notwendig (mandatory), denn es hat keinen
Punkt. Daher kann es NULL sein. Damit die Darstellung konsistent ist, muss daher bei *Room* ein
Pfeilende vom Typ *zero or one* (`|o` verwendet werden. Der Typ *exactly one* (also `||`) ist falsch,
da dann das Attribut *RoomNr* immer erforderlich ist.

Die Unterscheidung *zero or many* und *one or many* wird nicht getroffen, da wir immer von *n*
Klassen pro Raum oder *n* Schülern pro Klasse ausgehen. n ist 0 bis unendlich viele. Daher verwenden
wir immer *zero or many* (`o{`)

### Conventions

Wer sich die Namensgebung im Diagramm ansieht, wird Unterschiede zur originalen Liste bemerken:

- Die Entities werden immer in Einzahl definiert (Room statt Rooms)
- Der Fremdschlüssel hat den Aufbau *Entity, auf das verwiesen wird + Name des Schlüssels*. In
  Room heißt der Schlüssel *Nr*, daher geben wir dem Fremdschlüssel in *Class* den Namen *RoomNr*.
  Bei *Student* verwenden wir *ClassName* als Name des Fremdschlüssels, da das Entity *Class* den
  Schlüssel *Name* hat.
- Fremdschlüssel werden mit `<<FK>>` annotiert.

Diese Conventions sind nicht festgeschrieben. In diesem Kurs werden die Modelle nach diesen
Gesichtspunkten erstellt.

## Übungen

### Ergänzung des diskutierten Modelles

Der Stundenplan kann auch als Liste gespeichert werden. Diese Liste könnte so aussehen:


| Id   | Day | Lesson | Teacher | Room    | Subject | Class |
|------|-----|--------|---------|---------|---------|-------|
| 1001 | 1   | 4      | SZ      | C3.07   | POS1    | 5AAIF |
| 1002 | 1   | 5      | SZ      | C3.07   | POS1    | 5AAIF |
| 1003 | 5   | 7      | AH      | B3.12NW | NVS1    | 5AAIF |
| 1004 | 5   | 8      | AH      | B3.12NW | NVS1    | 5AAIF |
| 1005 | 5   | 7      | SPE     | B3.12NW | NVS1    | 5AAIF |
| 1006 | 5   | 8      | SPE     | B3.12NW | NVS1    | 5AAIF |

1. Erstelle mit VS Code eine neue Datei mit dem Namen *webuntis.puml*.
1. Kopiere den Quelltext von <small>https://www.plantuml.com/plantuml/uml/LP11QeKm48RtSufP2xuJF1uMmIvQNBHU82JJ6eY9JCQ5QE_U657KpHWc__Vzf8gYMAR1GMyDeRQi7O6Z7q49oFQt5pIMIOiD7e2yM9dnAuG15y3q5ItdMPPbdhKQbKvtzcKtZmJmTmPhfs8yasgWMxR8wuwKxYbJiwXbV3wRZzThusJp6XwFiEmmW1F-BPD9lmV-JUimURaR6ijH_24kFjNrz4xU45-gR0qlyhtzkcxsmmPL2gNt-mS0</small> in diese Datei.
1. Aktiviere mit *Alt + D* die Vorschau. Es sollte nun das Diagramm gerendert werden.
1. Ergänze das Entity *Teacher*, sodass Vorname, Zuname und E-Mail Adresse gespeichert werden können.
1. Ergänze das Entity *Timetable*, sodass die oben angezeigte Liste korrekt gespeichert werden kann.

Achte dabei auf die korrekten Beziehungen und die korrekte Verwendung der Symbole.

### Eine Bestellverwaltung

Ein kleines Unternehmen möchte einen Webshop in Betrieb nehmen. Zuerst wird überlegt, welche
Daten benötigt werden, um die Applikation überhaupt entwickeln zu können. Der Unternehmer zeigt
dir, wie eine Bestellbestätigung für eine Kundin (für Stefanie Musterkundin) aussehen soll:

```
Frau
Stefanie Musterkundin 
stefanie.musterkundin@gmail.com
1010 Ort

Bestellbestätigung                                Bestellung Nr: 123456
                                                  Datum der Bestellung: 3. November 2021
                                                  Kundennummer: 45678

Wir danken für Ihre Bestellung in unserem Webshop. Sie haben folgende Artikel bestellt:

Art. Nr.  Artikelbezeichnung        Anzahl  Einzelpreis  Gesamtpreis
1001      Samsung Galaxy A52s            1       393,90       393,90
1002      Samsung Galaxy Tab A7          1       178,00       178,00
1003      SanDisk Extreme, microSD       2        70,49       140,98
--------------------------------------------------------------------
                                                              712,88
```

1. Erstelle mit VS Code eine neue Datei mit dem Namen *webshop.puml*.
2. Lege die benötigten Entities an, indem du den nachfolgenden Code aus der Vorlage kopierst.
   Es sollen die Kunden, die verfügbaren Produkte, die
   Bestellung (*Order*) und die Bestellposition (*OrderItem*) erfasst werden können.
3. Erstelle ein korrektes ER Diagramm mit den nötigen Beziehungen. Achte auf die korrekte Umsetzung
   der crow's foot notation. Wenn kein vernünftiger Schlüssel aus dem Dokument abgelesen werden kann,
   verwende das Attribut *Id*.
4. Hinweis: Baue dein Modell mit 1:n Beziehungen auf. Prüfe wie in diesem Kapitel beschrieben, zwischen
   Welchen Entities solche Beziehungen existieren. Überlege, ob der Kunde (*Customer*) mit *Order*
   oder *OrderItem* verbunden werden soll.


**Vorlage für das ER Diagramm**
```
@startuml
hide circle

entity Customer {

}

entity Product {

}

entity Order {

}

entity OrderItem {

}

@enduml
```