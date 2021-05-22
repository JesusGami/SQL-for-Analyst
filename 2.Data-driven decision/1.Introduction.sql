-- Customer information

SELECT count(customer_id) -- Count the total number of customers
FROM customers
WHERE date_of_birth between '1980-01-01' and '1989-12-31'; -- Select customers born between 1980-01-01 and 1989-12-31

SELECT count(customer_id)   -- Count the total number of customers
FROM customers
where country = 'Germany'; -- Select all customers from Germany

-- Count the number of countries where MovieNow has customers.

SELECT count(distinct country)   -- Count the number of countries
FROM customers;


-- Movie information
SELECT min(rating) min_rating, -- Calculate the minimum rating and use alias min_rating
	   max(rating) max_rating, -- Calculate the maximum rating and use alias max_rating
	   avg(rating) avg_rating, -- Calculate the average rating and use alias avg_rating
	   count(rating) number_ratings -- Count the number of ratings and use alias number_ratings
FROM renting
where movie_id = 25; 


-- Your manager is interested in the total number of movie rentals, the total number of ratings and 
--the average rating of all movies since the beginning of 2019.

SELECT 
	COUNT(*) AS number_renting,
	AVG(rating) AS average_rating, 
    count(rating) AS number_ratings 
FROM renting
WHERE date_renting >= '2019-01-01';