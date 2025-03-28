/* Find the maximum and minimum salary employees in each department*/


/* Given Tables */

create table employee 
(
emp_name varchar(10),
dep_id int,
salary int
);

/* Insert Data into Team Table */
delete from employee;
insert into employee values 
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000);


/* SQL Query Output */
WITH CTE AS(SELECT dep_id, MAX(salary) as max_salary, MIN(salary) as min_salary
FROM employee
GROUP BY dep_id)

SELECT t1.dep_id,
MAX(CASE WHEN salary = max_Salary THEN emp_name END) AS emp_name_max_salary,
MAX(CASE WHEN salary = min_salary THEN emp_name END) AS emp_name_min_salary
FROM employee t1
INNER JOIN CTE t2
ON t1.dep_id = t2.dep_id
GROUP BY t1.dep_id


/* SQL Query using rank function */
WITH CTE AS(SELECT *,
ROW_NUMBER()OVER(PARTITION BY dep_id ORDER BY salary) AS min_rnk,
ROW_NUMBER()OVER(PARTITION BY dep_id ORDER BY salary DESC) AS max_rnk
FROM employee)

SELECT dep_id,
MAX(CASE WHEN min_rnk = 1 THEN emp_name END) AS emp_name_min_salary,
MAX(CASE WHEN max_rnk = 1 THEN emp_name END) AS emp_name_max_salary
FROM CTE
GROUP BY dep_id



/* Query Result */

dep_id	emp_name_max_salary	emp_name_min_salary
1	Prasad	Siva
2	Ravi	Sai
