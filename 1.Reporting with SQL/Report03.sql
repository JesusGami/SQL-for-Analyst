-- Report 3: Countries with high medal rates
/*
Details for report 3: medals vs population rate.

Column 1 should be country_code, which is an altered version of the country field.
Column 2 should be pop_in_millions, representing the population of the country (in millions).
Column 3 should be medals, representing the total number of medals.
Column 4 should be medals_per_million, which equals medals / pop_in_millions
*/

SELECT 
	-- Clean the country field to only show country_code
    left(upper(replace(trim(c.country),'.','')),3) as country_code,
    -- Pull in pop_in_millions and medals_per_million 
	cs.pop_in_millions,
    -- Add the three medal fields using one sum function
	SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) AS medals,
	SUM(COALESCE(bronze,0) + COALESCE(silver,0) + COALESCE(gold,0)) / CAST(cs.pop_in_millions AS float) AS medals_per_million
FROM summer_games AS s
JOIN countries AS c ON s.country_id = c.id
-- Update the newest join statement to remove duplication
JOIN country_stats AS cs ON s.country_id = cs.country_id AND s.year = CAST(cs.year AS date)
-- Filter out null populations
WHERE cs.pop_in_millions is not null
GROUP BY c.country, pop_in_millions
-- Keep only the top 25 medals_per_million rows
ORDER BY 4 desc
limit 25
