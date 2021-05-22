--OLAP: CUBE

--1. Create a table with the total number of male and female customers from each country.
-- Create a table with the total number of customers, of all female and male customers, 
--of the number of customers for each country and the number of men and women from each country.

SELECT gender, 
	   country,
	   count(*)
FROM customers
GROUP BY CUBE (gender, country)
ORDER BY country;

SELECT gender, 
	   country,
	   count(*)
FROM customers
GROUP BY gender, country
ORDER BY country;

--2.List the number of movies for different genres and release years.
SELECT genre,
       year_of_release,
       count(*)
FROM movies
group by cube(genre, year_of_release)
ORDER BY year_of_release;


--3.Prepare a table for a report about the national preferences of the customers from MovieNow comparing 
--the average rating of movies across countries and genres.

SELECT 
	c.country, 
	m.genre, 
	AVG(r.rating) AS avg_rating  
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
group by cube(1,2);


-- OLAP: ROLLUP

--1.Number of customers: You have to give an overview of the number of customers for a presentation.
--Generate a table with the total number of customers, the number of customers for each country, 
--and the number of female and male customers for each country.

SELECT country,
       gender,
	   COUNT(*)
FROM customers
group  by rollup (country, gender)
order by 1, 2;

--2.Analyzing preferences of genres across countries
--You are asked to study the preferences of genres across countries. 
--Are there particular genres which are more popular in specific countries? 
--Evaluate the preferences of customers by averaging their ratings and counting the number of movies rented 
--from each genre.

SELECT 
	c.country, 
	m.genre, 
	avg(r.rating), 
	count(*) 
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY 1,2
ORDER BY c.country, m.genre;

--calculate the average ratings and the number of ratings for each country and genre, 
--as well as an aggregation over all genres for each country and the overall average and total number.
SELECT 
	c.country, 
	m.genre, 
	AVG(r.rating) AS avg_rating, 
	COUNT(*) AS num_rating
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY rollup(1,2)
ORDER BY c.country, m.genre;
--difference
SELECT 
	c.country, 
	m.genre, 
	AVG(r.rating) AS avg_rating, 
	COUNT(*) AS num_rating
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY cube(1,2)
ORDER BY c.country, m.genre;



--OLAP: GROUPING SETS

--1.Count the number of actors in the table actors from each country, the number of male and female actors 
--and the total number of actors.
SELECT 
	nationality, 
    gender, 
    count(*) 
FROM actors
GROUP BY GROUPING SETS ((nationality), (gender), ())
order by 1,2;

--2.Now you will investigate the average rating of customers aggregated by country and gender.
SELECT 
	c.country, 
    c.gender,
	avg(r.rating) 
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
group by country, gender
ORDER BY 3;

SELECT 
	c.country, 
    c.gender,
	AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
group by grouping sets ((country, gender));

SELECT 
	c.country, 
    c.gender,
	AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY GROUPING SETS ((country, gender), (country), (gender), ());

