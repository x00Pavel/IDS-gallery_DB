-------------------------ADRESA---------------------------
INSERT INTO ADRESA
VALUES (0, 62400, 'Cichnova', 'Brno');
INSERT INTO ADRESA
VALUES (1, 62300, 'Pionirska', 'Brno');
INSERT INTO ADRESA
VALUES (2, 60300, 'Husitska', 'Brno');
INSERT INTO ADRESA
VALUES (3, 65100, 'Hlavni', 'Brno');
INSERT INTO ADRESA
VALUES (4, 64700, 'Ceska', 'Brno');
---------------------------MISTNOST----------------------------
INSERT INTO MISTNOST
VALUES (0, 5);
INSERT INTO MISTNOST
VALUES (1, 7);
INSERT INTO MISTNOST
VALUES (2, 15);
INSERT INTO MISTNOST
VALUES (3, 3);
INSERT INTO MISTNOST
VALUES (4, 1);
---------------------------ZAMESTANEC----------------------------
INSERT INTO ZAMESTANEC
VALUES (0, 'Oleksii', 'Korniienko', 0);
INSERT INTO ZAMESTANEC
VALUES (1, 'Pavel', 'Yadlouskii', 1);
INSERT INTO ZAMESTANEC
VALUES (2, 'Raul', 'Arghayev', 2);
---------------------------POPLATEK------------------------------------
INSERT INTO POPLATEK
VALUES (0, 1, TO_DATE('13/03/2020', 'DD/MM/YYYY'), TO_DATE('13/03/2020', 'DD/MM/YYYY'));
INSERT INTO POPLATEK
VALUES (1, 0, TO_DATE('14/03/2020', 'DD/MM/YYYY'), NULL);
INSERT INTO POPLATEK
VALUES (2, 0, TO_DATE('26/03/2020', 'DD/MM/YYYY'), NULL);
INSERT INTO POPLATEK
VALUES (3, 1, TO_DATE('02/03/2020', 'DD/MM/YYYY'), TO_DATE('27/02/2020', 'DD/MM/YYYY'));
INSERT INTO POPLATEK
VALUES (4, 0, TO_DATE('11/03/2020', 'DD/MM/YYYY'), NULL);
---------------------------EXPOZICE------------------------------------
INSERT INTO EXPOZICE
VALUES ('Snail`s top1 expozice', 0, TO_DATE('13/03/2020', 'DD/MM/YYYY'), TO_DATE('20/03/2020', 'DD/MM/YYYY'), 'obrazky', 'Nejlepsi obrazky ze vseho sveta!');
INSERT INTO EXPOZICE
VALUES ('Plovec`s top1 expozice', 1, TO_DATE('14/03/2020', 'DD/MM/YYYY'), TO_DATE('21/03/2020', 'DD/MM/YYYY'), 'sochy', NULL);
INSERT INTO EXPOZICE
VALUES ('Mona Liza', 2, TO_DATE('26/03/2020', 'DD/MM/YYYY'), TO_DATE('31/03/2020', 'DD/MM/YYYY'), 'obrazek', NULL);
---------------------------UMELEC------------------------------------
INSERT INTO UMELEC
VALUES (99030, 'Snail', NULL, 'Obrazky', TO_DATE('03/02/1999', 'DD/MM/YYYY'), NULL);
INSERT INTO UMELEC
VALUES (93170, 'Plovec', NULL, 'Sochy', TO_DATE('17/02/1993', 'DD/MM/YYYY'), NULL);
INSERT INTO UMELEC
VALUES (15300, 'Ragul', NULL, 'Obrazky', TO_DATE('30/03/2005', 'DD/MM/YYYY'), NULL);
---------------------------DELO------------------------------------
INSERT INTO DELO
VALUES (0, 'Snail`s top1 expozice', 99030 , 'First obrazek', TO_DATE('09/09/1999', 'DD/MM/YYYY'), 'obrazek', 'Snail,obrazek,first');
INSERT INTO DELO
VALUES (1, 'Plovec`s top1 expozice', 93170 , 'alomalo', TO_DATE('11/11/2011', 'DD/MM/YYYY'), 'socha', 'Plovec,socha');
INSERT INTO DELO
VALUES (2, 'Mona Liza', NULL , 'Jaconda', TO_DATE('01/01/1995', 'DD/MM/YYYY'), 'obrazek', 'Mona Liza, Jaconda');
---------------------------FIRMA------------------------------------
INSERT INTO FIRMA
VALUES (01234, 'Snail`s Company', 3);
INSERT INTO FIRMA
VALUES (09876, 'Plovec`s Company', 4);
---------------------------PRONAJIMATEL------------------------------------
INSERT INTO PRONAJIMATEL
VALUES (0, 'Oleksii', 'Korniienko', 0, 0, 99030, NULL );
INSERT INTO PRONAJIMATEL
VALUES (1, 'Pavel', 'Yadlouski', 0, 0, 99030, 09876);
---------------------------MISTO------------------------------------
INSERT INTO MISTO
VALUES (0, 0, 0, 100, 500);
INSERT INTO MISTO
VALUES (1, 0, 0, 100, 500);
INSERT INTO MISTO
VALUES (2, 1, 1, 200, 700);
INSERT INTO MISTO
VALUES (3, 2, 1, 300, 1200);
INSERT INTO MISTO
VALUES (4, 3, 2, 700, 2500);
---------------------------VYBAVENI------------------------------------
INSERT INTO VYBAVENI
VALUES (0, 0, 'lampa', 'sveti jako slunicko');
INSERT INTO VYBAVENI
VALUES (1, 0, 'ramecek', NULL);
INSERT INTO VYBAVENI
VALUES (2, 0, 'ramecek', 'proste bozi');
INSERT INTO VYBAVENI
VALUES (3, 1, 'ramecek', NULL);
INSERT INTO VYBAVENI
VALUES (4, 2, 'podstavec', NULL);
INSERT INTO VYBAVENI
VALUES (5, 2, 'podstavec', NULL);
INSERT INTO VYBAVENI
VALUES (6, 3, 'stůl', 'jako u kralovny');
INSERT INTO VYBAVENI
VALUES (7, 3, 'ramecek', NULL);
INSERT INTO VYBAVENI
VALUES (8, 4, 'stůl', NULL);