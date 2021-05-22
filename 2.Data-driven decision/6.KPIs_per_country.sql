-- KPIs per country
-- Your manager is interested in the total number of movie rentals, the average rating of all movies 
-- and the total revenue for each country since the beginning of 2019.

SELECT *
FROM renting r 
left JOIN customers c
on r.customer_id = c.customer_id
left JOIN movies m
on m.movie_id = r.movie_id
where date_renting between '2019-01-01' and '2019-12-31';


SELECT 
	c.country,
	count(*) as movie_rentals,
	avg(r.rating) as avg_rating,
	sum(m.renting_price) as revenue
FROM renting r 
left JOIN customers c
on r.customer_id = c.customer_id
left JOIN movies m
on m.movie_id = r.movie_id
where date_renting between '2019-01-01' and '2019-12-31'
group by 1;