SELECT 'products' AS table_name, COUNT(*) AS row_count FROM `shop.products`
UNION ALL
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM `shop.customers`
UNION ALL
SELECT 'orders' AS table_name, COUNT(*) AS row_count FROM `shop.orders`
UNION ALL
SELECT 'category_targets' AS table_name, COUNT(*) AS row_count FROM `shop.category`;

-- Order Status Breakdown Verification
SELECT 
    status, 
    COUNT(*) AS order_count 
FROM `shop.orders` 
GROUP BY status 
ORDER BY order_count DESC;