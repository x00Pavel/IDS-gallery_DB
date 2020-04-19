--select 'drop table ', table_name, 'cascade constraints;' from user_tables;
ALTER TABLE SEZNAM_DEL_V_EXPOZICI DROP CONSTRAINT PL_POLOZKY_SDE DROP CONSTRAINT FK_EXPOZICE_SDE DROP CONSTRAINT FK_DELO_SDE;
ALTER TABLE DELO DROP CONSTRAINT PK_DELO DROP CONSTRAINT FK_UMELEC;
ALTER TABLE FIRMA DROP CONSTRAINT PK_FIRMA DROP CONSTRAINT FK_U_PRONAJMATEL_F;
ALTER TABLE SOUKROMA_OSOBA DROP CONSTRAINT PK_SOUKROMA_OSOBA DROP CONSTRAINT FK_U_PRONAJMATEL_SO;
ALTER TABLE UMELEC DROP CONSTRAINT PK_UMELEC DROP CONSTRAINT FK_U_PRONAJMATEL_U;
ALTER TABLE SEZNAM_MIST_V_EKSPOZICI DROP CONSTRAINT PK_POLOZKA_SEZ_MIST_EKSP 
                                    DROP CONSTRAINT FK_EKSP_SEZ_MIST_EKSP 
                                    DROP CONSTRAINT FK_MISTO_SEZ_MIST_EKSP;
ALTER TABLE EXPOZICE DROP CONSTRAINT PK_EXPOZICE DROP CONSTRAINT FK_POPLATEK_E;
ALTER TABLE SEZNAM_TRANSAKCI DROP CONSTRAINT PK_TRANSAKCI DROP CONSTRAINT FK_PORNAJMATEL_ST DROP CONSTRAINT FK_POPLATEK_ST;
ALTER TABLE PRONAJIMATEL DROP CONSTRAINT PK_PRONAJMATEL DROP CONSTRAINT FK_ADRESSA;
ALTER TABLE POPLATEK DROP CONSTRAINT PK_POPLATEK;
ALTER TABLE ADRESSA DROP CONSTRAINT PK_ADRESS;
ALTER TABLE VYBAVENI DROP CONSTRAINT PK_VYBAVENI DROP CONSTRAINT FK_MISTO_V;
ALTER TABLE MISTO DROP CONSTRAINT PK_MISTO DROP CONSTRAINT FK_ZAMESTNANEC DROP CONSTRAINT FK_MISTNOST;
ALTER TABLE MISTNOST  DROP CONSTRAINT PK_MISTNOST;
ALTER TABLE ZAMESTNANEC_v  DROP CONSTRAINT PK_ZAMESTNANEC_U;

DROP SEQUENCE addr_seq;
DROP SEQUENCE pronajmatel_seq;
DROP SEQUENCE umelec_seq;
DROP SEQUENCE firma_seq;
DROP SEQUENCE soukr_seq;
DROP SEQUENCE delo_seq;
DROP SEQUENCE poplatek_seq;
DROP SEQUENCE expozice_seq;
DROP SEQUENCE transakce_seq;
DROP SEQUENCE delo_v_exp_seq;
DROP SEQUENCE mistnost_seq;
DROP SEQUENCE zamestnanec_seq;
DROP SEQUENCE misto_seq;
DROP SEQUENCE vybaveni_seq;
DROP SEQUENCE misto_v_exp_seq;


DROP TABLE PRONAJIMATEL CASCADE CONSTRAINTS;
DROP TABLE ADRESSA CASCADE CONSTRAINTS;
DROP TABLE UMELEC CASCADE CONSTRAINTS;
DROP TABLE EXPOZICE CASCADE CONSTRAINTS;
DROP TABLE POPLATEK CASCADE CONSTRAINTS;
DROP TABLE DELO CASCADE CONSTRAINTS; 
DROP TABLE FIRMA CASCADE CONSTRAINTS;
DROP TABLE SOUKROMA_OSOBA CASCADE CONSTRAINTS;
DROP TABLE SEZNAM_TRANSAKCI CASCADE CONSTRAINTS;
DROP TABLE SEZNAM_DEL_V_EXPOZICI CASCADE CONSTRAINTS;
DROP TABLE MISTNOST CASCADE CONSTRAINTS;
DROP TABLE MISTO CASCADE CONSTRAINTS;
DROP TABLE ZAMESTNANEC_V CASCADE CONSTRAINTS;
DROP TABLE VYBAVENI CASCADE CONSTRAINTS;
DROP TABLE SEZNAM_MIST_V_EKSPOZICI CASCADE CONSTRAINTS;

DROP MATERIALIZED VIEW XYADLO00.MY_VIEW;

CREATE TABLE ADRESSA
(
    id_adress NUMBER(5) NOT NULL CONSTRAINT PK_ADRESS PRIMARY KEY,
    psc NUMBER(5) NOT NULL,
    ulice VARCHAR(32) NOT NULL,
    mesto VARCHAR(32) NOT NULL
);

CREATE TABLE PRONAJIMATEL
(
    id_pronajimatel NUMBER(5) NOT NULL CONSTRAINT PK_PRONAJMATEL PRIMARY KEY ,
    fk_id_adress NUMBER(5) NOT NULL ,
    jmeno VARCHAR(32) NOT NULL,
    prijmeni VARCHAR(32) NOT NULL,    
    
    CONSTRAINT FK_ADRESSA FOREIGN KEY (fk_id_adress) REFERENCES ADRESSA(id_adress)
);
        
CREATE TABLE UMELEC
(
    id_umelec NUMBER(5) NOT NULL CONSTRAINT PK_UMELEC PRIMARY KEY,
    id_pronajmatel NUMBER(5) UNIQUE,
    prezdivka VARCHAR(32) NOT NULL,
    styl VARCHAR(100) NOT NULL,
    datum_narozeni DATE,
    datum_smrti DATE,
    
    CONSTRAINT FK_U_PRONAJMATEL_U FOREIGN KEY (id_pronajmatel) REFERENCES PRONAJIMATEL(id_pronajimatel)
);

CREATE TABLE FIRMA
(
    id_firmy NUMBER(5) NOT NULL CONSTRAINT PK_FIRMA PRIMARY KEY,
    id_pronajmatel NUMBER(5) NOT NULL UNIQUE,
    nazev VARCHAR(32) NOT NULL,
    
    CONSTRAINT FK_U_PRONAJMATEL_F FOREIGN KEY (id_pronajmatel) REFERENCES PRONAJIMATEL(id_pronajimatel)
);

CREATE TABLE SOUKROMA_OSOBA
(
    id_osoba NUMBER(5) NOT NULL CONSTRAINT PK_SOUKROMA_OSOBA PRIMARY KEY,
    id_pronajmatel NUMBER(5) NOT NULL UNIQUE,
    
    CONSTRAINT FK_U_PRONAJMATEL_SO FOREIGN KEY (id_pronajmatel) REFERENCES PRONAJIMATEL(id_pronajimatel)
);

CREATE TABLE DELO
(
    id_dela NUMBER(5)  NOT NULL CONSTRAINT PK_DELO PRIMARY KEY, 
    id_umelec NUMBER (5),
   
    nazev_dela VARCHAR(32) NOT NULL,
    datum_vytvoreni DATE,
    typ_dela VARCHAR(32) NOT NULL,
    klicova_slova VARCHAR(32) NOT NULL,
        
    CONSTRAINT FK_UMELEC FOREIGN KEY (id_umelec) REFERENCES UMELEC(id_umelec)
);	
		
CREATE TABLE POPLATEK
(
    id_cislo_poplatku NUMBER(5) NOT NULL CONSTRAINT PK_POPLATEK PRIMARY KEY,
    sjednany_datum_zaplaceni DATE NOT NULL,
    datum_zaplaceni DATE,
    zbivajici_suma NUMBER(*,2) NOT NULL
    
);

CREATE TABLE EXPOZICE
(
    id_expozice NUMBER(5) NOT NULL CONSTRAINT PK_EXPOZICE PRIMARY KEY,
    id_poplatku NUMBER(5) NOT NULL,
    nazev_expozice VARCHAR(32) NOT NULL,
    data_zacatek DATE NOT NULL,
    data_konec DATE NOT NULL,
    typ VARCHAR(32) NOT NULL,
    popis VARCHAR(32),
 
    CONSTRAINT FK_POPLATEK_E FOREIGN KEY (id_poplatku) REFERENCES POPLATEK(id_cislo_poplatku)
);

-- BRIDGE TABLE PRONAJMATEL - POPLATEK
CREATE TABLE SEZNAM_TRANSAKCI
(
    id_transakci NUMBER(5) NOT NULL CONSTRAINT PK_TRANSAKCI PRIMARY KEY,
    id_pronajmatel NUMBER(5) NOT NULL,
    id_poplatek NUMBER(5) NOT NULL,
    data_transakci DATE,
    suma NUMBER(*,2) NOT NULL,
    
    CONSTRAINT FK_PORNAJMATEL_ST FOREIGN KEY (id_pronajmatel) REFERENCES PRONAJIMATEL(id_pronajimatel),
    CONSTRAINT FK_POPLATEK_ST FOREIGN KEY (id_poplatek) REFERENCES POPLATEK(id_cislo_poplatku)
);
	
CREATE TABLE SEZNAM_DEL_V_EXPOZICI
(
    id_polozky NUMBER(5) NOT NULL CONSTRAINT PL_POLOZKY_SDE PRIMARY KEY,
    id_expozici NUMBER(5) NOT NULL,
    id_delo NUMBER(5) NOT NULL,
    data_vystaveni DATE NOT NULL,
    data_zruseni DATE,
    
    CONSTRAINT FK_EXPOZICE_SDE FOREIGN KEY (id_expozici) REFERENCES EXPOZICE(id_expozice),
    CONSTRAINT FK_DELO_SDE FOREIGN KEY (id_delo) REFERENCES DELO(id_dela)
);

CREATE TABLE MISTNOST
(
    id_mistnost NUMBER(5) NOT NULL CONSTRAINT PK_MISTNOST PRIMARY KEY,
    pocet_mist NUMBER(*) NOT NULL
);

CREATE TABLE ZAMESTNANEC_V
(
    id_zamestnanec NUMBER(5) NOT NULL CONSTRAINT PK_ZAMESTNANEC_U PRIMARY KEY,
    jmeno VARCHAR(32) NOT NULL,
    prijmeni VARCHAR(32) NOT NULL,
    fk_id_adress NUMBER(5) NOT NULL
);

CREATE TABLE MISTO
(
    id_misto NUMBER(5) NOT NULL CONSTRAINT PK_MISTO PRIMARY KEY,
    id_mistnost NUMBER(5) NOT NULL,
    id_zamestnanec_m NUMBER(5) NOT NULL,
    velikost NUMBER(*),
    cena NUMBER(*),
    typ_mista VARCHAR(32),
    
    CONSTRAINT FK_ZAMESTNANEC FOREIGN KEY (id_zamestnanec_m) REFERENCES ZAMESTNANEC_V(id_zamestnanec),
    CONSTRAINT FK_MISTNOST FOREIGN KEY (id_mistnost) REFERENCES MISTNOST(id_mistnost)
);

CREATE TABLE VYBAVENI
(
    id_vybaveni NUMBER(5) NOT NULL CONSTRAINT PK_VYBAVENI PRIMARY KEY,
    id_misto NUMBER(5),
    nazev VARCHAR(32) NOT NULL,
    popis VARCHAR(32),
    
    CONSTRAINT FK_MISTO_V FOREIGN KEY (id_misto) REFERENCES MISTO(id_misto)
);

CREATE TABLE SEZNAM_MIST_V_EKSPOZICI
(
    id_polozky NUMBER(5) NOT NULL CONSTRAINT PK_POLOZKA_SEZ_MIST_EKSP PRIMARY KEY,
    id_misto NUMBER(5) NOT NULL,
    id_ekspozici NUMBER(5) NOT NULL,
    data_vystaveni DATE NOT NULL,
    data_zruseni DATE,
    
    CONSTRAINT FK_EKSP_SEZ_MIST_EKSP FOREIGN KEY (id_ekspozici) REFERENCES EXPOZICE(id_expozice),
    CONSTRAINT FK_MISTO_SEZ_MIST_EKSP FOREIGN KEY (id_misto) REFERENCES MISTO(id_misto)
);

----------------------------------------------------------------------
-- Sequences 
CREATE SEQUENCE addr_seq START WITH 1;

CREATE SEQUENCE pronajmatel_seq START WITH 1;		

CREATE SEQUENCE umelec_seq START WITH 1;	

CREATE SEQUENCE firma_seq START WITH 1;	

CREATE SEQUENCE soukr_seq START WITH 1;	

CREATE SEQUENCE delo_seq START WITH 1;

CREATE SEQUENCE poplatek_seq START WITH 1;	

CREATE SEQUENCE expozice_seq START WITH 1;

CREATE SEQUENCE transakce_seq START WITH 1;

CREATE SEQUENCE delo_v_exp_seq START WITH 1;

CREATE SEQUENCE mistnost_seq START WITH 1;

CREATE SEQUENCE zamestnanec_seq START WITH 1;

CREATE SEQUENCE misto_seq START WITH 1;

CREATE SEQUENCE vybaveni_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE misto_v_exp_seq START WITH 1;

-- Trigeres
-- solve muting tables with using of compound DML triggers
CREATE OR REPLACE TRIGGER CHANGE_NULL_IN_VYBAVENI
    FOR INSERT ON VYBAVENI
    COMPOUND TRIGGER
        update_comment BOOLEAN;
        
    BEFORE EACH ROW IS
    BEGIN 
        IF :old.popis IS NULL THEN 
            update_comment := TRUE;
        END IF;
    END BEFORE EACH ROW;
    
    AFTER STATEMENT IS
    BEGIN
        IF update_comment THEN
            UPDATE VYBAVENI
                SET popis = 'neni popis'
            WHERE popis IS NULL;
        END IF;
    END AFTER STATEMENT;
END CHANGE_NULL_IN_VYBAVENI;
/


CREATE OR REPLACE TRIGGER SEQ_VYBAVENI
BEFORE INSERT ON VYBAVENI
FOR EACH ROW
    WHEN (new.id_vybaveni IS NULL)
BEGIN
    :new.id_vybaveni := vybaveni_seq.NEXTVAL;
END;
/

SELECT * FROM VYBAVENI;


----------------------------------------------------------------------
-- Insertions	

INSERT INTO ADRESSA
VALUES (addr_seq.NEXTVAL, 62400, 'Cichnova', 'Brno');
INSERT INTO ADRESSA
VALUES (addr_seq.NEXTVAL, 62300, 'Pionirska', 'Brno');
INSERT INTO ADRESSA
VALUES (addr_seq.NEXTVAL, 60300, 'Husitska', 'Brno');
INSERT INTO ADRESSA
VALUES (addr_seq.NEXTVAL, 65100, 'Hlavni', 'Brno');
INSERT INTO ADRESSA
VALUES (addr_seq.NEXTVAL, 64700, 'Ceska', 'Brno');
        
INSERT INTO PRONAJIMATEL
VALUES (pronajmatel_seq.NEXTVAL, 1, 'Oleksii', 'Korniienko');
INSERT INTO PRONAJIMATEL
VALUES (pronajmatel_seq.NEXTVAL, 1, 'Muchamed', 'Alli');
INSERT INTO PRONAJIMATEL
VALUES (pronajmatel_seq.NEXTVAL, 2, 'Pavel', 'Yadlouski');
INSERT INTO PRONAJIMATEL
VALUES (pronajmatel_seq.NEXTVAL, 3, 'Raul', 'Raulovich');
INSERT INTO PRONAJIMATEL
VALUES (pronajmatel_seq.NEXTVAL, 4, 'Michail', 'Shchekastii');
INSERT INTO PRONAJIMATEL
VALUES (pronajmatel_seq.NEXTVAL, 4, 'Michail', 'Novak');

INSERT INTO UMELEC
VALUES (umelec_seq.NEXTVAL, 1, 'Snail', 'Obrazky', TO_DATE('03/02/1999', 'DD/MM/YYYY'), NULL);
INSERT INTO UMELEC
VALUES (umelec_seq.NEXTVAL, 2, 'Plovec', 'Sochy', TO_DATE('17/02/1993', 'DD/MM/YYYY'), NULL);
INSERT INTO UMELEC
VALUES (umelec_seq.NEXTVAL, NULL, 'Ragul', 'Obrazky', TO_DATE('30/03/2005', 'DD/MM/YYYY'), NULL);

INSERT INTO FIRMA
VALUES (firma_seq.NEXTVAL, 4, 'Ragul`s Company');

INSERT INTO SOUKROMA_OSOBA
VALUES (soukr_seq.NEXTVAL, 4);

INSERT INTO DELO
VALUES (delo_seq.NEXTVAL, 1, 'First obrazek', TO_DATE('09/09/1999', 'DD/MM/YYYY'), 'obrazek', 'Snail,obrazek,first');
INSERT INTO DELO
VALUES (delo_seq.NEXTVAL, 2, 'alomalo', TO_DATE('11/11/2011', 'DD/MM/YYYY'), 'socha', 'Plovec,socha');
INSERT INTO DELO
VALUES (delo_seq.NEXTVAL, 3, 'Jaconda', TO_DATE('01/01/1995', 'DD/MM/YYYY'), 'obrazek', 'Mona Liza, Jaconda');
INSERT INTO DELO
VALUES (delo_seq.NEXTVAL, 3, 'Anaconda', TO_DATE('03/03/1995', 'DD/MM/YYYY'), 'obrazek', 'Some Anaconda');

INSERT INTO POPLATEK
VALUES (poplatek_seq.NEXTVAL, TO_DATE('06/03/2020', 'DD/MM/YYYY'), TO_DATE('06/03/2020', 'DD/MM/YYYY'), 0);
INSERT INTO POPLATEK
VALUES (poplatek_seq.NEXTVAL, TO_DATE('06/05/2020', 'DD/MM/YYYY'), NULL, 1000);
INSERT INTO POPLATEK
VALUES (poplatek_seq.NEXTVAL, TO_DATE('02/03/2020', 'DD/MM/YYYY'), NULL, 5000);
INSERT INTO POPLATEK
VALUES (poplatek_seq.NEXTVAL, TO_DATE('11/03/2020', 'DD/MM/YYYY'), NULL, 45000);

INSERT INTO EXPOZICE
VALUES (expozice_seq.NEXTVAL, 1, 'Snail`s top1 expozice', TO_DATE('13/03/2020', 'DD/MM/YYYY'), TO_DATE('20/03/2020', 'DD/MM/YYYY'), 'obrazky', 'Nejlepsi obrazky ze vseho sveta!');
INSERT INTO EXPOZICE
VALUES (expozice_seq.NEXTVAL, 2, 'Plovec`s top1 expozice', TO_DATE('14/03/2020', 'DD/MM/YYYY'), TO_DATE('21/03/2020', 'DD/MM/YYYY'), 'sochy', NULL);
INSERT INTO EXPOZICE
VALUES (expozice_seq.NEXTVAL, 3, 'Mona Liza', TO_DATE('26/03/2020', 'DD/MM/YYYY'), TO_DATE('31/03/2020', 'DD/MM/YYYY'), 'obrazek', NULL);

INSERT INTO SEZNAM_TRANSAKCI
VALUES (transakce_seq.NEXTVAL, 1, 1, TO_DATE('06/03/2020', 'DD/MM/YYYY'), 10000);
INSERT INTO SEZNAM_TRANSAKCI
VALUES (transakce_seq.NEXTVAL, 2, 2, TO_DATE('06/03/2020', 'DD/MM/YYYY'), 8000);
INSERT INTO SEZNAM_TRANSAKCI
VALUES (transakce_seq.NEXTVAL, 2, 2, TO_DATE('06/03/2020', 'DD/MM/YYYY'), 1000);
INSERT INTO SEZNAM_TRANSAKCI
VALUES (transakce_seq.NEXTVAL, 2, 3, TO_DATE('26/02/2020', 'DD/MM/YYYY'), 3000);
INSERT INTO SEZNAM_TRANSAKCI
VALUES (transakce_seq.NEXTVAL, 3, 2, TO_DATE('27/02/2020', 'DD/MM/YYYY'), 2000);
INSERT INTO SEZNAM_TRANSAKCI
VALUES (transakce_seq.NEXTVAL, 4, 4, TO_DATE('27/02/2020', 'DD/MM/YYYY'), 2000);
INSERT INTO SEZNAM_TRANSAKCI
VALUES (transakce_seq.NEXTVAL, 4, 4, TO_DATE('27/02/2020', 'DD/MM/YYYY'), 4000);
INSERT INTO SEZNAM_TRANSAKCI
VALUES (transakce_seq.NEXTVAL, 5, 4, TO_DATE('27/02/2020', 'DD/MM/YYYY'), 2000);
INSERT INTO SEZNAM_TRANSAKCI
VALUES (transakce_seq.NEXTVAL, 5, 4, TO_DATE('27/02/2020', 'DD/MM/YYYY'), 10000);

INSERT INTO SEZNAM_DEL_V_EXPOZICI
VALUES (delo_v_exp_seq.NEXTVAL, 1, 1, TO_DATE('13/03/2020', 'DD/MM/YYYY'), TO_DATE('20/03/2020', 'DD/MM/YYYY'));
INSERT INTO SEZNAM_DEL_V_EXPOZICI
VALUES (delo_v_exp_seq.NEXTVAL, 2, 2, TO_DATE('14/03/2020', 'DD/MM/YYYY'), TO_DATE('21/03/2020', 'DD/MM/YYYY'));
INSERT INTO SEZNAM_DEL_V_EXPOZICI
VALUES (delo_v_exp_seq.NEXTVAL, 3, 3, TO_DATE('26/03/2020', 'DD/MM/YYYY'), TO_DATE('31/03/2020', 'DD/MM/YYYY'));

INSERT INTO MISTNOST
VALUES (mistnost_seq.NEXTVAL, 5);
INSERT INTO MISTNOST
VALUES (mistnost_seq.NEXTVAL, 7);
INSERT INTO MISTNOST
VALUES (mistnost_seq.NEXTVAL, 15);
INSERT INTO MISTNOST
VALUES (mistnost_seq.NEXTVAL, 3);
INSERT INTO MISTNOST
VALUES (mistnost_seq.NEXTVAL, 1);

INSERT INTO ZAMESTNANEC_V
VALUES (zamestnanec_seq.NEXTVAL, 'Oleksii', 'Korniienko', 1);
INSERT INTO ZAMESTNANEC_V
VALUES (zamestnanec_seq.NEXTVAL, 'Pavel', 'Yadlouskii', 2);
INSERT INTO ZAMESTNANEC_V
VALUES (zamestnanec_seq.NEXTVAL, 'Raul', 'Arghayev', 3);
INSERT INTO ZAMESTNANEC_V
VALUES (zamestnanec_seq.NEXTVAL, 'Nikitasik', 'Moskaliasik', 3);
INSERT INTO ZAMESTNANEC_V
VALUES (zamestnanec_seq.NEXTVAL, 'Siriozhka', 'Salatien', 3);

INSERT INTO MISTO
VALUES (misto_seq.NEXTVAL, 1, 1, 100, 1000, 'stena');
INSERT INTO MISTO
VALUES (misto_seq.NEXTVAL, 1, 1, 200, 2000, 'stena');
INSERT INTO MISTO
VALUES (misto_seq.NEXTVAL, 1, 1, 500, 1500, 'podlaha');
INSERT INTO MISTO
VALUES (misto_seq.NEXTVAL, 2, 2, 300, 2000, 'strop');
INSERT INTO MISTO
VALUES (misto_seq.NEXTVAL, 3, 2, 200, 3000, 'stena');
INSERT INTO MISTO
VALUES (misto_seq.NEXTVAL, 3, 2, 400, 3500, 'strop');
INSERT INTO MISTO
VALUES (misto_seq.NEXTVAL, 3, 2, 500, 4500, 'stena');
INSERT INTO MISTO
VALUES (misto_seq.NEXTVAL, 4, 3, 400, 4000, 'stena');


INSERT INTO VYBAVENI
VALUES (NULL, 1, 'lampa', 'sveti jako slunicko');
INSERT INTO VYBAVENI
VALUES (NULL, 2, 'podstavec', NULL);
INSERT INTO VYBAVENI
VALUES (vybaveni_seq.NEXTVAL, 1, 'ramecek', 'proste bozi');
INSERT INTO VYBAVENI
VALUES (vybaveni_seq.NEXTVAL, 3, 'ramecek', NULL);
INSERT INTO VYBAVENI
VALUES (NULL, NULL, 'podstavec', NULL);
INSERT INTO VYBAVENI
VALUES (NULL, 4, 'ramecek', NULL);
INSERT INTO VYBAVENI
VALUES (vybaveni_seq.NEXTVAL, NULL, 'stul', 'jako u kralovny');
INSERT INTO VYBAVENI
VALUES (vybaveni_seq.NEXTVAL, 5, 'ramecek', NULL);
INSERT INTO VYBAVENI
VALUES (vybaveni_seq.NEXTVAL, NULL, 'stul', NULL);


INSERT INTO SEZNAM_MIST_V_EKSPOZICI
VALUES (misto_v_exp_seq.NEXTVAL, 1, 1, TO_DATE('13/03/2020', 'DD/MM/YYYY'), NULL);
INSERT INTO SEZNAM_MIST_V_EKSPOZICI
VALUES (misto_v_exp_seq.NEXTVAL, 2, 1, TO_DATE('13/03/2020', 'DD/MM/YYYY'), NULL);
INSERT INTO SEZNAM_MIST_V_EKSPOZICI
VALUES (misto_v_exp_seq.NEXTVAL, 3, 2, TO_DATE('14/03/2020', 'DD/MM/YYYY'), NULL);
INSERT INTO SEZNAM_MIST_V_EKSPOZICI
VALUES (misto_v_exp_seq.NEXTVAL, 4, 2, TO_DATE('14/03/2020', 'DD/MM/YYYY'), NULL);
INSERT INTO SEZNAM_MIST_V_EKSPOZICI
VALUES (misto_v_exp_seq.NEXTVAL, 5, 3, TO_DATE('26/03/2020', 'DD/MM/YYYY'), NULL);
-------------------------------------------------------------------
-- Selects
-- Nepouzite vybaveni
SELECT nazev, COUNT(*) pocet_nepouzitich_vybaveni  
FROM VYBAVENI
WHERE id_misto IS NULL
GROUP BY nazev;

-- Prehled plochy
SELECT id_mistnost,typ_mista, SUM(velikost) plocha 
FROM MISTO 
GROUP BY id_mistnost ,typ_mista 
ORDER BY id_mistnost ASC;

-- Neprirzeni pracovnikove
SELECT jmeno, prijmeni FROM ZAMESTNANEC_V
WHERE id_zamestnanec NOT IN (SELECT id_zamestnanec_m FROM MISTO);

-- Pronajimateli, kteri jsou firmy
SELECT P.jmeno, P.prijmeni, F.nazev 
FROM PRONAJIMATEL P, FIRMA F 
WHERE P.id_pronajimatel = f.id_pronajmatel;

-- Vsechny nezaplacene expozice
SELECT E.id_expozice, E.nazev_expozice 
FROM EXPOZICE E, POPLATEK P 
WHERE E.id_poplatku = P.id_cislo_poplatku 
AND P.datum_zaplaceni IS NULL;

-- Seznam tranzacki a pronajmatelu, kteri platily za stejnou expozici nekolikrat
SELECT DISTINCT pop.id_cislo_poplatku ,P.*, st1.suma
FROM PRONAJIMATEL P, SEZNAM_TRANSAKCI ST1, SEZNAM_TRANSAKCI ST2, POPLATEK POP
WHERE ST1.id_transakci != ST2.id_transakci
AND ST1.id_pronajmatel = ST2.id_pronajmatel
AND ST1.id_poplatek = ST2.id_poplatek
AND pop.id_cislo_poplatku = st1.id_poplatek
AND ST1.id_pronajmatel = P.id_pronajimatel
order by id_pronajimatel;


SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(format=>'ALLSTATS'));

-- je li delo vystavene v nejake expozici
SELECT *
FROM delo d
WHERE d.id_dela = 3 AND
EXISTS(
SELECT *
FROM SEZNAM_DEL_V_EXPOZICI SD
WHERE sd.id_delo = d.id_dela);

---------------------------------------------------------
-- Materialize view
CREATE MATERIALIZED VIEW MY_VIEW AS
SELECT m.id_mistnost, z.id_zamestnanec, m.typ_mista, SUM(m.velikost) plocha
FROM XKORNI02.MISTO M, XKORNI02.zamestnanec_v Z
WHERE m.id_zamestnanec_m = z.id_zamestnanec
GROUP BY m.id_mistnost, m.typ_mista, z.id_zamestnanec
ORDER BY m.id_mistnost ASC;

SELECT * FROM MY_VIEW;

UPDATE MY_VIEW SET typ_mista = 'stena'
WHERE typ_mista = 'sssstena';

--GRANT ALL PRIVILEGES ON XKORNI02.MISTO to XYADLO00;
--GRANT ALL PRIVILEGES ON XKORNI02.ZAMESTNANEC_V to XYADLO00;

----------------------------------------------------------
-- Upgrade perfomance
EXPLAIN PLAN FOR
SELECT M.velikost, M.typ_mista, COUNT(*) FROM MISTO M 
JOIN seznam_mist_v_ekspozici S ON S.id_misto = M.id_misto
JOIN seznam_del_v_expozici SD ON S.id_ekspozici = sd.id_expozici
WHERE M.typ_mista = 'stena'
GROUP BY M.velikost, M.typ_mista;

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

CREATE INDEX IDX ON Misto(typ_mista);

EXPLAIN PLAN FOR
SELECT M.velikost, M.typ_mista, COUNT(*) FROM MISTO M 
JOIN seznam_mist_v_ekspozici S ON S.id_misto = M.id_misto
JOIN seznam_del_v_expozici SD ON S.id_ekspozici = sd.id_expozici
WHERE M.typ_mista = 'stena'
GROUP BY M.velikost, M.typ_mista;

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

DROP INDEX IDX;


-----------------------------------------------------------------
-- Procedures
SET SERVEROUTPUT ON;
create or replace PROCEDURE CHANGE_POPIS
AS
    usedVar vybaveni.popis%TYPE := 'pouziva se';
    unusedVar vybaveni.popis%TYPE := 'NEpouziva se';
    noinfo vybaveni.popis%TYPE := 'popis zatim neni';
    CURSOR MY_CURSOR IS
        SELECT * FROM VYBAVENI;
    tempBoolVar boolean := false;
BEGIN
    UPDATE VYBAVENI SET popis = unusedVar
    WHERE id_misto is NULL;
    FOR MYELEMENT IN MY_CURSOR
    LOOP
        IF MYELEMENT.id_misto is NULL THEN
            tempBoolVar := true;
        END IF;
    END LOOP;
   IF tempBoolVar THEN 
    UPDATE VYBAVENI SET popis = usedVar
    WHERE id_misto is not NULL AND popis is NULL;
   ELSIF not tempBoolVar THEN
    UPDATE VYBAVENI SET popis = noinfo
    WHERE popis is NULL;
   END IF;  
END CHANGE_POPIS;
/

CREATE OR REPLACE PROCEDURE COST_CHECK
AS
temp INT;
res FLOAT(10.5);
CURSOR MY_CURSOR IS
SELECT * FROM MISTO;
BEGIN
DBMS_OUTPUT.PUT_LINE('| id_misto |' || 'velikost |' || 'cena |' || 'cena za jeden metr ctverecni');
FOR MYELEMENT IN MY_CURSOR
LOOP
BEGIN
IF MYELEMENT.velikost is null THEN
MYELEMENT.velikost := 0;
END IF;
IF MYELEMENT.cena is null THEN
MYELEMENT.cena :=0;
END IF;
res := MYELEMENT.cena/MYELEMENT.velikost;
DBMS_OUTPUT.PUT_LINE('| ' || MYELEMENT.id_misto || ' |' || MYELEMENT.velikost || ' |' || MYELEMENT.cena || ' |' || res);
EXCEPTION
WHEN zero_divide THEN
DBMS_OUTPUT.PUT_LINE('| ' || MYELEMENT.id_misto || ' |' || MYELEMENT.velikost || ' |' || MYELEMENT.cena || ' |' || 'Prve zadejte velikost!');
END;
END LOOP;
END COST_CHECK;


