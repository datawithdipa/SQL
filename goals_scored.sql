/* Write a SQL Query that lists every game with the goals scored by each team. The resuke set should have mdate,team1,score1,team2 and score2 */


/* Given Tables */

-- Create Team Table
CREATE TABLE Team (
    id CHAR(1) PRIMARY KEY,
    teamname VARCHAR(50),
    coach VARCHAR(50)
);

-- Create Goal Table
CREATE TABLE Goal (
    matchid INT,
    teamid CHAR(1),
    player VARCHAR(50),
    goal_time INT,
    
);

-- Create Game Table
CREATE TABLE Game (
    id INT PRIMARY KEY,
    mdate DATE,
    stadium VARCHAR(50),
    team1 CHAR(1),
    team2 CHAR(1),
    
);

/* Insert Data into Team Table */
INSERT INTO Team (id, teamname, coach) VALUES
('A', 'Team_A', 'Coach_A'),
('B', 'Team_B', 'Coach_B'),
('C', 'Team_C', 'Coach_C'),
('D', 'Team_D', 'Coach_D');

-- Insert Data into Goal Table
INSERT INTO Goal (matchid, teamid, player, goal_time) VALUES
(101, 'A', 'A1', 17),
(101, 'A', 'A9', 58),
(101, 'B', 'B7', 89),
(102, 'D', 'D10', 63);

-- Insert Data into Game Table
INSERT INTO Game (id, mdate, stadium, team1, team2) VALUES
(101, '2019-01-04', 'stadium1', 'A', 'B'),
(102, '2019-01-04', 'stadium3', 'D', 'E'),
(103, '2019-01-10', 'stadium1', 'A', 'C'),
(104, '2019-01-13', 'stadium2', 'B', 'E');



/* SQL Query Output */
SELECT mdate,team1,SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1,
team2,SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2
FROM game g1 LEFT JOIN goal g2 
ON g1.id=g2.matchid
GROUP BY mdate,team1,team2

/* Query Result */

mdate	      team1	score1	team2	score2
2019-01-04	  A	    2	      B	    1
2019-01-04	  D	    1	      E	    0
2019-01-10	  A	    0	      C	    0
2019-01-13	  B	    0	      E	    0
