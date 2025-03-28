/* SQL Puzzle*/


/* Given Tables */

create table input (
id int,
formula varchar(10),
value int
)


/* Insert Data into Team Table */
insert into input values (1,'1+4',10),(2,'2+1',5),(3,'3-2',40),(4,'4-1',20);



/* SQL Query Output */

WITH CTE AS(SELECT *,
LEFT(formula,1) as f_d,
SUBSTRING(formula,2,1) as operator,
RIGHT(formula,1) as s_d
FROM input)

SELECT c1.id as id,c1.formula,
CASE WHEN c1.operator = '+' THEN ip1.value +ip2.value ELSE ip1.value - ip2.value END AS output
FROM CTE c1
INNER JOIN input ip1 ON ip1.id = c1.f_d
INNER JOIN input ip2 ON ip2.id = c1.s_d


/* Query Result */

id	formula	output
1	1+4	30
2	2+1	15
3	3-2	35
4	4-1	10
