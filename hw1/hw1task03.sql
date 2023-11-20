select count(id) as underweight_count
from public.hw
where weight / height ^ 2 * 1 / (2.2046 * 0.0254 ^ 2) < 18.5;
