SELECT facid, extract(month FROM starttime) AS month, sum(slots) AS total_slots
FROM cd.bookings
WHERE extract(year FROM starttime) = 2012
GROUP BY facid, month
ORDER BY facid, month;

