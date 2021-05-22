-- Identify favorite actors for Spain

SELECT *
FROM renting as r 
LEFT JOIN customers c  -- Augment table renting with information about customers 
on r.customer_id = c.customer_id
LEFT JOIN actsin ai  -- Augment the table renting with the table actsin
on ai.movie_id = r.movie_id
LEFT JOIN actors a  -- Augment table renting with information about actors
on a.actor_id = ai.actor_id;


SELECT
	a.name,  
	c.gender,
    COUNT(*) AS number_views, 
    AVG(r.rating) AS avg_rating
FROM renting as r
LEFT JOIN customers AS c ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai ON r.movie_id = ai.movie_id
LEFT JOIN actors as a ON ai.actor_id = a.actor_id
where c.country = 'Spain'
GROUP BY a.name, c.gender
HAVING AVG(r.rating) IS NOT NULL 
  		AND COUNT(*) > 5 
ORDER BY avg_rating DESC, number_views DESC;