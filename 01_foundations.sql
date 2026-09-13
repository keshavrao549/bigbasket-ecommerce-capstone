-- 01_foundations.sql
-- BigBasket Capstone - SQL Foundations


-- 1. WHERE
SELECT *
FROM `sturdy-carver-500004-q2.shop.orders`
WHERE status = 'Delivered';


-- 2. DISTINCT
SELECT DISTINCT category
FROM `sturdy-carver-500004-q2.shop.products`;


-- 3. ORDER BY + LIMIT
SELECT *
FROM `sturdy-carver-500004-q2.shop.products`
ORDER BY unit_price_inr DESC
LIMIT 5;


-- 4. Alias (AS)
SELECT
    status,
    COUNT(*) AS order_count
FROM `sturdy-carver-500004-q2.shop.orders`
GROUP BY status
ORDER BY status;


-- 5. IN
SELECT *
FROM `sturdy-carver-500004-q2.shop.products`
WHERE category IN ('Fruits', 'Vegetables', 'Dairy');


-- 6. BETWEEN
SELECT *
FROM `sturdy-carver-500004-q2.shop.products`
WHERE unit_price_inr BETWEEN 100 AND 500;


-- 7. NOT BETWEEN
SELECT *
FROM `sturdy-carver-500004-q2.shop.products`
WHERE unit_price_inr NOT BETWEEN 100 AND 500;


-- 8. IS NULL
SELECT *
FROM `sturdy-carver-500004-q2.shop.orders`
WHERE customer_id IS NULL;


-- 9. Revenue calculation
SELECT
    SUM(o.quantity * p.unit_price_inr) AS total_revenue
FROM `sturdy-carver-500004-q2.shop.orders` o
JOIN `sturdy-carver-500004-q2.shop.products` p
    ON o.product_id = p.product_id
WHERE o.status = 'Delivered';