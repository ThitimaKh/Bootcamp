-- How many pieces of food can be sold for each item?
SELECT 
	m.food_names menu,
  SUM(m.price) total,
  SUM(f.quantity) quantity
FROM menu m
JOIN food_order f ON m.menu_id = f.menu_id
GROUP BY m.food_names
ORDER BY SUM(f.quantity) DESC;

-- Who are the top spenders men and women?
SELECT * FROM
  (SELECT 
   	i.invoice_date,   
   	c.name,
    c.gender,
    c.age,
    i.invoice_id,
    i.total,
      rank() over(partition BY c.gender ORDER BY i.total DESC) rank
  FROM customers c
  JOIN invoice i ON c.customer_id = i.customer_id) 
WHERE rank < 2;
