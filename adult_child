/* Write a SQL Query to identify adult_chid pairs*/


/* Given Tables */

create table family 
(
person varchar(5),
type varchar(10),
age int
);

/* Insert Data into Team Table */
delete from family ;
insert into family values ('A1','Adult',54)
,('A2','Adult',53),('A3','Adult',52),('A4','Adult',58),('A5','Adult',54),('C1','Child',20),('C2','Child',19),('C3','Child',22),('C4','Child',15);


/* SQL Query Output */
WITH adult AS
(
  SELECT *, ROW_NUMBER()OVER(ORDER BY person) as rnk FROM family WHERE type ='Adult'
  ), child AS
(
  SELECT *,ROW_NUMBER()OVER(ORDER BY person) as rnk FROM family WHERE type ='child'
 )
 
SELECT t1.person as adult, t2.person as child 
FROM adult t1
LEFT JOIN child t2
ON t1.rnk=t2.rnk


/* Query Result */

adult	child
A1	C1
A2	C2
A3	C3
A4	C4
A5	NULL
