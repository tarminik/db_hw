WITH RECURSIVE recommended_members AS (SELECT memid, firstname, surname
                                       FROM cd.members
                                       WHERE memid = 1
                                       UNION
                                       SELECT m.memid, m.firstname, m.surname
                                       FROM cd.members m
                                                JOIN recommended_members rm ON m.recommendedby = rm.memid)
SELECT memid, firstname, surname
FROM recommended_members
ORDER BY memid ASC
offset 1;

