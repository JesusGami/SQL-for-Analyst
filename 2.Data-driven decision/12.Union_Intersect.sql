--UNION and INTERSECT

select 
	title,
	genre,
	renting_price
from movies
where renting_price > 2.8
UNION
select 
	title,
	genre,
	renting_price
from movies
where genre = 'Action & Adventure';

select 
	title,
	genre,
	renting_price
from movies
where renting_price > 2.8
intersect
select 
	title,
	genre,
	renting_price
from movies
where genre = 'Action & Adventure';


select title, genre, renting_price
from movies
where renting_price > 2.8 and genre = 'Action & Adventure'


