2A1

SELECT product.id AS product_id, product.name AS product_name,COUNT(line_items.line_item_id) AS num_times_in_successful_orders
FROM alt_school.products
---- Performing join 
JOIN alt_school.orders ON alt_school.line_items.order_id = alt_school.orders.order_id
---fitering with where clause
where orders.status = 'checked_out' AND orders.checked_out_at IS NOT NULL
--- grouping the query
GROUP BY product.id, product.name
---- arranging 
ORDER BY num_times_in_successful_orders DESC
limit 1;



    2A2 
SELECT
    o.customer_id,
    c.location,
    SUM(o.total_amount) AS total_spend
FROM
    orders as o
JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY
    o.customer_id, c.location
ORDER BY
    total_spend DESC
LIMIT 5;
 
 
 
           2B1
    SELECT
    location,
    COUNT(*) AS checkout_count
FROM
    events
     ----  ->> operator was used becuase it is jsonb data type
WHERE
    event_data ->> 'checkout' 
GROUP BY
    location
ORDER BY
    checkout_count DESC
LIMIT 1;

        2B2
SELECT customer_id, COUNT(*) AS num_events
FROM events
 ----  ->> operator was used becuase it is jsonb data type
WHERE event_data ->> 'cartabandoned' AND event_data ->>'visit'
GROUP BY customer_id;

       
        2B3

    SELECT customer_id, COUNT(*) AS num_visits
  FROM events
   ----  ->> operator was used becuase it is jsonb data type
  WHERE event_data  ->> 'visit'
  AND customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE status = 'checked_out'
  )
  GROUP BY customer_id
) AS visit_counts;
