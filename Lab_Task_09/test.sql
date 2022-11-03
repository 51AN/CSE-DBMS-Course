
-- Declare function
CREATE OR REPLACE
FUNCTION COMPOUND_INTEREST (PA NUMBER , AIR NUMBER , TF NUMBER )
RETURN NUMBER
IS
CI NUMBER ;
BEGIN
CI := PA * ((1 + (AIR / 100)) ** TF) - PA;
RETURN CI;
END ;
/
-- Call it from an anonymous block
BEGIN
DBMS_OUTPUT . PUT_LINE ( COMPOUND_INTEREST (10000 , 5, 5));
END ;
/


select *
from BRANCH
ORDER BY BRANCH.ASSETS DESC;


DECLARE
    name1 VARCHAR2(20);
    name2 VARCHAR2(20);
BEGIN
    name1 := '& Name_1';
    name2 := '& Name_2';
    DBMS_OUTPUT.PUT_LINE(name1 || ' + ' || name2 /*IN VARCHAR2*/);
END;
/