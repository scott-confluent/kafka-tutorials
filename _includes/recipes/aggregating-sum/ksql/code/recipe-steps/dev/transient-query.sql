SELECT TITLE, 
       SUM(TICKET_TOTAL_VALUE) AS TOTAL_VALUE
FROM   MOVIE_TICKET_SALES
GROUP BY TITLE
LIMIT 3;