/* Write a SQL Query to find actual buisness days between two dates */

/* Given Tables */
create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);

create table holidays
(
holiday_date date
,reason varchar(100)
);

/* Insert Data into Team Table */

delete from tickets;
insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');

delete from holidays;
insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');
    
/* SQL Query Output - 1st solution with only min_size*/

SELECT *,DATEDIFF(day,create_date,resolved_date) AS actual_days,
DATEDIFF(day,create_date,resolved_date)-2*DATEDIFF(week,create_date,resolved_date)-holidays as buisness_days
FROM (
SELECT ticket_id,create_date,resolved_date,COUNT(holiday_date) as holidays
FROM tickets
LEFT JOIN holidays
ON holiday_date BETWEEN create_date AND resolved_date
GROUP BY ticket_id,create_date,resolved_date)temp


/* Query Result */

ticket_id	create_date	resolved_date	holidays	actual_days	buisness_days
1	2022-08-01	2022-08-03	0	2	2
2	2022-08-01	2022-08-12	1	11	8
3	2022-08-01	2022-08-16	2	15	9
