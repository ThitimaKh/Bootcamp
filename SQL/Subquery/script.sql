-- SUBQUERY 
-- Top 3 Canadian Customers with the highest spending in 2010
WITH canada_cus AS (
	SELECT * FROM customers
  	WHERE country = 'Canada'
), invoice_2010 AS (
	SELECT * FROM invoices
  	WHERE STRFTIME('%Y', invoicedate) = '2010'
)
SELECT
    c.firstname || ' ' || c.lastname Name,
    c.country Country,
    STRFTIME('%Y', i.invoicedate) Year,
    --COUNT(i.total) n_count,
    ROUND(SUM(i.total), 2) Total_invoice
FROM canada_cus c 
JOIN invoice_2010 i 
ON c.customerid = i.customerid
GROUP BY 1
ORDER BY 4 DESC
LIMIT 5;

-- SUBQUERY + WINDOW FUNCTION
-- Fetch the top 3 tracks in each genre has the max minute.
SELECT * FROM
  (SELECT 
      rank() over(partition BY g.name ORDER BY t.milliseconds DESC) rank,
      g.name genre,
      t.name track_name,
      ROUND((t.milliseconds/ 60000.0), 2) AS minute,
      ROUND((t.bytes/ (1024*1024.0)), 2) AS mb
  FROM genres g
  JOIN tracks t ON g.genreid = t.genreid) s
WHERE s.rank < 4
  AND (s.genre IN ('Alternative', 'Easy Listening', 'Hip Hop/Rap', 'Jazz', 'Latin', 'Metal', 'Pop', 'R&B/Soul'));
