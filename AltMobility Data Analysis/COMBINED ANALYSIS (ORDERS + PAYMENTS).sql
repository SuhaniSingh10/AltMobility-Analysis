-- 1. Full Order Report (with Payments)

SELECT o.order_id, o.customer_id, o.order_date, o.order_amount, o.order_status,
       p.payment_status, p.payment_amount, p.payment_method
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id;


-- 2. Pending Orders with Failed or Missing Payment

SELECT o.order_id, o.customer_id, o.order_amount, p.payment_status
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status = 'Pending' AND (p.payment_status = 'failed' OR p.payment_status IS NULL);


-- 3. Orders with Payment Mismatch (Amount Diff > 10%)

SELECT o.order_id, o.order_amount, p.payment_amount,
       ABS(o.order_amount - p.payment_amount) AS diff
FROM customer_orders o
JOIN payments p ON o.order_id = p.order_id
WHERE ABS(o.order_amount - p.payment_amount) / o.order_amount > 0.1;


-- 4. Top 5 Customers by Successful Payments

SELECT o.customer_id, COUNT(*) AS success_count, SUM(p.payment_amount) AS total_paid
FROM customer_orders o
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'completed'
GROUP BY o.customer_id
ORDER BY total_paid DESC
LIMIT 5;


-- 5.  Orders Without Any Payment

SELECT o.order_id, o.customer_id, o.order_date
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE p.order_id IS NULL;


-- 6. Orders with Mixed Payment Outcomes

SELECT o.order_id, COUNT(DISTINCT p.payment_status) AS status_count
FROM customer_orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_id
HAVING status_count > 1
ORDER BY status_count DESC;


-- 7. Average Number of Payment Attempts per Order

SELECT AVG(payment_attempts) AS avg_attempts
FROM (
    SELECT order_id, COUNT(*) AS payment_attempts
    FROM payments
    GROUP BY order_id
) AS attempts;


-- 8. Orders With Overpaid Amount

SELECT o.order_id, o.order_amount, ROUND(SUM(p.payment_amount)) AS total_paid
FROM customer_orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_id,o.order_amount
HAVING total_paid > o.order_amount;


-- 9. Orders Completed but Payment Pending

SELECT o.order_id, o.order_status, p.payment_status
FROM customer_orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status = 'Delivered' AND p.payment_status != 'completed';


-- 10. Most Used Payment Method by High-Value Customers

SELECT p.payment_method, COUNT(*) AS mostly_used
FROM payments p
JOIN customer_orders o ON o.order_id = p.order_id
WHERE o.customer_id IN (
    SELECT customer_id
    FROM customer_orders
    GROUP BY customer_id
    HAVING SUM(order_amount) > 1000
)
GROUP BY p.payment_method
ORDER BY mostly_used DESC;







