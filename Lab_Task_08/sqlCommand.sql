--1
SELECT COUNT(t_id) as Transaction_45 FROM TRANSACTIONS WHERE a_id = '45';

--2
SELECT COUNT(type) as Totaldebit FROM TRANSACTIONS WHERE type = '1';

--3
SELECT a_id,amount,type,EXTRACT( YEAR FROM DTM) as year FROM TRANSACTIONS  GROUP BY a_id,amount,type,EXTRACT( YEAR FROM DTM) HAVING EXTRACT( YEAR FROM DTM) = '2020';

--4
--given solution.java query
