--1.Often rented movies
--Your manager wants you to make a list of movies excluding those which are hardly ever watched. 
--This list of movies will be used for advertising. List all movies with more than 5 views.

SELECT movie_id
FROM renting
GROUP BY movie_id
HAVING COUNT(*) > 5;


select *
FROM movies
where movie_id in (select movie_id
				   from renting
				   group by movie_id
				   having count(*) > 5);
				   
--2.Frequent customers
--Report a list of customers who frequently rent movies on MovieNow.

SELECT *
FROM customers
where customer_id in            -- Select all customers with more than 10 movie rentals
	(SELECT customer_id
	FROM renting
	GROUP BY customer_id
	having count(*) > 10);

--3.Movies with rating above average
--For the advertising campaign your manager also needs a list of popular movies with high ratings. 
--Report a list of movies with rating above average.

SELECT AVG(rating)
FROM renting;

SELECT movie_id
FROM renting
GROUP BY movie_id
HAVING AVG(rating) > (SELECT AVG(rating)
						   FROM renting);
						   
select title
from movies 
where movie_id in (
					SELECT movie_id
					FROM renting
					GROUP BY movie_id
					HAVING AVG(rating) > (SELECT AVG(rating)
										   FROM renting));

