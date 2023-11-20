select upper(full_nm) as full_name,
       min(dt)        as dt,
       high_price     as price
from (select full_nm, max(high_price) as high_price from public.coins group by full_nm) as tmp
         left join public.coins using (full_nm, high_price)
group by full_name, price
order by price desc, full_name;
