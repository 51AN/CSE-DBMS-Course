conn SYSTEM/12345678

GRANT ALL PRIVILEGES TO s200042151;

conn s200042151/cse4308


SET SERVEROUTPUT ON SIZE 1000000


--> 1 <--

DECLARE
    TOTAL_ROWS NUMBER (2);
BEGIN
    UPDATE INSTRUCTOR
        SET SALARY = SALARY + (SALARY * 0.1)
        WHERE SALARY < 75000 ;
    IF SQL % NOTFOUND THEN
        DBMS_OUTPUT . PUT_LINE ( 'No instructor satisfied the condition ');
    ELSIF SQL % FOUND THEN
        TOTAL_ROWS := SQL % ROWCOUNT ;
    DBMS_OUTPUT . PUT_LINE ( TOTAL_ROWS || ' instructors incremented ');
    END IF;
END ;
/


--> 2 <--

SELECT T.TIME_SLOT_ID, T.DAY, T.start_hr, T.start_min ,T.end_hr, T.end_min
FROM INSTRUCTOR NATURAL JOIN TEACHES NATURAL JOIN SECTION NATURAL JOIN TIME_SLOT T;



SELECT T.TIME_SLOT_ID, T.DAY, T.start_hr, T.start_min ,T.end_hr, T.end_min
FROM INSTRUCTOR, TEACHES, SECTION,TIME_SLOT T;

--> 3 <--

CREATE OR REPLACE
PROCEDURE FIND_ADVISORS(NUM IN NUMBER)
AS
ROW NUMBER(5);
BEGIN
    SELECT MAX(ROWNUM) INTO ROW 
    FROM (SELECT I_ID, COUNT(S_ID) AS S_COUNT FROM ADVISOR GROUP BY I_ID ORDER BY S_COUNT DESC);

    IF(NUM>ROW) THEN 
        DBMS_OUTPUT . PUT_LINE ('Input exceeds number of entries');
        RETURN;
    END IF;

    FOR i IN (SELECT * FROM (SELECT I_ID, COUNT(S_ID) AS S_COUNT FROM ADVISOR GROUP BY I_ID ORDER BY S_COUNT DESC) WHERE ROWNUM<=NUM) LOOP
        DBMS_OUTPUT . PUT_LINE (i.I_ID || ' ' || i.S_COUNT);
    END LOOP;

END;
/

DECLARE
    NUM NUMBER(5);
BEGIN 
    NUM := '& number';
    FIND_ADVISORS(NUM);

END;
/

--> 4 <--


CREATE SEQUENCE STUDENT_SEQ
MINVALUE 1
MAXVALUE 9999
START WITH 1
INCREMENT BY 1
CACHE 20;

-- CREATE OR REPLACE
-- TRIGGER STUDENT_ID_GENERATOR
-- BEFORE INSERT ON STUDENT
-- FOR EACH ROW
-- BEGIN
--     :NEW.ID := STUDENT_SEQ . NEXTVAL ;
-- END ;
-- /

CREATE OR REPLACE
    TRIGGER STUDENT_ID_GENERATOR
    BEFORE INSERT ON STUDENT
    FOR EACH ROW
DECLARE
    NEW_ID STUDENT .ID% TYPE ;
BEGIN
    SELECT STUDENT_SEQ . NEXTVAL INTO NEW_ID
    FROM DUAL ;
    :NEW.ID := NEW_ID ;
END ;
/

--> 5 <--

CREATE OR REPLACE
    TRIGGER ADVISOR_ASSIGNER
    AFTER INSERT ON STUDENT
    FOR EACH ROW
DECLARE
    INS_ID INSTRUCTOR.ID% TYPE ;
BEGIN
    
END ;
/

