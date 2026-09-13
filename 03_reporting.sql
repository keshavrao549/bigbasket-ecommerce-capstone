-- 03_reporting.sql
-- BigBasket Reporting Queries


-- (a) Product Revenue Tiering
-- Tier every product by total Delivered revenue

SELECT
    p.product_name,
    SUM(o.amount_inr) AS total_revenue,
    CASE
        WHEN SUM(o.amount_inr) >= 3000 THEN 'High'
        WHEN SUM(o.amount_inr) >= 1000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_tier
FROM `sturdy-carver-500004-q2.shop.products` p
LEFT JOIN `sturdy-carver-500004-q2.shop.orders` o
    ON p.product_id = o.product_id
    AND o.status = 'Delivered'
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- (b) Monthly-by-Category Business Report
-- Delivered orders only

SELECT
    category,
    FORMAT_DATE('%Y-%m', order_date) AS month,
    COUNT(*) AS order_count,
    SUM(amount_inr) AS total_revenue,
    AVG(amount_inr) AS avg_revenue
FROM `sturdy-carver-500004-q2.shop.orders`
WHERE status = 'Delivered'
GROUP BY category, month
ORDER BY category, month;


-- (c) Category Revenue vs Target

SELECT
    o.category,
    SUM(o.amount_inr) AS total_revenue,
    t.target_revenue_inr,
    t.target_revenue_inr - SUM(o.amount_inr) AS variance,
    ((SUM(o.amount_inr) - t.target_revenue_inr) * 100.0)
        / t.target_revenue_inr AS percentage_variance,
    CASE
        WHEN SUM(o.amount_inr) >= t.target_revenue_inr
            THEN 'Above Target'
        WHEN (t.target_revenue_inr - SUM(o.amount_inr)) * 100.0
             / t.target_revenue_inr <= 15
            THEN 'Below Target - Watch'
        ELSE 'Below Target - Critical'
    END AS target_status
FROM `sturdy-carver-500004-q2.shop.orders` o
INNER JOIN `sturdy-carver-500004-q2.shop.category` t
    ON o.category = t.category
WHERE o.status = 'Delivered'
GROUP BY o.category, t.target_revenue_inr
ORDER BY o.category;