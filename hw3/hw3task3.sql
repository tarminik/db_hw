SELECT CASE WHEN m.memid = 0 THEN 'GUEST' ELSE m.firstname END   AS firstname,
       CASE WHEN m.memid = 0 THEN 'GUEST' ELSE m.surname END     AS surname,
       ROUND(SUM(b.slots / 2.0), -1)                             AS hours,
       RANK() OVER (ORDER BY ROUND(SUM(b.slots / 2.0), -1) DESC) AS rank
FROM cd.bookings AS b
         INNER JOIN cd.facilities AS f ON b.facid = f.facid
         INNER JOIN cd.members AS m ON b.memid = m.memid
GROUP BY m.memid
ORDER BY rank,
         surname,
         firstname;

