-----------------
-- PROMPT CODE --
-----------------

SELECT first_name,
       sum(total_order_cost) AS total_order_cost,
       order_date
FROM orders o
LEFT JOIN customers c ON o.cust_id = c.id
WHERE order_date BETWEEN '2019-02-1' AND '2019-05-1'
GROUP BY first_name,
         order_date
HAVING sum(total_order_cost) =
  (SELECT max(total_order_cost)
   FROM
     (SELECT sum(total_order_cost) AS total_order_cost
      FROM orders
      WHERE order_date BETWEEN '2019-02-1' AND '2019-05-1'
      GROUP BY cust_id,
               order_date) b)


-- RANDOM DATA ENTRY FOR QUERY TESTING
DROP TABLE IF EXISTS orders
CREATE TABLE customers (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO customers (id, first_name, last_name, email) VALUES
(1, 'John', 'Doe', 'john@example.com'),
(2, 'Jane', 'Smith', 'jane@example.com'),
(3, 'Alice', 'Johnson', 'alice@example.com'),
(4, 'Mike', 'Brown', 'mike@example.com'),
(5, 'Emma', 'Davis', 'emma@example.com'),
(6, 'Liam', 'Wilson', 'liam@example.com'),
(7, 'Olivia', 'Martinez', 'olivia@example.com'),
(8, 'Noah', 'Garcia', 'noah@example.com'),
(9, 'Ava', 'Rodriguez', 'ava@example.com'),
(10, 'James', 'Hernandez', 'james@example.com');


DROP TABLE IF EXISTS orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    cust_id INT,
    order_date DATE,
    total_order_cost DECIMAL(10, 2),
);

INSERT INTO orders (order_id, cust_id, order_date, total_order_cost) VALUES
(101, 1, '2019-02-15', 500),
(102, 2, '2019-02-18', 700),
(103, 1, '2019-03-10', 200),
(104, 3, '2019-03-20', 1000),
(105, 2, '2019-04-05', 300),
(106, 3, '2019-04-15', 800),
(107, 4, '2019-02-14', 600),
(108, 5, '2019-02-20', 450),
(109, 6, '2019-03-05', 1200),
(110, 7, '2019-03-10', 850),
(111, 8, '2019-03-15', 400),
(112, 9, '2019-03-25', 950),
(113, 10, '2019-03-30', 650),
(114, 4, '2019-04-02', 520),
(115, 5, '2019-04-07', 380),
(116, 6, '2019-04-12', 720),
(117, 7, '2019-04-17', 1100),
(118, 8, '2019-04-21', 560),
(119, 9, '2019-04-26', 770),
(120, 10, '2019-04-30', 680),
(121, 1, '2019-02-11', 600),
(122, 2, '2019-02-13', 550),
(123, 3, '2019-02-17', 470),
(124, 4, '2019-02-22', 720),
(125, 5, '2019-03-01', 500),
(126, 6, '2019-03-07', 920),
(127, 7, '2019-03-12', 600),
(128, 8, '2019-03-18', 460),
(129, 9, '2019-03-24', 730),
(130, 10, '2019-03-29', 620);
