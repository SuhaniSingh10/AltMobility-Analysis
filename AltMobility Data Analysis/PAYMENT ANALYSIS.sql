-- 1. Payment Summary by Status

SELECT payment_status, COUNT(*) AS transaction_count, 
ROUND(SUM(payment_amount)) AS total_paid
FROM payments
GROUP BY payment_status;


-- 2.  Payment Success Rate

SELECT 
  ROUND(SUM(payment_status = 'completed') * 100.0 / COUNT(*), 2) AS success_rate_percent,
  ROUND(SUM(payment_status = 'failed') * 100.0 / COUNT(*), 2) AS failure_rate_percent
FROM payments;


-- 3. Payment Success Rate by Method

SELECT payment_method,
       ROUND(SUM(payment_status = 'completed') * 100.0 / COUNT(*), 2) AS success_rate
FROM payments
GROUP BY payment_method;


-- 4. Failed Payments (Top 10 by Amount)

SELECT * FROM payments
WHERE payment_status = 'failed'
ORDER BY payment_amount DESC
LIMIT 10;


-- 5. Daily Failed Payment Count (Last 30 Days)

SELECT DATE(payment_date) AS date, COUNT(*) AS failed_count
FROM payments
WHERE payment_status = 'failed' AND payment_date >= CURDATE() - INTERVAL 30 DAY
GROUP BY date
ORDER BY failed_count DESC;


-- 6. Payment Method Share

SELECT payment_method, COUNT(*) AS transactions,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM payments), 2) AS share_percent
FROM payments
GROUP BY payment_method;


-- 7. Average Payment Delay (Order vs Payment)

SELECT AVG(DATEDIFF(payment_date, o.order_date)) AS avg_delay_days
FROM payments p
JOIN customer_orders o ON o.order_id = p.order_id
WHERE p.payment_status = 'completed';


-- 8. High Value Payments (Completed over 400)

SELECT * FROM payments
WHERE payment_status = 'completed' AND payment_amount > 400
ORDER BY payment_amount DESC;


-- 9. Customers with Multiple Failed Payments

SELECT o.customer_id, COUNT(*) AS failed_attempts
FROM payments p
JOIN customer_orders o ON o.order_id = p.order_id
WHERE p.payment_status = 'failed'
GROUP BY o.customer_id
HAVING failed_attempts > 2;


-- 10. Payments With Partial Success

SELECT o.order_id, o.order_amount, SUM(p.payment_amount) AS total_paid
FROM customer_orders o
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'completed'
GROUP BY o.order_id, o.order_amount
HAVING total_paid < o.order_amount;









