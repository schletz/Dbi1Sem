DROP TABLE Angebot;
DROP TABLE Haendler;
DROP TABLE Artikel;

CREATE TABLE Artikel (
    EAN        INTEGER,
    Name       VARCHAR2(200),
    Kategorie  VARCHAR2(200),
    CONSTRAINT artikel_pk PRIMARY KEY (EAN)
);

CREATE TABLE Haendler (
    U_ID    INTEGER,
    Name   VARCHAR2(200) NOT NULL,
    Land   VARCHAR2(5),
    URL    VARCHAR2(200),
    CONSTRAINT haendler_pk PRIMARY KEY (U_ID)
);

CREATE TABLE Angebot (
    ID            INTEGER,
    Artikel       INTEGER NOT NULL,
    Haendler      INTEGER NOT NULL,
    Tag           DATE NOT NULL,
    Preis         DECIMAL(10,4),
    AnzVerkaeufe  INTEGER,
    URL           VARCHAR2(200),
    CONSTRAINT angebot_pk PRIMARY KEY (ID)    
);

INSERT INTO Artikel VALUES (1001, 'Raspberry Pi', 'Hardware');
INSERT INTO Artikel VALUES (1002, 'Corsair Gaming K70 RGB Rapidfire', 'Hardware');
INSERT INTO Artikel VALUES (1003, 'NVIDIA Titan RTX', 'Hardware');
INSERT INTO Artikel VALUES (1004, 'Nilfisk Supreme 250 Sauganlage', 'Haushalt');
INSERT INTO Artikel VALUES (1005, 'Jura Giga X3 Professional', 'Haushalt');
INSERT INTO Artikel VALUES (1006, 'Sony KD-77A1', 'Fernseher');

INSERT INTO Haendler VALUES (1001, 'Media Markt', 'AUT', 'www.mediamarkt.at');
INSERT INTO Haendler VALUES (1002, '1a Shop', 'AUT', 'www.1ashop.at');
INSERT INTO Haendler (U_ID, Name, Land) VALUES (1003, 'Alternate', 'GER');

INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1001, 1001, 1001, TO_DATE('2018-12-10', 'YYYY-MM-DD'), 84, 22, 'www.mediamarkt.at/product/1001');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1002, 1001, 1001, TO_DATE('2018-12-11', 'YYYY-MM-DD'), 83.16, NULL, 'www.mediamarkt.at/product/1001');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1003, 1001, 1001, TO_DATE('2018-12-12', 'YYYY-MM-DD'), 83.99, 18, 'www.mediamarkt.at/product/1001');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1004, 1001, 1001, TO_DATE('2018-12-13', 'YYYY-MM-DD'), NULL, NULL, 'www.mediamarkt.at/product/1001');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1005, 1001, 1001, TO_DATE('2018-12-14', 'YYYY-MM-DD'), 83.96, 9, 'www.mediamarkt.at/product/1001');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1006, 1001, 1001, TO_DATE('2018-12-15', 'YYYY-MM-DD'), 82.28, 17, 'www.mediamarkt.at/product/1001');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1007, 1001, 1003, TO_DATE('2018-12-10', 'YYYY-MM-DD'), 81.6, 27, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1008, 1001, 1003, TO_DATE('2018-12-11', 'YYYY-MM-DD'), 82.42, 4, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1009, 1001, 1003, TO_DATE('2018-12-12', 'YYYY-MM-DD'), 81.59, 19, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1010, 1001, 1003, TO_DATE('2018-12-13', 'YYYY-MM-DD'), 82.41, NULL, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1011, 1001, 1003, TO_DATE('2018-12-14', 'YYYY-MM-DD'), 82.41, 28, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1012, 1001, 1003, TO_DATE('2018-12-15', 'YYYY-MM-DD'), NULL, 4, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1013, 1002, 1003, TO_DATE('2018-12-10', 'YYYY-MM-DD'), 231.8, NULL, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1014, 1002, 1003, TO_DATE('2018-12-11', 'YYYY-MM-DD'), 229.48, 27, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1015, 1002, 1003, TO_DATE('2018-12-12', 'YYYY-MM-DD'), 229.48, 7, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1016, 1002, 1003, TO_DATE('2018-12-13', 'YYYY-MM-DD'), 224.89, 19, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1017, 1002, 1003, TO_DATE('2018-12-14', 'YYYY-MM-DD'), 222.64, 16, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1018, 1002, 1003, TO_DATE('2018-12-15', 'YYYY-MM-DD'), NULL, 6, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1019, 1004, 1003, TO_DATE('2018-12-10', 'YYYY-MM-DD'), 800, NULL, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1020, 1004, 1003, TO_DATE('2018-12-11', 'YYYY-MM-DD'), 800, 29, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1021, 1004, 1003, TO_DATE('2018-12-12', 'YYYY-MM-DD'), 792, 23, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1022, 1004, 1003, TO_DATE('2018-12-13', 'YYYY-MM-DD'), 799.92, NULL, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1023, 1004, 1003, TO_DATE('2018-12-14', 'YYYY-MM-DD'), 815.92, NULL, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1024, 1004, 1003, TO_DATE('2018-12-15', 'YYYY-MM-DD'), 832.24, NULL, NULL);
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1025, 1006, 1001, TO_DATE('2018-12-10', 'YYYY-MM-DD'), NULL, 10, 'www.mediamarkt.at/product/1006');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1026, 1006, 1001, TO_DATE('2018-12-11', 'YYYY-MM-DD'), 13675.14, 19, 'www.mediamarkt.at/product/1006');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1027, 1006, 1001, TO_DATE('2018-12-12', 'YYYY-MM-DD'), 13948.64, 27, 'www.mediamarkt.at/product/1006');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1028, 1006, 1001, TO_DATE('2018-12-13', 'YYYY-MM-DD'), NULL, 27, 'www.mediamarkt.at/product/1006');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1029, 1006, 1001, TO_DATE('2018-12-14', 'YYYY-MM-DD'), 14088.13, NULL, 'www.mediamarkt.at/product/1006');
INSERT INTO Angebot (ID, Artikel, Haendler, Tag, Preis, AnzVerkaeufe, URL) VALUES (1030, 1006, 1001, TO_DATE('2018-12-15', 'YYYY-MM-DD'), 14369.89, 6, 'www.mediamarkt.at/product/1006');

COMMIT;

ALTER TABLE Angebot
ADD CONSTRAINT fk_angebot_artikel
  FOREIGN KEY (Artikel)
  REFERENCES Artikel(EAN);  

ALTER TABLE Angebot
ADD CONSTRAINT fk_angebot_haendler
  FOREIGN KEY (Haendler)
  REFERENCES Haendler(U_ID);  
  