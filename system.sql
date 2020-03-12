DROP TABLE MISTO;
DROP TABLE MISTNOST;
DROP TABLE VYBAVENI;
DROP TABLE ZAMESTANEC;

CREATE TABLE MISTNOST (
    id_mistnosti NUMBER NOT NULL PRIMARY KEY,
    pocet_mist INTEGER NOT NULL
);

CREATE TABLE ZAMESTANEC(
    id_zamestance NUMBER (1, *) PRIMARY KEY,
    Jmeno   VARCHAR(32) NOT NULL,
    Primeni VARCHAR(32) NOT NULL,
    Ulice   VARCHAR(32),
    Mesto   VARCHAR(32) NOT NULL, 
    PSC     NUMBER NOT NULL
);

CREATE TABLE "MISTO"
(
    id_mista   NUMBER NOT NULL PRIMARY KEY,
    id_mistnosti INTEGER not null, 
    id_zamestance INTEGER not null,
    
    Velikost NUMBER(1,*) NOT NULL,
    Cena     INTEGER NOT NULL,
    
    FOREIGN KEY (id_zamestance) REFERENCES ZAMESTANEC(id_zamestance)
    FOREIGN KEY  (id_mistnosti) REFERENCES MISTNOST(id_mistnosti)
);

CREATE TABLE VYBAVENI(
    id_vybaveni NUMBER(1, 100) PRIMARY KEY,
    id_mista NUMBER,
    FOREIGN KEY (id_mista) REFERENCES MISTO(id_mista)
);
