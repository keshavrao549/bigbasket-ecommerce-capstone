-- 02_aggregation_joins.sql

-- (a) INNER JOIN + GROUP BY + HAVING
-- Delivered orders only, grouped by category
SELECT
    p.category,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS average_order_value
FROM `sturdy-carver-500004-q2.shop.orders` o
INNER JOIN `sturdy-carver-500004-q2.shop.products` p
    ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
HAVING total_revenue > 10000
ORDER BY total_revenue DESC;


-- (b) LEFT JOIN + COUNT
-- Total orders per product, including products with zero orders
SELECT
    p.product_name,
    COUNT(o.order_id) AS total_orders
FROM `sturdy-carver-500004-q2.shop.products` p
LEFT JOIN `sturdy-carver-500004-q2.shop.orders` o
    ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY total_orders ASC;