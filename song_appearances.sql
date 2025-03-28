/* Assume there are three Spotify tables: artists, songs, and global_song_rank, which contain information about the artists, songs, and music charts, respectively.

Write a query to find the top 5 artists whose songs appear most frequently in the Top 10 of the global_song_rank table. Display the top 5 artist names in ascending order, along with their song appearance ranking.

If two or more artists have the same number of song appearances, they should be assigned the same ranking, and the rank numbers should be continuous (i.e. 1, 2, 2, 3, 4, 5). If you've never seen a rank order like this before, do the rank window function tutorial.*/


/* Given Tables */

create table artists
(
artist_id integer,
artist_name varchar(50),
label_owner varchar(50)
)


create table songs
(
song_id integer,
artist_id integer,
name varchar(50)
)

create table global_song_rank
(
day integer,
song_id	 integer,
rank integer
)

/* Insert Data into Team Table */
insert into songs values(55511,101,'Perfect');
insert into songs values(45202,101,'Shape of You');
insert into songs values(22222,120,'One Dance');
insert into songs values(19960,120,'Hotline Bling');

insert into global_song_rank values(1,45202,5);
insert into global_song_rank values(3,45202,2);
insert into global_song_rank values(1,19960,3);
insert into global_song_rank values(9,19960,15);

/* SQL Query Output */
WITH CTE AS(SELECT a.artist_name,
DENSE_RANK()OVER(ORDER BY COUNT(s.song_id) DESC) AS song_appearance_rank
FROM songs s
INNER JOIN global_song_rank gs ON s.song_id = gs.song_id
INNER JOIN artists a ON s.artist_id = a.artist_id
WHERE rank <=10
GROUP BY artist_name)

SELECT * FROM CTE
WHERE song_appearance_rank <=5
ORDER BY song_appearance_rank,artist_name



/* Query Result */

artist_name	song_appearance_rank
Taylor Swift	1
Bad Bunny	2
Drake	2
Adele	3
Ed Sheeran	3
Lady Gaga	4
Katy Perry	5
