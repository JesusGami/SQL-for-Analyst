
-- STRING FUNCTIONS:
/*
The LOWER(fieldName) function changes the case of all characters in fieldName to lower case.
The INITCAP(fieldName) function changes the case of all characters in fieldName to proper case.
The LEFT(fieldName,N) function returns the left N characters of the string fieldName.
The SUBSTRING(fieldName from S for N) returns N characters starting from position S of the string fieldName. 
Note that both from S and for N are optional.

REPLACE(fieldName, 'searchFor', 'replaceWith')
*/

-- Convert country to lower case
SELECT 
	country, 
    lower(country) AS country_altered
FROM countries
GROUP BY country;

-- Convert country to proper case
SELECT 
	country, 
    initcap(country) AS country_altered
FROM countries
GROUP BY country;

-- Output the left 3 characters of country
SELECT 
	country, 
    left(country,3) AS country_altered
FROM countries
GROUP BY country;

-- Output all characters starting with position 7
SELECT 
	country, 
    substring(country from 7) AS country_altered
FROM countries
GROUP BY country;

--Replace
SELECT 
	region, 
    -- Replace all '&' characters with the string 'and'
    replace(region, '&', 'and') AS character_swap,
    -- Remove all periods
    replace(region, '.', '') AS character_remove
FROM countries
WHERE region = 'LATIN AMER. & CARIB    '
GROUP BY 1;

--Using both
SELECT 
	region, 
    -- Replace all '&' characters with the string 'and'
    REPLACE(region,'&','and') AS character_swap,
    -- Remove all periods
    REPLACE(region,'.','') AS character_remove,
    -- Combine the functions to run both changes at once
    replace(replace(region, '&', 'and'),'.','') AS character_swap_and_remove
FROM countries
WHERE region = 'LATIN AMER. & CARIB    '
GROUP BY region;
