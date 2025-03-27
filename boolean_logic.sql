/* Given a table Ameriprise_LLC with columns teamID, Criteria1, and Criteria2, write a query that performs the following operations:

Identify all teams (teamID) where both Criteria1 and Criteria2 are 'Y', and the team has at least 2 records meeting this condition.

For all records in the table, output all columns, and create a new column output which should contain 'Y' if:

The record's Criteria1 is 'Y' and Criteria2 is 'Y', and

The teamID appears in the set of teams identified in the previous step. Otherwise, the output should be 'N'.

Write the SQL query to achieve this.*/


/* Given Tables */

create table Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
);

/* Insert Data into Team Table */
insert into Ameriprise_LLC values 
('T1','T1_mbr1','Y','Y'),
('T1','T1_mbr2','Y','Y'),
('T1','T1_mbr3','Y','Y'),
('T1','T1_mbr4','Y','Y'),
('T1','T1_mbr5','Y','N'),
('T2','T2_mbr1','Y','Y'),
('T2','T2_mbr2','Y','N'),
('T2','T2_mbr3','N','Y'),
('T2','T2_mbr4','N','N'),
('T2','T2_mbr5','N','N'),
('T3','T3_mbr1','Y','Y'),
('T3','T3_mbr2','Y','Y'),
('T3','T3_mbr3','N','Y'),
('T3','T3_mbr4','N','Y'),
('T3','T3_mbr5','Y','N');

/* SQL Query Output */
SELECT *,
CASE WHEN Criteria1 ='Y' AND Criteria2 ='Y' AND
SUM(CASE WHEN Criteria1 ='Y' AND Criteria2 ='Y' THEN 1 ELSE 0 END) OVER(partition by teamid)>=2
THEN 'Y' ELSE 'N' end AS output
FROM Ameriprise_LLC

/*SQL Query Output */

WITH y_teams AS(SELECT teamID
FROM Ameriprise_LLC
WHERE Criteria1 = 'Y' AND Criteria2 ='Y'
GROUP BY teamID
HAVING COUNT(*) >= 2)

SELECT *,
CASE WHEN Criteria1 ='Y' AND Criteria2 ='Y' AND t2.teamID IS NOT NULL THEN 'Y' ELSE 'N' END AS output
FROM Ameriprise_LLC t1
LEFT JOIN y_teams t2
ON t1.teamID = t2.teamID



/* Query Result */

teamID	memberID	Criteria1	Criteria2	output
T1	T1_mbr1	Y	Y	Y
T1	T1_mbr2	Y	Y	Y
T1	T1_mbr3	Y	Y	Y
T1	T1_mbr4	Y	Y	Y
T1	T1_mbr5	Y	N	N
T2	T2_mbr1	Y	Y	N
T2	T2_mbr2	Y	N	N
T2	T2_mbr3	N	Y	N
T2	T2_mbr4	N	N	N
T2	T2_mbr5	N	N	N
T3	T3_mbr1	Y	Y	Y
T3	T3_mbr2	Y	Y	Y
T3	T3_mbr3	N	Y	N
T3	T3_mbr4	N	Y	N
T3	T3_mbr5	Y	N	N
