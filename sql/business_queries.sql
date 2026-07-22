-- ===========================================================
-- AWS ETL Data Pipeline
-- Business Analytics Queries (Amazon Athena)
-- ===========================================================

--------------------------------------------------------------
-- 1. Total Revenue Generated
--------------------------------------------------------------

SELECT
    ROUND(SUM(quantity * unit_price),2) AS total_revenue
FROM orders;

--------------------------------------------------------------
-- 2. Top 5 Revenue Generating Cities
--------------------------------------------------------------

SELECT
    city,
    ROUND(SUM(quantity * unit_price),2) AS revenue
FROM orders
GROUP BY city
ORDER BY revenue DESC
LIMIT 5;

--------------------------------------------------------------
-- 3. Top Selling Products
--------------------------------------------------------------

SELECT
    product_name,
    SUM(quantity) AS units_sold
FROM orders
GROUP BY product_name
ORDER BY units_sold DESC;

--------------------------------------------------------------
-- 4. Revenue by Product Category
--------------------------------------------------------------

SELECT
    category,
    ROUND(SUM(quantity * unit_price),2) AS revenue
FROM orders
GROUP BY category
ORDER BY revenue DESC;

--------------------------------------------------------------
-- 5. Order Status Distribution
--------------------------------------------------------------

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

--------------------------------------------------------------
-- 6. Preferred Payment Methods
--------------------------------------------------------------

SELECT
    payment_method,
    COUNT(*) AS total_transactions
FROM orders
GROUP BY payment_method
ORDER BY total_transactions DESC;

--------------------------------------------------------------
-- 7. Average Order Value
--------------------------------------------------------------

SELECT
    ROUND(AVG(quantity * unit_price),2) AS average_order_value
FROM orders;

--------------------------------------------------------------
-- 8. Highest Spending Customers
--------------------------------------------------------------

SELECT
    customer_id,
    ROUND(SUM(quantity * unit_price),2) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;

--------------------------------------------------------------
-- 9. Daily Sales Trend
--------------------------------------------------------------

SELECT
    order_date,
    ROUND(SUM(quantity * unit_price),2) AS daily_revenue
FROM orders
GROUP BY order_date
ORDER BY order_date;

--------------------------------------------------------------
-- 10. Products Generating Highest Revenue
--------------------------------------------------------------

SELECT
    product_name,
    ROUND(SUM(quantity * unit_price),2) AS revenue
FROM orders
GROUP BY product_name
ORDER BY revenue DESC;

--------------------------------------------------------------
-- 11. Shop Distribution by Region
--------------------------------------------------------------

SELECT
    region,
    COUNT(*) AS total_shops
FROM shop
GROUP BY region
ORDER BY total_shops DESC;

--------------------------------------------------------------
-- 12. Shop Distribution by State
--------------------------------------------------------------

SELECT
    state,
    COUNT(*) AS total_shops
FROM shop
GROUP BY state
ORDER BY total_shops DESC;

--------------------------------------------------------------
-- 13. Oldest Shops
--------------------------------------------------------------

SELECT
    shop_name,
    city,
    opened_date
FROM shop
ORDER BY opened_date ASC;

--------------------------------------------------------------
-- 14. Orders Served by Each City
--------------------------------------------------------------

SELECT
    city,
    COUNT(*) AS total_orders
FROM orders
GROUP BY city
ORDER BY total_orders DESC;

--------------------------------------------------------------
-- 15. Revenue by Region (Business JOIN)
--------------------------------------------------------------

SELECT
    s.region,
    ROUND(SUM(o.quantity * o.unit_price),2) AS revenue
FROM orders o
JOIN shop s
ON o.city = s.city
GROUP BY s.region
ORDER BY revenue DESC;

--------------------------------------------------------------
-- 16. Orders Managed by Each Shop
--------------------------------------------------------------

SELECT
    s.shop_name,
    COUNT(o.order_id) AS total_orders
FROM shop s
LEFT JOIN orders o
ON s.city = o.city
GROUP BY s.shop_name
ORDER BY total_orders DESC;

--------------------------------------------------------------
-- 17. Executive Dashboard Metrics
--------------------------------------------------------------

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(quantity * unit_price),2) AS total_revenue,
    ROUND(AVG(quantity * unit_price),2) AS average_order_value
FROM orders;

--------------------------------------------------------------
-- 18. Customers Purchasing Multiple Products
--------------------------------------------------------------

SELECT
    customer_id,
    COUNT(DISTINCT product_name) AS products_purchased
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT product_name) > 1
ORDER BY products_purchased DESC;

--------------------------------------------------------------
-- 19. Most Popular Product Categories by Orders
--------------------------------------------------------------

SELECT
    category,
    COUNT(*) AS total_orders
FROM orders
GROUP BY category
ORDER BY total_orders DESC;

--------------------------------------------------------------
-- 20. Shop Coverage by City
--------------------------------------------------------------

SELECT
    city,
    COUNT(shop_id) AS total_shops
FROM shop
GROUP BY city
ORDER BY total_shops DESC;