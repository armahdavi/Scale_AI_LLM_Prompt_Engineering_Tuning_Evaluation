WITH order_totals AS (
    SELECT 
        order_id,
        SUM(quantity * unit_price) AS total_amount
    FROM 
        order_items
    GROUP BY 
        order_id
)
SELECT 
    c.customer_id,
    c.first_name,
    o.order_id,
    o.order_date,
    ROUND(COALESCE(ot.total_amount, 0), 2) AS total_order_amount
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
LEFT JOIN 
    order_totals ot ON o.order_id = ot.order_id
WHERE 
    c.country = 'USA'
ORDER BY 
    total_order_amount DESC;



---------------------------------------
-- TEST WITH RANDOMLY GENERATED DATA --
---------------------------------------

-- Create the customers table
DROP TABLE IF EXISTS customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    country VARCHAR(50)
);

-- Insert data into the customers table
INSERT INTO customers (customer_id, first_name, country) VALUES
(1, 'John', 'USA'),
(2, 'Jane', 'USA'),
(3, 'Bob', 'USA'),
(4, 'Alice', 'Canada');


DROP TABLE IF EXISTS orders
-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert data into the orders table
INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1, 1, '2024-03-01'),
(2, 2, '2024-03-02'),
(3, 3, '2024-03-03'),
(4, 4, '2024-03-04');


DROP TABLE IF EXISTS order_items
-- Create the order_items table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insert data into the order_items table
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 101, 1, 50.0),
(2, 1, 102, 2, 50.0),
(3, 2, 103, 1, 100.0),
(4, 2, 104, 3, 50.0),
(5, 3, 105, 2, 90.0),
(6, 3, 106, 1, 90.0);


