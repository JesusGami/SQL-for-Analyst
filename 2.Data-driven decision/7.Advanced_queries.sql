-- Nested 1
select distinct customer_id
from renting
where rating <= 3
order by 1;

--select * from renting order by 2; 

select 
	name
from customers
where customer_id in (select distinct customer_id
						from renting
						where rating <= 3
						order by 1);

-- Nested 2
select min(date_account_start)
from customers
where country = 'Austria';

select 
	country,
	min(date_account_start)
from customers
group by 1
having min(date_account_start) < (
			select min(date_account_start)
			from customers
			where country = 'Austria'
			);
			
-- Nested 3: who are the actors in the movie Ray?

select name
from actors
where actor_id in (
					select actor_id
					from actsin
					where movie_id = (select movie_id from movies where title = 'Ray'));