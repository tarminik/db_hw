SELECT dt, high_price, vol
from public.coins
where dt like '2018-%'
  and symbol = 'DOGE'
  and avg_price > 0.001;
