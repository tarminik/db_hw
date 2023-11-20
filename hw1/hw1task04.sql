SELECT id,
       weight / height ^ 2 * 1 / (2.2046 * 0.0254 ^ 2) as bmi,
       case
           when weight / height ^ 2 * 1 / (2.2046 * 0.0254 ^ 2) < 18.5 then 'underweight'
           when weight / height ^ 2 * 1 / (2.2046 * 0.0254 ^ 2) < 25 then 'normal'
           when weight / height ^ 2 * 1 / (2.2046 * 0.0254 ^ 2) < 30 then 'overweight'
           when weight / height ^ 2 * 1 / (2.2046 * 0.0254 ^ 2) < 35 then 'obese'
           else 'extremely obese'
           end                                         as type
FROM public.hw
ORDER BY bmi DESC, id DESC;
