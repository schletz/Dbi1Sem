# Ein kleines Diagramm

Mit der Extension *Markdown Preview Enhanced* können Sie PlantUML Diagramme in Markdown
Dateien einbetten. Die Voransicht sollte nun an dieser Stelle ein kleines ER Diagramm rendern. Es
gelten folgende Regeln:

- Erforderliche Felder (NOT NULL) werden mit einem Stern (\*) gekennzeichnet.
- Primärschlüssel werden im oberen Teil angegeben. Danach kommen 3 Striche.
  Darunter die restlichen Attribute.
- Generierte Werte (wie autoincrement Werte) werden mit \<\<generated\>\> gekennzeichnet.
- Beziehungen kommen in mehreren Arten vor:
  - `||..o{` definiert eine nicht identifizierende 1 : n Beziehung. Der FK ist also ein Attribut.
  - `|o..o{` definiert eine (0, 1) : n Beziehung. Der Fremdschlüssel ist also auf der n Seite
    optional.
  -  `||--0{` definiert eine identifizierende 1 : n Beziehung. Der FK ist also Teil des Primärschlüssels.
- Fremdschlüssel werden mit \<\<FK\>\> gekennzeichnet.

```plantuml
@startuml
' hide the spot
hide circle
' avoid problems with angled crows feet
skinparam linetype ortho

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

entity Class {
    *Id : number <<generated>>
    ---
    *Name : varchar(16)
    *SchoolyearId : number
    RoomId : varchar(16) <<FK>>
}
Schoolyear ||..o{ Class
Room |o..o{ Class

entity Subject {
    *Id : number <<generated>>
    ---
    *Name : varchar(16)
    *Longname : varchar(255)
}


entity Student {
    *Id : number <<generated>>
    ---
    *Firstname : varchar(200)
    *Lastname : varchar(200)
    *Accountname : varchar(16) <<unique>>
    *ClassId : number <<FK>>
}

Class ||..o{ Student

entity Lesson {
    *Id : number <<generated>>
    ---
    *ClassId : number <<FK>>
    *SubjectId : number <<FK>>
    *DayOfWeek : number
    *LessonNumber : number
}

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