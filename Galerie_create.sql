DROP TABLE VYBAVENI;
DROP TABLE MISTO;
DROP TABLE MISTNOST;
DROP TABLE ZAMESTANEC;
DROP TABLE DELO;
DROP TABLE EXPOZICE;
DROP TABLE PRONAJIMATEL;
DROP TABLE POPLATEK;
DROP TABLE FIRMA;
DROP TABLE ADRESA;
DROP TABLE UMELEC;

CREATE TABLE POPLATEK
(
    cislo_poplatku NUMBER(15,1) not null PRIMARY KEY,
    zaplacenost NUMBER(1),
    sjednany_datum_zaplaceni DATE not null,
    datum_zaplaceni DATE
);

CREATE TABLE EXPOZICE
(
    nazev_expozice VARCHAR(32) NOT NULL PRIMARY KEY,
    cislo_poplatku NUMBER(15,1),
    FOREIGN KEY (cislo_poplatku) REFERENCES POPLATEK(cislo_poplatku),
    zacatek DATE not null,
    konec DATE not null,
    typ VARCHAR(32) not null,
    popis VARCHAR(32)
);



CREATE TABLE ADRESA
(
    id_adresy NUMBER(15,1) NOT NULL PRIMARY KEY,
    psc NUMBER(5) NOT NULL,
    ulice VARCHAR(32) NOT NULL,
    mesto VARCHAR(32) NOT NULL
);

CREATE TABLE FIRMA
(
    id_firmy NUMBER(5) NOT NULL PRIMARY KEY,
    nazev VARCHAR(32) NOT NULL,
    id_adresy NUMBER(15,1),
    FOREIGN KEY (id_adresy) REFERENCES ADRESA(id_adresy)
);

CREATE TABLE UMELEC
(
    rodne_cislo NUMBER(5) NOT NULL PRIMARY KEY,
    jmeno VARCHAR(32) NOT NULL,
    prijmeni VARCHAR(32),
    styl VARCHAR(100) NOT NULL,
    datum_narozeni DATE,
    datum_srmti DATE
);

CREATE TABLE PRONAJIMATEL
(
    id_pronajimatel NUMBER(15,1) NOT NULL PRIMARY KEY,
    jmeno VARCHAR(32) NOT NULL,
    prijmeni VARCHAR(32) NOT NULL,
    id_adresy NUMBER(15,1),
    FOREIGN KEY (id_adresy) REFERENCES ADRESA(id_adresy),
    cislo_poplatku NUMBER(15,1),
    FOREIGN KEY (cislo_poplatku) REFERENCES POPLATEK(cislo_poplatku),
    id_spec NUMBER(5),
    FOREIGN KEY (id_spec) REFERENCES UMELEC(rodne_cislo),
    id_spec_1 NUMBER(5),
    FOREIGN KEY (id_spec_1) REFERENCES FIRMA(id_firmy)

);

CREATE TABLE DELO
(
    id_dela NUMBER(15,1) NOT NULL PRIMARY KEY,
    nazev_expozice VARCHAR(32),
    FOREIGN KEY (nazev_expozice) REFERENCES EXPOZICE(nazev_expozice),
    rodne_cislo_umelce NUMBER(5),
    FOREIGN KEY (rodne_cislo_umelce) REFERENCES UMELEC(rodne_cislo),
    nazev_dela VARCHAR(32) NOT NULL,
    datum_vytvoreni DATE,
    typ_dela VARCHAR(32) NOT NULL,
    klicova_slova VARCHAR(32) NOT NULL
);

CREATE TABLE MISTNOST (
    id_mistnosti NUMBER(15,1) NOT NULL PRIMARY KEY,
    pocet_mist INTEGER NOT NULL
);

CREATE TABLE ZAMESTANEC(
    id_zamestance NUMBER(15,1) PRIMARY KEY,
    jmeno VARCHAR(32) NOT NULL,
    primeni VARCHAR(32) NOT NULL,
    id_adresy NUMBER(15,1),
    FOREIGN KEY (id_adresy) REFERENCES ADRESA(id_adresy)
);

CREATE TABLE MISTO
(
    id_mista NUMBER(15,1) NOT NULL PRIMARY KEY,
    id_mistnosti NUMBER(15,1) NOT NULL, 
    id_zamestance NUMBER(15,1) NOT NULL,
    velikost NUMBER NOT NULL,
    cena INTEGER NOT NULL,
    FOREIGN KEY (id_zamestance) REFERENCES ZAMESTANEC(id_zamestance),
    FOREIGN KEY (id_mistnosti) REFERENCES MISTNOST(id_mistnosti)
);

CREATE TABLE VYBAVENI(
    id_vybaveni NUMBER(15,1) NOT NULL PRIMARY KEY,
    id_mista NUMBER(15,1) NOT NULL,
    FOREIGN KEY (id_mista) REFERENCES MISTO(id_mista),
    nazev VARCHAR(32) NOT NULL,
    popis VARCHAR(100)
);
