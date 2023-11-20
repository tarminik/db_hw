
SELECT facid, EXTRACT(MONTH FROM starttime) AS month, SUM(slots) AS slots
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
GROUP BY GROUPING SETS ((facid, EXTRACT(MONTH FROM starttime)), (facid), ())
ORDER BY COALESCE(facid, 9999), COALESCE(EXTRACT(MONTH FROM starttime), 13)

