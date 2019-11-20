-- SQL Script für DBeaver und SQLite

-- Umgekehrte Reihenfolge wie bei CREATE TABLE!
DROP TABLE Rating;
DROP TABLE User;
DROP TABLE RatingCriteria;
DROP TABLE School;

-- In ORACLE:
-- DROP TABLE School CASCADE CONSTRAINTS;

CREATE TABLE School (
--  SPALTENNAME  DATENTYP     CONSTRAINT(S)
	S_Number     INTEGER      PRIMARY KEY,
	S_Name       VARCHAR(100) NOT NULL
);

CREATE TABLE RatingCriteria (
	RC_ID        INTEGER      PRIMARY KEY AUTOINCREMENT,
	RC_Name      VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE User (
	U_ID        INTEGER     PRIMARY KEY AUTOINCREMENT,
	U_PhoneNr   VARCHAR(20) NOT NULL UNIQUE,
	U_Email     VARCHAR(100),
	-- U_School ist ein FK, daher auch ein INTEGER!
	U_School    INTEGER     NOT NULL,
	-- U_School zum FK machen. References verweist
	-- auf die "1er Seite"
	-- FOREIGN KEY (FK Columns) REFERENCES PKTable(PK Columns)
	FOREIGN KEY (U_School) REFERENCES School(S_Number)
);

CREATE TABLE Rating (
	R_ID       INTEGER  PRIMARY KEY AUTOINCREMENT,
	R_School   INTEGER  NOT NULL,
	R_User     INTEGER  NOT NULL,
	R_Criteria INTEGER  NOT NULL, 
	R_Datetime DATETIME NOT NULL,
	R_Value    INTEGER  NOT NULL,
	FOREIGN KEY (R_School)   REFERENCES School(S_Number),
	FOREIGN KEY (R_User)     REFERENCES User(U_ID),
	FOREIGN KEY (R_Criteria) REFERENCES RatingCriteria(RC_ID)
);


