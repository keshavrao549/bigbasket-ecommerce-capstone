--02_aggregation.sql
-- BigBasket Capstone - Foundational Queries


-- 1. SELECT / WHERE
-- Orders in a specific city
SELECT *
FROM `sturdy-carver-500004-q2.shop.orders`
WHERE city = 'Delhi';


-- 2. DISTINCT
-- List every distinct category
SELECT DISTINCT category
FROM `sturdy-carver-500004-q2.shop.products`;


-- 3. ORDER BY + LIMIT
-- 5 highest-value orders
SELECT *
FROM `sturdy-carver-500004-q2.shop.orders`
ORDER BY amount_inr DESC
LIMIT 5;


-- 4. Alias (AS)
-- Count orders by status
SELECT
    status,
    COUNT(*) AS total_orders
FROM `sturdy-carver-500004-q2.shop.orders`
GROUP BY status
ORDER BY status;


-- 5. IN
-- Orders paid using either of two payment modes
SELECT *
FROM `sturdy-carver-500004-q2.shop.orders`
WHERE payment_mode IN ('UPI', 'Credit Card');


-- 6. BETWEEN
-- Orders with amount between 500 and 2000 INR
SELECT *
FROM `sturdy-carver-500004-q2.shop.orders`
WHERE amount_inr BETWEEN 500 AND 2000;


-- 7. NOT BETWEEN
-- Orders outside the 500 to 2000 INR range
SELECT *
FROM `sturdy-carver-500004-q2.shop.orders`
WHERE amount_inr NOT BETWEEN 500 AND 2000;


-- 8. IS NULL
-- Orders with no rating recorded
SELECT *
FROM `sturdy-carver-500004-q2.shop.orders`
WHERE rating IS NULL;