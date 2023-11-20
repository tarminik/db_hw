select row_number() over (order by vol desc) as rank, dt, vol
from (select dt, sum(vol) as vol
      from public.coins
      group by dt) a
order by vol desc
limit 10;
