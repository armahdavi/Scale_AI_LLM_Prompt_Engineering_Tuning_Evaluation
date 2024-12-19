SELECT 
  COUNT(CASE WHEN country = 'USA' AND status = 'open' THEN 1 END) AS num_active_usa_users,
  COUNT(CASE WHEN country = 'USA' THEN 1 END) AS total_usa_users,
  ROUND(
    COUNT(CASE WHEN country = 'USA' AND status = 'open' THEN 1 END) * 100.0 / 
    COUNT(CASE WHEN country = 'USA' THEN 1 END), 
    2
  ) AS share_active_usa_users
FROM 
  users;


---------------------------------------------------------------
-- RANDOM DATA GENERATION FOR QUERY TESTING & LLM EVALUATION --
---------------------------------------------------------------
-- Create table and insert data for users
IF OBJECT_ID('users', 'U') IS NOT NULL DROP TABLE users;
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    status VARCHAR(20),
    country VARCHAR(50)
);

-- Insert data into users table
INSERT INTO users (user_id, name, status, country) VALUES
(33, 'Amanda Leon', 'open', 'Australia'),
(27, 'Jessica Farrell', 'open', 'Luxembourg'),
(18, 'Wanda Ramirez', 'open', 'USA'),
(50, 'Samuel Miller', 'closed', 'Brazil'),
(16, 'Jacob York', 'open', 'Australia'),
(25, 'Natasha Bradford', 'closed', 'USA'),
(34, 'Donald Ross', 'closed', 'China'),
(52, 'Michelle Jimenez', 'open', 'USA'),
(11, 'Theresa John', 'open', 'China'),
(37, 'Michael Turner', 'closed', 'Australia'),
(32, 'Catherine Hurst', 'closed', 'Mali'),
(61, 'Tina Turner', 'open', 'Luxembourg'),
(4, 'Ashley Sparks', 'open', 'China'),
(82, 'Jacob York', 'closed', 'USA'),
(87, 'David Taylor', 'closed', 'USA'),
(78, 'Zachary Anderson', 'open', 'China');

