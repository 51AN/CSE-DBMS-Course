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
create or replace
PROCEDURE customer_status(name in varchar2)
AS
balance number;
loan_ammount number;
BEGIN
    SELECT MAX(account.balance) INTO balance 
    FROM depositor, account
    WHERE depositor.customer_name = name and depositor.account_number = account.account_number;

    SELECT MAX(loan.amount) INTO loan_ammount 
    FROM borrower, loan 
    WHERE borrower.customer_name = name and borrower.loan_number = loan.loan_number;

    IF((balance) => (loan_ammount)) THEN
        DBMS_OUTPUT.PUT_LINE('Red Zone');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Green Zone');
    END IF;
END;  
/

DECLARE
    name VARCHAR2(15);
BEGIN
    name := '& Customer_Name';
    customer_status(name);
END;
/


--c--

create or replace
FUNCTION customer_tax(name VARCHAR2)
return NUMBER
AS
balance NUMBER;
tax number;
BEGIN
    SELECT MAX(account.balance) INTO balance 
    FROM depositor, account
    WHERE depositor.customer_name = name and depositor.account_number = account.account_number;

    IF((balance)>=750) THEN
        tax := (0.08*balance);
    ELSE
        tax := 0;
    END IF;

    RETURN tax;
END;
/

DECLARE
    name VARCHAR2(15);
BEGIN
    name := '& Customer_Name';
    
    DBMS_OUTPUT.PUT_LINE(customer_tax(name));
END;
/

--d--

create or replace
FUNCTION customer_category(name varchar2)
RETURN VARCHAR2
AS
balance NUMBER;
loan_ammount number;
category VARCHAR2(10);

BEGIN
    SELECT MAX(account.balance) INTO balance 
    FROM depositor, account
    WHERE depositor.customer_name = name and depositor.account_number = account.account_number;

    SELECT MAX(loan.amount) INTO loan_ammount 
    FROM borrower, loan 
    WHERE borrower.customer_name = name and borrower.loan_number = loan.loan_number;

    IF((balance) > 1000 AND (loan_ammount) < 1000) THEN
        category := 'C-A1';
    ELSIF((balance)<500 AND (loan_ammount)>2000) THEN
        category := 'C-C3';
    ELSE
        category :=' C-B1';
    END IF;
    RETURN category;
END;
/   


DECLARE
    name VARCHAR2(15);
BEGIN
    name := '& Customer_Name';
    DBMS_OUTPUT.PUT_LINE(customer_category(name));
END;
/
