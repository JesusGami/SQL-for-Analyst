-- Report 4: Tallest athletes and % GDP by region

/*
Report Details:

Column 1 should be region found in the countries table.
Column 2 should be avg_tallest, which averages the tallest athlete from each country within the region.
Column 3 should be perc_world_gdp, which represents what % of the world's GDP is attributed to the region.
Only winter_games should be included (no summer events).
*/

SELECT
	-- Pull in region and calculate avg tallest height
    region,
    AVG(height) AS avg_tallest,
    -- Calculate region's percent of world gdp
    sum(sum(gdp)) over(partition by region) / sum(sum(gdp)) over() AS perc_world_gdp    
FROM countries AS c
JOIN
    (SELECT 
     	-- Pull in country_id and height
        country_id, 
        height, 
        -- Number the height of each country's athletes
        ROW_NUMBER() OVER (PARTITION BY country_id ORDER BY height DESC) AS row_num
    FROM winter_games AS w 
    JOIN athletes AS a ON w.athlete_id = a.id
    GROUP BY country_id, height
    -- Alias as subquery
    ORDER BY country_id, height DESC) AS subquery
ON c.id = subquery.country_id
-- Join to country_stats
JOIN country_stats AS cs
ON cs.country_id = c.id
-- Only include the tallest height for each country
WHERE row_num = 1
GROUP BY region;