--1.Young actors not coming from the USA
-- Identify actors who are not from the USA and actors who were born after 1990.

SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE nationality <> 'USA'
UNION 
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;

-- Select all actors who are not from the USA and who are also born after 1990.
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE nationality <> 'USA'
INTERSECT 
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;

select name, nationality, year_of_birth
from actors
where nationality <> 'USA' and year_of_birth > 1990;



--2.Dramas with high ratings
--The advertising team has a new focus. They want to draw the attention of the customers to dramas. 
--Make a list of all movies that are in the drama genre and have an average rating higher than 9.

select * 
from movies
where movie_id in 
			(
			SELECT movie_id
			FROM movies
			WHERE genre = 'Drama'
			intersect 
			SELECT movie_id
			FROM renting
			GROUP BY movie_id
			HAVING AVG(rating)>9);




