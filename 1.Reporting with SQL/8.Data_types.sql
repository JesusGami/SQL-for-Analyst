
-- Identify data types
SELECT 
	column_name,
    data_type
FROM information_schema.columns
-- Filter for the table 'country_stats'
WHERE table_name = 'country_stats';

-- Error messages

--select avg(pop_in_millions) as avg_pop
--from country_stats;

-- Dealing with error messages
select avg(cast(pop_in_millions as float)) as avg_pop
from country_stats;

--DATE_TRUNC('month', date) truncates each date to the first day of the month.
--DATE_PART('year', date) outputs the year, as an integer, of each date value.

SELECT 
	year,
    -- Pull decade, decade_truncate, and the world's gdp
    DATE_PART('decade', cast(year as date)) AS decade,
    DATE_TRUNC('decade', cast(year as date)) AS decade_truncated,
    sum(gdp) AS world_gdp
FROM country_stats
-- Group and order by year in descending order
GROUP BY year
ORDER BY 1 desc;
