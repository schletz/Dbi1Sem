# Ein kleines Diagramm

Mit der Extension *Markdown Preview Enhanced* können Sie PlantUML Diagramme in Markdown
Dateien einbetten. Die Voransicht sollte unter der Beschreibung ein kleines ER Diagramm rendern. Es
gelten folgende Regeln:

- Erforderliche Felder (*NOT NULL*) werden mit einem Stern (\*) gekennzeichnet.
- Primärschlüssel werden im oberen Teil angegeben. Danach kommen 3 Striche.
  Darunter die restlichen Attribute.
- Generierte Werte (wie autoincrement Werte) werden mit *\<\<generated\>\>* gekennzeichnet.
- Beziehungen kommen in mehreren Arten vor:
  - `||..o{` definiert eine nicht identifizierende 1 : n Beziehung. Der FK ist also ein Attribut.
  - `|o..o{` definiert eine (0, 1) : n Beziehung. Der FK ist also optional (nullable).
  -  `||--0{` definiert eine identifizierende 1 : n Beziehung. Der FK ist also Teil des Primärschlüssels.
- Fremdschlüssel werden mit *\<\<FK\>\>* gekennzeichnet.
- Constraints werden in 2 spitzen Klammern angegeben (z. B. *\<\<unique\>\>*, *\<\<index\>\>*).

```plantuml
@startuml
' hide the spot
hide circle
' Optional: enable for orthogonal lines.
' skinparam linetype ortho

entity Room {
    *Id : number <<generated>>
    ---
    *Name : varchar(16) <<unique>>
    Capacity : number
}

entity Schoolyear {
    *Id : number
    ---
    *Start : datetime
    *End : datetime
}

entity Teacher {
    *Id : number <<generated>>
    ---
    *Shortname : varchar(8) <<unique>>
    *Firstname : varchar(255)
    *Lastname : varchar(255)
    *Accountname : varchar(16) <<unique>>
}

entity Class {
    *Id : number <<generated>>
    ---
    *Name : varchar(16)
    *SchoolyearId : number <<FK>>
    *TeacherId : number <<FK>>
    RoomId : varchar(16) <<FK>>
}

Schoolyear ||..o{ Class
Teacher ||..o{ Class
Room |o..o{ Class

entity Subject {
    *Id : number <<generated>>
    ---
    *Name : varchar(16) <<unique>>
    *Longname : varchar(255)
}


entity Student {
    *Id : number <<generated>>
    ---
    *Firstname : varchar(255)
    *Lastname : varchar(255)
    *Accountname : varchar(16) <<unique>>
    *ClassId : number <<FK>>
}

Class ||..o{ Student



entity Lesson {
    *Id : number <<generated>>
    ---
    *ClassId : number <<FK>>
    *SubjectId : number <<FK>>
    *TeacherId : number <<FK>>
}

Teacher ||..o{ Lesson

Class ||..o{ Lesson
Subject ||..o{ Lesson

entity LessonPlanned {
    *LessonId : number <<FK>>
    *DayOfWeek : number
    *LessonNumber : number
    ---
    *RoomId
}
Lesson ||--o{ LessonPlanned

@enduml
```