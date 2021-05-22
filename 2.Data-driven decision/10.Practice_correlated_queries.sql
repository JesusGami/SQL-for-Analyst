--1.Analyzing customer behavior
--A new advertising campaign is going to focus on customers who rented fewer than 5 movies. 
--Use a correlated query to extract all customer information for the customers of interest.

select name
from customers c
where (select count(*) from renting r where r.customer_id = c.customer_id) < 5;

--select count(*) from renting r where r.customer_id = 45;



--2.Customers who gave low ratings
--Identify customers who were not satisfied with movies they watched on MovieNow. 
--Report a list of customers with minimum rating smaller than 4.

--select min(rating) from renting where customer_id = 7;

select *
from customers c
where (select min(rating) from renting r where r.customer_id = c.customer_id) < 4;



--3.Movies and ratings with correlated queries
--Report a list of movies that received the most attention on the movie platform, 
--(i.e. report all movies with more than 5 ratings and all movies with an average rating higher than 8).

SELECT *
FROM movies m
WHERE 5  < -- Select all movies with more than 5 ratings
	(SELECT count(rating)
	FROM renting r
	WHERE r.movie_id = m.movie_id);
	
SELECT *
FROM movies AS m
WHERE 8 < -- Select all movies with an average rating higher than 8
	(SELECT avg(rating)
	FROM renting AS r
	WHERE r.movie_id = m.movie_id);
