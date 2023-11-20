select *
from public.coins
where symbol = 'BTC'
  and avg_price < 100;
