--MovieNow considers to invest money in new movies
-- It is more expensive for MovieNow to make movies available which were recently produced than older ones.

-- Do customers give better ratings to movies which were recently produced than to older ones?
-- Is there a difference between countries?

select 
	c.country,
	m.year_of_release,
	count(*) n_rentals,
	count(distinct r.movie_id) n_movies,
	avg(r.rating)
from renting r
left join customers c on r.customer_id = c.customer_id
left join movies m on m.movie_id = r.movie_id
where r.movie_id in (select movie_id 
					 from renting 
					 --where r.date_renting >= '2018-04-01'
					 group by movie_id 
					 having count(rating) >= 4
					)
		and r.date_renting >= '2018-04-01'
group by rollup (2,1)
order by 1,2;


--1.Customer preference for genres
-- You just saw that customers have no clear preference for more recent movies over older ones. 
--Now the management considers investing money in movies of the best rated genres.

SELECT genre,
	   AVG(rating) AS avg_rating,
	   COUNT(rating) AS n_rating,
       COUNT(*) AS n_rentals,     
	   COUNT(DISTINCT m.movie_id) AS n_movies 
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE r.movie_id IN ( 
					SELECT movie_id
					FROM renting
					GROUP BY movie_id
					HAVING COUNT(rating) >= 3 )
				AND r.date_renting >= '2018-01-01'
GROUP BY genre
order by 2 desc;

--2.Customer preference for actors
SELECT a.nationality,
       a.gender,
	   AVG(r.rating) AS avg_rating,
	   COUNT(r.rating) AS n_rating,
	   COUNT(*) AS n_rentals,
	   COUNT(DISTINCT a.actor_id) AS n_actors
FROM renting AS r
LEFT JOIN actsin AS ai
ON ai.movie_id = r.movie_id
LEFT JOIN actors AS a
ON ai.actor_id = a.actor_id
WHERE r.movie_id IN ( 
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >= 4)
AND r.date_renting >= '2018-04-01'
GROUP BY cube(1,2);


	
