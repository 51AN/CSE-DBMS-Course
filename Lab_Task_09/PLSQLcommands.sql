conn SYSTEM/12345678

GRANT ALL PRIVILEGES TO s200042151;

conn s200042151/cse4308


SET SERVEROUTPUT ON SIZE 1000000
--> 1 <--

--a--
BEGIN
    DBMS_OUTPUT . PUT_LINE ( '200042151');
END ;
/

--b--
DECLARE
    NAME VARCHAR2 (20);
BEGIN
    NAME := '& name ';
    DBMS_OUTPUT . PUT_LINE ( ' My name is ' || NAME );
END ;
/

--c--
DECLARE
    NUM1 NUMBER(5);
    NUM2 NUMBER(5);
    SUMM NUMBER(10);
BEGIN
    NUM1 := '& first_number';
    NUM2 := '& second_number';
    SUMM := NUM1 + NUM2;
    DBMS_OUTPUT.PUT_LINE(' Summation : ' || SUMM);
END;
/

--d--
DECLARE
    D DATE := SYSDATE ;
BEGIN
    DBMS_OUTPUT . PUT_LINE ( TO_CHAR ( D, 'DD -MON -YY HH24 :MI:SS '));
END ;
/

