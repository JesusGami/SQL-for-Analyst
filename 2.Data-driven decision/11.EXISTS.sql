-- 1. Movies with at leat one rating

select *
from movies m
where exists (select * from renting r where rating is not null and r.movie_id = m.movie_id);

select *
from movies m
where not exists (select * from renting r where rating is not null and r.movie_id = m.movie_id);



-- 2. Customers with at least one rating
-- Having active customers is a key performance indicator for MovieNow. 
--Make a list of customers who gave at least one rating.

select *
from renting
where customer_id = 115;

select *
from renting
where rating is not null
and customer_id = 115;

SELECT *
FROM renting
WHERE rating is not null 
and customer_id = 1;

SELECT *
FROM customers c 
WHERE exists
	(SELECT *
	FROM renting AS r
	WHERE rating IS NOT NULL 
	AND r.customer_id = c.customer_id);



--3.Actors in comedies
--In order to analyze the diversity of actors in comedies, first, report a list of actors who play in comedies
--and then, the number of actors for each nationality playing in comedies.

SELECT *  
FROM actsin AS ai
LEFT JOIN movies AS m
ON ai.movie_id = m.movie_id
WHERE m.genre = 'Comedy';

SELECT *
FROM actsin AS ai
LEFT JOIN movies AS m
ON m.movie_id = ai.movie_id
WHERE m.genre = 'Comedy'
and ai.actor_id = 1;

SELECT *
FROM actors AS a
WHERE EXISTS
	(SELECT *
	 FROM actsin AS ai
	 LEFT JOIN movies AS m
	 ON m.movie_id = ai.movie_id
	 WHERE m.genre = 'Comedy'
	 AND ai.actor_id = a.actor_id);
	 
SELECT a.nationality,
	   count(*) 
FROM actors AS a
WHERE EXISTS
	(SELECT ai.actor_id
	 FROM actsin AS ai
	 LEFT JOIN movies AS m
	 ON m.movie_id = ai.movie_id
	 WHERE m.genre = 'Comedy'
	 AND ai.actor_id = a.actor_id)
group by a.nationality;