-- Window functions

SELECT 
	country_id,
    year,
    gdp,
    -- Show the average gdp across all years per country
	avg(gdp) over(partition by country_id) AS country_avg_gdp
FROM country_stats;

SELECT 
	country_id,
    year,
    gdp,
    -- Show total gdp per country and alias accordingly
	sum(gdp) OVER (PARTITION BY country_id) AS country_sum_gdp
FROM country_stats;

SELECT 
	country_id,
    year,
    gdp,
    -- Show max gdp per country and alias accordingly
	max(gdp) OVER (PARTITION BY country_id) AS country_max_gdp
FROM country_stats;

SELECT 
	country_id,
    year,
    gdp,
    -- Show max gdp for the table and alias accordingly
	MAX(gdp) OVER () AS global_max_gdp
FROM country_stats;