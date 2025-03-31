/* Write a SQL Query to identify nof of gold medals per swimmer for swimmer who has won only gold medals*/


/* Given Tables */

CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);


/* Insert Data into Team Table */
delete from events;

INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');



/* SQL Query Output Solution 1 */

SELECT GOLD as swimmer, COUNT(*) AS no_of_gold_medals FROM events
WHERE GOLD NOT IN (SELECT SILVER FROM events) AND GOLD NOT IN (SELECT BRONZE FROM events)
GROUP BY GOLD


/* SQL Query Output - Solution 2*/

WITH CTE AS 
(SELECT GOLD as swimmer, 'gold' as medal_type FROM events
UNION ALL
SELECT SILVER as swimmer, 'silver' as medal_type FROM events
UNION ALL
SELECT BRONZE as swimmer, 'bronze' as medal_type FROM events)


SELECT swimmer, COUNT(*) as no_of_gold_medals
FROM CTE
GROUP BY swimmer
HAVING COUNT(DISTINCT medal_type) = 1 AND MAX(medal_type) ='gold'



/* Query Result */

swimmer	no_of_gold_medals
Amthhew Mcgarray	1
Charles	3
jessica	1
Ronald	1
Thomas	3
