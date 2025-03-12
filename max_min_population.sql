/* Write a SQL Query to find the maximum and minimum populated cities corresponding to each state */

/* Given Tables */
script:
CREATE TABLE city_population (
    state VARCHAR(50),
    city VARCHAR(50),
    population INT
);

/* Insert Data into Team Table */
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'ambala', 100);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'panipat', 200);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'gurgaon', 300);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'amritsar', 150);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'ludhiana', 400);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'jalandhar', 250);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'mumbai', 1000);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'pune', 600);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'nagpur', 300);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'bangalore', 900);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mysore', 400);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mangalore', 200);

/* SQL Query Output - 1st solution */

WITH cte1 AS(SELECT *,
MAX(population)OVER(PARTITION BY state) as max_population,
MIN(population)OVER(PARTITION BY state) AS min_population
FROM city_population)

SELECT state,
MAX(CASE WHEN population = max_population THEN city END) as max_population_city,
MAX(CASE WHEN population = min_population THEN city END) as min_population_city
FROM cte1
GROUP BY state

/* SQL Query Output - 2nd solution */

WITH cte1 AS(SELECT *,
ROW_NUMBER()OVER(PARTITION BY state ORDER BY population DESC) AS max_population,
ROW_NUMBER()OVER (PARTITION BY state ORDER BY population ASC) AS min_population
FROM city_population)

SELECT state, 
MAX(CASE WHEN max_population =1 THEN city END) AS max_population_city,
MAX(CASE WHEN min_population =1 THEN city END) AS min_population_city
FROM cte1
GROUP BY state


/* Query Result */
state	      max_population_city	  min_population_city
haryana	        gurgaon	                ambala
karnataka      	bangalore	              mangalore
maharashtra     mumbai	                nagpur
punjab	        ludhiana	              amritsar
