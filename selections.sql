SELECT U.id_umelec, U.id_pronajmatel FROM UMELEC U;



-- Spojeni tabulky sama s sebou
-- Ktery pronajmateli zijuo na stejen adresse? 
SELECT DISTINCT P1.*
FROM PRONAJIMATEL P1, PRONAJIMATEL P2
WHERE P1.fk_id_adress = P2.fk_id_adress
        AND P1.id_pronajimatel != P2.id_pronajimatel;
     
     
        
-- Ktery pronajmateli platily za stejny poplatek?
SELECT DISTINCT
    P.*, st1.suma, pop.zbivajici_suma
FROM
    PRONAJIMATEL P, SEZNAM_TRANSAKCI ST1, SEZNAM_TRANSAKCI ST2, POPLATEK POP
WHERE
    
    ST1.id_transakci != ST2.id_transakci
    AND
    ST1.id_pronajmatel = ST2.id_pronajmatel
    AND
    ST1.id_poplatek = ST2.id_poplatek
    AND
    pop.id_cislo_poplatku = st1.id_poplatek
    AND
    ST1.id_pronajmatel = P.id_pronajimatel;