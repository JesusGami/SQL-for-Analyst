--  1.When the first customer accounts were created for each country.
SELECT 
	country, 
	min(date_account_start) AS first_account
FROM customers
GROUP BY 1
ORDER BY 2;

-- 2. For each movie the average rating, the number of ratings and the number of views has to be reported. 
-- Generate a table with meaningful column names.
SELECT movie_id, 
       AVG(rating) AS avg_rating,
       COUNT(rating) AS number_ratings,
       COUNT(*) AS number_renting
FROM renting
GROUP BY movie_id
order by 2 desc;

-- 3. Per customer
SELECT customer_id, 
      avg(rating),  
      count(rating), 
	  count(movie_id)  
FROM renting
GROUP BY customer_id
having count(movie_id) > 7
ORDER BY 2;