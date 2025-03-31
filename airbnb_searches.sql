/* Write a SQL Query to fidn the room types that are searched the more no.of.times*/


/* Given Tables */

create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);


/* Insert Data into Team Table */
delete from airbnb_searches;
insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')
;


/* SQL Query Output */
SELECT value,COUNT(value) as type
FROM airbnb_searches
CROSS APPLY string_split(filter_room_types,',')
GROUP BY value
ORDER BY type DESC

/* Query Result */

value	type
private room	3
shared room	2
entire home	2
