/* Write a SQL Query to identofy the no.of.employees inside the hospital*/


/* Given Tables */

create table hospital ( emp_id int
, action varchar(10)
, time datetime);


/* Insert Data into Team Table */
insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

/* SQL Query Output */
WITH CTE AS(SELECT emp_id,
MAX(CASE WHEN action ='in' THEN time END) as intime,
MAX(CASE WHEN action ='out' THEN time END) as outtime
FROM hospital
GROUP BY emp_id)


SELECT COUNT(*) as no_of_employees_in FROM CTE
WHERE intime > outtime OR outtime IS NULL

/* SQL Query Output */

WITH max_time AS(SELECT emp_id,MAX(time) as max_time
FROM hospital
GROUP BY emp_id)

SELECT COUNT(*) AS no_of_employees_in
FROM hospital h
INNER JOIN max_time mt
ON h.emp_id = mt.emp_id AND mt.max_time= h.time
WHERE h.action = 'in'

/* Query Result */

no_of_employees_in
3
