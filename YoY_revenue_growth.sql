/* Write a SQL Query to identify YoY revenue growth companies*/


/* Given Tables */

create table company_revenue 
(
company varchar(100),
year int,
revenue int
)


/* Insert Data into Team Table */
insert into company_revenue values 
('ABC1',2000,100),('ABC1',2001,110),('ABC1',2002,120),('ABC2',2000,100),('ABC2',2001,90),('ABC2',2002,120)
,('ABC3',2000,500),('ABC3',2001,400),('ABC3',2002,600),('ABC3',2003,800);



/* SQL Query Output Solution 1 */

WITH CTE AS(SELECT *,
CASE WHEN LAG(revenue,1,0)OVER(PARTITION BY company ORDER BY year) < revenue THEN 1 ELSE 0 END as flag
FROM company_revenue)

SELECT company
FROM CTE
GROUP BY company
HAVING COUNT(*) = SUM(flag)


/* SQL Query Output - Solution 2*/

WITH CTE AS(SELECT *,
LAG(revenue,1,0)OVER(PARTITION BY company ORDER BY year) as lag_revenue,
revenue - LAG(revenue,1,0)OVER(PARTITION BY company ORDER BY year) as revenue_diff,
COUNT(*)over(partition by company) as cnt
FROM company_revenue)


SELECT company
FROM CTE
WHERE revenue_diff > 0
GROUP BY company,cnt
HAVING COUNT(*) = cnt

/* SQL Query Output - Solution 3*/


WITH CTE AS(SELECT *,
LAG(revenue,1,0)OVER(PARTITION BY company ORDER BY year) as lag_revenue,
revenue - LAG(revenue,1,0)OVER(PARTITION BY company ORDER BY year) as revenue_diff,
COUNT(*)over(partition by company) as cnt
FROM company_revenue)


SELECT company
FROM CTE
WHERE company NOT IN (SELECT company FROM CTE WHERE revenue_diff < 0)
GROUP BY company

/* Query Result */

company
ABC1
