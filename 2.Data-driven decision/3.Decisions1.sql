
-- Aggregating revenue, rentals and active customers
SELECT 
	SUM(m.renting_price), 
	COUNT(*), 
	COUNT(DISTINCT r.customer_id)
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id
WHERE date_renting between '2018-01-01' and '2018-12-31' ;

-- You are asked to give an overview of which actors play in which movie.
SELECT a.name, 
		m.title
FROM actsin ai
LEFT JOIN movies AS m
ON m.movie_id = ai.movie_id
LEFT JOIN actors AS a
ON a.actor_id = ai.actor_id;

-- How much income did each movie generate? 

-- A.
SELECT rm.title, -- Report the income from movie rentals for each movie 
       sum(rm.renting_price) AS income_movie
FROM
       (SELECT m.title,  
               m.renting_price
       FROM renting AS r
       LEFT JOIN movies AS m
       ON r.movie_id=m.movie_id) AS rm
group by 1
ORDER BY 2 desc;

-- B.
select m.title,
		sum(m.renting_price)
from movies m
join renting r on m.movie_id = r.movie_id
group by 1
order by 2 desc;


--  Report the date of birth of the oldest and youngest US actor and actress.
SELECT 
	gender, 
	min(year_of_birth), 
    max(year_of_birth) 
FROM actors
where nationality = 'USA'
GROUP BY 1;