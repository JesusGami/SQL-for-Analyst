-- Comparing groups

/*
The two types of metrics are volume metrics, which scales with size, and efficiency metrics,
which can compare across groups regardless of the size of each group.
*/




/*A percent of total calculation is a good way to compare volume metrics across groups. 
While simply showing the volume metric in a report provides some insights, adding a ratio allows us to easily 
compare values quickly.

To run a percent of total calculation, take the following steps:

1.Create a window function that outputs the total volume, partitioned by whatever is considered the total. 
If the entire table is considered the total, then no partition clause is needed.
2.Run a ratio that divides each row's volume metric by the total volume in the partition.*/

-- 1.Percent of gdp per country

-- Pull country_gdp by region and country
SELECT 
	region,
    country,
	SUM(gdp) AS country_gdp,
    -- Calculate the global gdp
    SUM(SUM(gdp)) OVER () AS global_gdp,
    -- Calculate percent of global gdp
    SUM(gdp) / SUM(SUM(gdp)) OVER () AS perc_global_gdp,
	-- Calculate the region gdp
	sum(sum(gdp)) over(partition by region) as region_gdp,
    -- Calculate percent of gdp relative to its region
    sum(gdp)/sum(sum(gdp)) over(partition by region) AS perc_region_gdp
FROM country_stats AS cs
JOIN countries AS c
ON cs.country_id = c.id
-- Filter out null gdp values
WHERE gdp IS NOT NULL
GROUP BY region, country
-- Show the highest country_gdp at the top
ORDER BY country_gdp DESC;



/*
A performance index calculation is a good way to compare efficiency metrics across groups. 
A performance index compares each row to a benchmark.

To run a performance index calculation, take the following steps:

1. Create a window function that outputs the performance for the entire partition.
2. Run a ratio that divides each row's performance to the performance of the entire partition.
*/

-- 2. GDP per capita performance index

-- Bring in region, country, and gdp_per_million
SELECT 
    region,
    country,
    SUM(gdp) / SUM(cast(pop_in_millions as float)) AS gdp_per_million,
    -- Output the worlds gdp_per_million
    SUM(SUM(gdp)) OVER () / SUM(SUM(cast(pop_in_millions as float))) OVER () AS gdp_per_million_total,
    -- Build the performance_index in the 3 lines below
    (SUM(gdp) / SUM(cast(pop_in_millions as float)))/(SUM(SUM(gdp)) OVER () / SUM(SUM(cast(pop_in_millions as float))) OVER ()) AS performance_index
-- Pull from country_stats_clean
FROM country_stats AS cs
JOIN countries AS c 
ON cs.country_id = c.id
-- Filter for 2016 and remove null gdp values
WHERE year = '2016-01-01' AND gdp IS NOT NULL
GROUP BY region, country
-- Show highest gdp_per_million at the top
ORDER BY gdp_per_million DESC;



