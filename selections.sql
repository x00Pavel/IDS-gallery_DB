SELECT U.id_umelec, U.id_pronajmatel FROM UMELEC U;



-- Spojeni tabulky sama s sebou
-- Ktery pronajmateli zijuo na stejen adresse? 
SELECT DISTINCT P1.*
FROM PRONAJIMATEL P1, PRONAJIMATEL P2
WHERE P1.fk_id_adress = P2.fk_id_adress
        AND P1.id_pronajimatel != P2.id_pronajimatel;
     
     
        
-- Ktery pronajmateli platily za jeden popla?
-- uvest vsechny transakci za ktere placlili ne jednou 
SELECT distinct
   pop.id_cislo_poplatku ,P.*, st1.suma
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
    ST1.id_pronajmatel = P.id_pronajimatel
order by 
    id_pronajimatel;
    
-- seznam del v oplacene ekspozici

select *
from delo d
where 
d.id_dela = 3 and 
exists(
    select * 
    from SEZNAM_DEL_V_EXPOZICI SD
    where sd.id_delo = d.id_dela
)  
