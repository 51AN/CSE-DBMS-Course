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
    NAME := '&name';
    DBMS_OUTPUT . PUT_LINE ( ' The length of my name is ' || LENGTH(NAME) );
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
    DBMS_OUTPUT . PUT_LINE ( TO_CHAR ( D, 'DD-MON-YY HH24:MI:SS '));
END ;
/

--e--
--without case
DECLARE
    NUM NUMBER(5);
BEGIN 
    NUM := '& number';
    IF MOD(NUM,2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Number is ODD');
    ELSE
        DBMS_OUTPUT . PUT_LINE ( 'Number is EVEN');
    END IF;
END;
/

--with case
DECLARE
    NUM NUMBER(5);
BEGIN 
    NUM := '& number';
    CASE MOD(NUM,2)
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('Number is ODD');
        WHEN 0 THEN
            DBMS_OUTPUT . PUT_LINE ( 'Number is EVEN');
        ELSE
            DBMS_OUTPUT . PUT_LINE ( 'Error!');
    END CASE;
END;
/
--f--

CREATE OR REPLACE
PROCEDURE FIND_PRIME ( NUM IN NUMBER , VERDICT OUT VARCHAR2 )
AS
BEGIN
    VERDICT := 'Number is prime';
    FOR i IN 2 .. (NUM/2)
        LOOP
            IF MOD(NUM, i) = 0 THEN
                VERDICT := 'Number is not prime';
                EXIT;
            END IF;
        END LOOP;

END;
/

DECLARE
    NUM NUMBER(5);
    VERIFY VARCHAR2(20);
BEGIN 
    NUM := '& number';
    FIND_PRIME(NUM,VERIFY);
    DBMS_OUTPUT . PUT_LINE (VERIFY);

END;
/







-->2<--

--a--
CREATE OR REPLACE
PROCEDURE FIND_BRANCHES(NUM IN NUMBER)
AS
ROW NUMBER(5);
BEGIN
    SELECT MAX(ROWNUM) INTO ROW 
    FROM (SELECT * FROM BRANCH ORDER BY ASSETS DESC);

    IF(NUM>ROW) THEN 
        DBMS_OUTPUT . PUT_LINE ('Input exceeds number of entries');
        RETURN;
    END IF;

    FOR i IN (SELECT * FROM (SELECT * FROM BRANCH ORDER BY ASSETS DESC) WHERE ROWNUM<=NUM) LOOP
        DBMS_OUTPUT . PUT_LINE (i.BRANCH_NAME || ' ' || i.BRANCH_CITY || ' ' || i.ASSETS);
    END LOOP;

END;
/

DECLARE
    NUM NUMBER(5);
BEGIN 
    NUM := '& number';
    FIND_BRANCHES(NUM);

END;
/


--b--

CREATE OR REPLACE
PROCEDURE CustomerStatus(CustomerName IN VARCHAR2)
AS
    NET_BALANCE number;
    NET_LOAN number;
BEGIN
    SELECT sum(account.balance) INTO NET_BALANCE FROM account,depositor WHERE depositor.customer_name=CustomerName and depositor.account_number=account.account_number;
    SELECT sum(loan.amount) INTO NET_LOAN FROM borrower,loan WHERE borrower.customer_name=CustomerName and borrower.loan_number=loan.loan_number;
    IF((NET_BALANCE)<=(NET_LOAN)) THEN
        DBMS_OUTPUT.PUT_LINE('Green Zone');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Red Zone');
    END IF;
END;
/

DECLARE
    Name VARCHAR2(15);
BEGIN
    
    CustomerStatus('Hayes');
END;
/

