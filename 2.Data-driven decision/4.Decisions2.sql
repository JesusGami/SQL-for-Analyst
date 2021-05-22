-- Which is the favorite movie on MovieNow? Answer this question for a specific group of customers: 
-- for all customers born in the 70s.

SELECT *
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
where c.date_of_birth between '1970-01-01' and '1979-12-31';


SELECT m.title, 
	count(*),
	avg(r.rating) 
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
group by 1;

SELECT m.title, 
	COUNT(*),
	AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c ON c.customer_id = r.customer_id
LEFT JOIN movies AS m ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title
having count(*) > 1 -- Remove movies with only one rental
order by 3 desc nulls last, 2 desc;