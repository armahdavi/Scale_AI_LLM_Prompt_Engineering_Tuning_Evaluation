----- PROMPT CODE INCLUDING DATA ----

-- Drop tables if they already exist
IF OBJECT_ID('payment', 'U') IS NOT NULL DROP TABLE payment;

-- Create payment table
CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    staff_id INT NOT NULL,
    rental_id INT DEFAULT NULL,
    amount DECIMAL(5, 2) NOT NULL,
    payment_date DATETIME NOT NULL,
    last_update DATETIME NULL DEFAULT GETDATE()
);

-- Insert data into payment table
INSERT INTO payment (payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update) VALUES
(1, 1, 1, 76, 2.99, '2005-05-25 11:30:37', '2006-02-15 22:12:30'),
(2, 1, 1, 573, 0.99, '2005-05-28 10:35:23', '2006-02-15 22:12:30'),
(3, 2, 1, 1185, 5.99, '2005-06-15 00:54:12', '2006-02-15 22:12:30'),
(4, 2, 2, 1422, 0.99, '2005-06-15 18:02:53', '2006-02-15 22:12:30'),
(5, 3, 2, 1476, 9.99, '2005-06-15 21:08:46', '2006-02-15 22:12:30'),
(6, 3, 1, 1725, 4.99, '2005-06-16 15:18:57', '2006-02-15 22:12:30'),
(7, 4, 1, 2308, 4.99, '2005-06-18 08:41:48', '2006-02-15 22:12:30'),
(8, 4, 2, 2363, 0.99, '2005-06-18 13:33:59', '2006-02-15 22:12:30'),
(9, 5, 1, 3284, 3.99, '2005-06-21 06:24:45', '2006-02-15 22:12:30'),
(10, 5, 2, 4526, 5.99, '2005-07-08 03:17:05', '2006-02-15 22:12:30'),
(11, 1, 1, 4611, 5.99, '2005-07-08 07:33:56', '2006-02-15 22:12:30'),
(12, 2, 1, 5244, 4.99, '2005-07-09 13:24:07', '2006-02-15 22:12:30'),
(13, 3, 1, 5326, 4.99, '2005-07-09 16:38:01', '2006-02-15 22:12:30'),
(14, 4, 1, 6163, 7.99, '2005-07-11 10:13:46', '2006-02-15 22:12:30'),
(15, 5, 2, 7273, 2.99, '2005-07-27 11:31:22', '2006-02-15 22:12:30'),
(16, 1, 1, 7841, 4.99, '2005-07-28 09:04:45', '2006-02-15 22:12:30'),
(17, 2, 2, 8033, 4.99, '2005-07-28 16:18:23', '2006-02-15 22:12:30'),
(18, 3, 1, 8074, 0.99, '2005-07-28 17:33:39', '2006-02-15 22:12:30'),
(19, 4, 2, 8116, 0.99, '2005-07-28 19:20:07', '2006-02-15 22:12:30'),
(20, 5, 2, 8326, 2.99, '2005-07-29 03:58:49', '2006-02-15 22:12:30');



---- CHATBOT 1 RESPONSE CODE ----
SELECT
    c.customer_id,
    m.month_num,
    ISNULL(SUM(p.amount), 0) AS total_amount
FROM
    (SELECT DISTINCT customer_id FROM payment) c
CROSS JOIN
    (
        SELECT 1 AS month_num UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
        UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
    ) m
LEFT JOIN payment p ON
    p.customer_id = c.customer_id AND MONTH(p.payment_date) = m.month_num
GROUP BY
    c.customer_id, m.month_num
ORDER BY
    c.customer_id, m.month_num;




---- CHATBOT 2 RESPONSE CODE ----
-- Get total payments for each customer by month, including months with no payments
WITH months AS (
  SELECT 
    EXTRACT(MONTH FROM '2005-01-01' + INTERVAL '1' MONTH * (ROW_NUMBER() OVER () - 1)) AS month
  FROM 
    (SELECT 1 AS x UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12) AS t
)
SELECT 
  c.customer_id,
  m.month,
  COALESCE(SUM(p.amount), 0) AS total_amount
FROM 
  (SELECT DISTINCT customer_id FROM payment) c
  CROSS JOIN months m
  LEFT JOIN payment p ON c.customer_id = p.customer_id AND m.month = EXTRACT(MONTH FROM p.payment_date)
GROUP BY 
  c.customer_id, m.month
ORDER BY 
  c.customer_id, m.month;
