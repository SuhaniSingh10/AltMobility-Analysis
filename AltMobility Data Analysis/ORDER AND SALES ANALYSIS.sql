SELECT * FROM customer_orders;

SELECT ROUND(AVG(order_amount)) AS avg_order_value FROM customer_orders;

SELECT ROUND(SUM(order_amount)) AS total_revenue FROM customer_orders;

-- 1. Total Revenue by Order Status

SELECT order_status, COUNT(*) AS total_orders, ROUND(SUM(order_amount)) AS total_revenue
FROM customer_orders
GROUP BY order_status;


-- 2. Monthly Revenue Trend

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(order_amount) AS total_revenue
FROM customer_orders
GROUP BY month
ORDER BY month;


-- 3. Average Order Value Over Time

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, ROUND(AVG(order_amount)) AS avg_order_value
FROM customer_orders
GROUP BY month
ORDER BY month;


-- 4. Top 10 Highest Value Order

SELECT * FROM customer_orders
ORDER BY order_amount DESC
LIMIT 10;


-- 5. Orders by Day of Week

SELECT DAYNAME(order_date) AS day_of_week, COUNT(*) AS total_orders
FROM customer_orders
GROUP BY day_of_week;


-- 6. Revenue Contribution by Top 10% of Orders

WITH ranked_orders AS (
    SELECT order_amount,
           ROW_NUMBER() OVER (ORDER BY order_amount DESC) AS rn,
           COUNT(*) OVER () AS total_rows
    FROM customer_orders
)
SELECT 
    SUM(order_amount) AS top_10_percent_revenue
FROM ranked_orders
WHERE rn <= total_rows * 0.1;



-- 7. Average Time Between Orders (Order Frequency)

SELECT 
    AVG(datediff(next_order, order_date)) AS avg_days_between_orders
FROM (
    SELECT customer_id, order_date,
           LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_order
    FROM customer_orders
) AS intervals
WHERE next_order IS NOT NULL;


-- 8. Monthly Growth Rate in Revenue

SELECT 
    curr.month,
    curr.total_revenue,
    ROUND(((curr.total_revenue - prev.total_revenue) / prev.total_revenue) * 100, 2) AS growth_rate
FROM (
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(order_amount) AS total_revenue
    FROM customer_orders
    GROUP BY month
) AS curr
JOIN (
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(order_amount) AS total_revenue
    FROM customer_orders
    GROUP BY month
) AS prev ON curr.month = DATE_FORMAT(DATE_ADD(STR_TO_DATE(CONCAT(prev.month,'-01'), '%Y-%m-%d'), INTERVAL 1 MONTH), '%Y-%m');


-- 9. Order Value Distribution (Buckets)

SELECT 
    CASE 
        WHEN order_amount < 50 THEN '<50'
        WHEN order_amount BETWEEN 50 AND 200 THEN '50-200'
        WHEN order_amount BETWEEN 201 AND 500 THEN '201-500'
        ELSE '>500'
    END AS value_bucket,
    COUNT(*) AS order_count
FROM customer_orders
GROUP BY value_bucket;








