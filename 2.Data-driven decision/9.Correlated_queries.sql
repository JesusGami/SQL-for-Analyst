-- Correlated nested queries

-- 1.Number of movie rentals more than 5

--Subquery:

select count(distinct t.movie_id)
from (select 
	r.movie_id,
	count(*) 
from renting r
left join movies m
on r.movie_id = m.movie_id
group by 1
having count(*) > 5) t;

-- Correlated subquery

select * 
from movies m
where 5 < (select count(*) from renting r where r.movie_id = m.movie_id);

--evaluation
--select count(*) from renting r where r.movie_id = 1;
