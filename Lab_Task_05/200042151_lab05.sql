--> 1 <--

create or replace view Advisor_Selection as 
select ID, name, dept_name
from instructor;

--> 2 <--

create or replace view Student_Count AS
select name, count(s_id) as count_student
from Advisor_Selection natural join advisor 
GROUP BY name;

select * from Student_Count;

--> 3 <--

--a
drop role Students;
create role Students;

GRANT SELECT ON s200042151.advisor to Students;
GRANT SELECT ON s200042151.course to Students;

--b
drop role course_teacher;
create role course_teacher;

GRANT SELECT ON s200042151.student to course_teacher;
GRANT SELECT ON s200042151.course to course_teacher;

--c
drop role dept_head;
create role dept_head;

GRANT course_teacher to dept_head;
GRANT SELECT ON s200042151.instructor to dept_head;
GRANT INSERT ON s200042151.instructor to dept_head;

--d
drop role Administrator;
create role Administrator;

GRANT SELECT ON s200042151.department to Administrator;
GRANT SELECT ON s200042151.instructor to Administrator;
GRANT UPDATE (budget) ON s200042151.department to Administrator;


--> 4 <--
DROP USER Adon;
CREATE USER Adon IDENTIFIED BY s1234;
GRANT Students TO Adon;


DROP USER Dihan;
CREATE USER Dihan IDENTIFIED BY d1234;
GRANT course_teacher TO Dihan;


DROP USER ARMK;
CREATE USER ARMK IDENTIFIED BY a1234;
GRANT dept_head TO ARMK;


DROP USER Mirza;
CREATE USER Mirza IDENTIFIED BY m1234;
GRANT Administrator TO Mirza;


GRANT CREATE SESSION TO Adon;
GRANT CREATE SESSION TO Dihan;
GRANT CREATE SESSION TO ARMK;
GRANT CREATE SESSION TO Mirza;



conn Adon/s1234
SELECT * FROM s200042151.advisor;
SELECT * FROM s200042151.course;
--will not show--
SELECT * FROM s200042151.instructor; 
--will not show--
SELECT * FROM s200042151.teaches; 



conn Dihan/d1234
conn Dihan/d1234
SELECT * FROM s200042151.student;
SELECT * FROM s200042151.course;
--will not show--
SELECT * FROM s200042151.instructor; 
--will not show--
SELECT * FROM s200042151.teaches;
--will not show--
SELECT * FROM s200042151.instructor; 
--will not show--
SELECT * FROM s200042151.teaches; 


conn ARMK/a1234
SELECT * FROM s200042151.student;
SELECT * FROM s200042151.course;
SELECT * FROM s200042151.instructor; 
--will not show--
SELECT * FROM s200042151.teaches; 

INSERT INTO s200042151.instructor values ('10102', 'Sian', 'Comp. Sci.', '45000');
--add new instructor--
SELECT * FROM s200042151.instructor; 



conn Mirza/m1234
SELECT * FROM s200042151.department;
SELECT * FROM s200042151.instructor;
--doesn't show--
SELECT * FROM s200042151.teaches;

UPDATE s200042151.department SET budget = 12000
WHERE dept_name = 'History';

SELECT * FROM s200042151.department;


