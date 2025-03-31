/* Write a SQL Query to identofy all employees having same salary in the same deapartment*/


/* Given Tables */

CREATE TABLE [emp_salary]
(
    [emp_id] INTEGER  NOT NULL,
    [name] NVARCHAR(20)  NOT NULL,
    [salary] NVARCHAR(30),
    [dept_id] INTEGER
);


/* Insert Data into Team Table */
INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');

/* SQL Query Output */
WITH CTE AS(SELECT dept_id,salary
FROM emp_salary
GROUP BY dept_id,salary
HAVING COUNT(*) > 1)


SELECT emp_id,name,t1.salary,t1.dept_id
FROM emp_salary t1
INNER JOIN CTE t2
ON t1.dept_id = t2.dept_id AND t1.salary = t2.salary



/* SQL Query Output */
WITH CTE AS(SELECT *,
COUNT(*)OVER(PARTITION BY dept_id,salary) as COUNT
FROM emp_salary)

SELECT * FROM CTE
WHERE COUNT>1

/* SQL Query Output */

SELECT a.* FROM emp_Salary a INNER JOIN emp_salary b
ON a.emp_id!=b.emp_id AND a.salary =b.salary AND a.dept_id=b.dept_id


/* Query Result */

emp_id	name	salary	dept_id	COUNT
101	sohan	3000	11	2
104	cat	3000	11	2
105	suresh	4000	12	2
102	rohan	4000	12	2
