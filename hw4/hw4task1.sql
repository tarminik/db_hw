WITH RECURSIVE fibonacci_numbers(val1, val2, step) AS (VALUES (1::numeric, 1::numeric, 0)
                                                       UNION ALL
                                                       SELECT val2, val1 + val2, step + 1
                                                       FROM fibonacci_numbers
                                                       WHERE step < 99)
SELECT step as nth, val1 as value
FROM fibonacci_numbers;

