-- 1. Repeat vs One-Time Customers

SELECT
    SUM(order_count = 1) AS one_time_customers,
    SUM(order_count > 1) AS repeat_customers
FROM (
    SELECT customer_id, COUNT(*) AS order_count
    FROM customer_orders
    GROUP BY customer_id
) AS summary;


-- 2. Monthly Unique Customers

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, COUNT(DISTINCT customer_id) AS unique_customers
FROM customer_orders
GROUP BY month
ORDER BY month;


-- 3.  Customer Lifetime Value (Top 10)

SELECT customer_id, COUNT(*) AS total_orders, SUM(order_amount) AS total_spent
FROM customer_orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;


-- 4. First and Last Order Date per Customer

SELECT customer_id, MIN(order_date) AS first_order, MAX(order_date) AS last_order
FROM customer_orders
GROUP BY customer_id;

-- 5. Customers with No Orders in Last 90 Days

SELECT customer_id
FROM customer_orders
GROUP BY customer_id
HAVING MAX(order_date) < CURDATE() - INTERVAL 90 DAY;


-- 6. Customer Retention Cohorts (Monthly First Order)

SELECT 
    DATE_FORMAT(first_order, '%Y-%m') AS cohort_month,
    COUNT(customer_id) AS customers
FROM (
    SELECT customer_id, MIN(order_date) AS first_order
    FROM customer_orders
    GROUP BY customer_id
) AS cohorts
GROUP BY cohort_month
ORDER BY cohort_month;


-- 7. Average Order Value by Customer Segment

SELECT 
    CASE 
        WHEN total_spent < 100 THEN 'Low'
        WHEN total_spent BETWEEN 100 AND 500 THEN 'Medium'
        ELSE 'High'
    END AS segment,
    AVG(avg_order_value) AS avg_order_value
FROM (
    SELECT customer_id, SUM(order_amount) AS total_spent, AVG(order_amount) AS avg_order_value
    FROM customer_orders
    GROUP BY customer_id
) AS segment_data
GROUP BY segment;


-- 8. Most Loyal Customers (Frequent Orderers)

SELECT customer_id, COUNT(*) AS orders_count
FROM customer_orders
GROUP BY customer_id
ORDER BY orders_count DESC
LIMIT 10;


-- 9. Customer Churn Indicator (No Orders in Last 6 Months)

SELECT customer_id
FROM customer_orders
GROUP BY customer_id
HAVING MAX(order_date) < CURDATE() - INTERVAL 6 MONTH;


-- 10. Monthly Active vs Inactive Customers

 SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT customer_id) AS active_customers,
    (SELECT COUNT(DISTINCT customer_id) FROM customer_orders) - COUNT(DISTINCT customer_id) AS inactive_customers
FROM customer_orders
GROUP BY month;









