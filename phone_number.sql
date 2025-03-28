/* Write a SQL Query to get the start time and end time of each call between the two tables. Also create a call duratioon in minutes*/


/* Given Tables */

create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);

create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);

/* Insert Data into Team Table */
insert into call_start_logs values
('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00')

insert into call_end_logs values
('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
;

/* SQL Query Output */
WITH start_logs_rnk AS
(SELECT phone_number,start_time,
ROW_NUMBER()OVER(PARTITION BY phone_number ORDER BY start_time) as start_rnk
FROM call_start_logs)
,end_logs_rnk AS
(SELECT phone_number,end_time,
ROW_NUMBER()OVER(PARTITION BY phone_number ORDER BY end_time) as end_rnk
 FROM call_end_logs)

SELECT s1.phone_number,start_time,end_time,DATEDIFF(MINUTE, start_time, end_time) as duration
FROM start_logs_rnk s1
INNER JOIN end_logs_rnk e1
ON s1.start_rnk = e1.end_rnk AND s1.phone_number = e1.phone_number

/* Query Result */

phone_number	start_time	end_time	duration
PN1	2022-01-01 10:20:00.000	2022-01-01 10:45:00.000	25
PN1	2022-01-01 16:25:00.000	2022-01-01 17:05:00.000	40
PN2	2022-01-01 12:30:00.000	2022-01-01 12:55:00.000	25
PN3	2022-01-02 10:00:00.000	2022-01-02 10:20:00.000	20
PN3	2022-01-02 12:30:00.000	2022-01-02 12:50:00.000	20
PN3	2022-01-03 09:20:00.000	2022-01-03 09:40:00.000	20
