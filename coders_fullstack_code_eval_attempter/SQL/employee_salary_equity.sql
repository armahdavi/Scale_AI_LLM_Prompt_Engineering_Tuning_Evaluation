-- Drop tables if they exist
IF OBJECT_ID('employee_profile', 'U') IS NOT NULL DROP TABLE employee_profile;
CREATE TABLE employee_profile (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    gender CHAR(1),
    hire_date DATE,
    street_address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    manager_id INT
);

-- Insert into employee_profile
INSERT INTO employee_profile (id, first_name, last_name, birth_date, gender, hire_date, street_address, city, state, zip_code, manager_id) VALUES
(1, 'John', 'Doe', '1985-02-15', 'M', '2010-06-01', '123 Main St', 'Anytown', 'NY', '12345', NULL),
(2, 'Jane', 'Smith', '1990-07-20', 'F', '2012-09-15', '456 Oak St', 'Othertown', 'TX', '67890', 1),
(3, 'Jim', 'Brown', '1975-11-25', 'M', '2000-03-12', '789 Pine St', 'Sometown', 'CA', '54321', 1);

IF OBJECT_ID('department', 'U') IS NOT NULL DROP TABLE department;
CREATE TABLE department (
    department_no VARCHAR(100) PRIMARY KEY,
    department_name VARCHAR(100)
);

-- Insert into department
INSERT INTO department (department_no, department_name) VALUES
('D001', 'Engineering'),
('D002', 'Marketing');

IF OBJECT_ID('department_manager', 'U') IS NOT NULL DROP TABLE department_manager;
CREATE TABLE department_manager (
    employee_id INT,
    department_no VARCHAR(100),
    from_date DATE,
    to_date DATE
);

-- Insert into department_manager
INSERT INTO department_manager (employee_id, department_no, from_date, to_date) VALUES
(1, 'D001', '2020-01-01', '2023-01-01'),
(2, 'D002', '2021-01-01', '2023-01-01');

IF OBJECT_ID('salary', 'U') IS NOT NULL DROP TABLE salary;
CREATE TABLE salary (
    employee_id INT,
    paid_amount DECIMAL(10, 2),
    date DATE
);

-- Insert into salary
INSERT INTO salary (employee_id, paid_amount, date) VALUES
(1, 80000, '2022-05-01'),
(2, 60000, '2022-06-01'),
(3, 75000, '2022-07-01'),
(1, 81000, '2022-11-01'),
(2, 61000, '2022-12-01'),
(3, 76000, '2022-08-01');

-- Query to retrieve required information
SELECT
    ep.first_name,
    ep.last_name,
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name,
    d.department_name,
    MAX(s.paid_amount) AS highest_salary_2022
FROM
    employee_profile ep
JOIN
    salary s ON ep.id = s.employee_id
LEFT JOIN
    department_manager dm ON ep.id = dm.employee_id AND s.date BETWEEN dm.from_date AND dm.to_date
LEFT JOIN
    department d ON dm.department_no = d.department_no
LEFT JOIN
    employee_profile m ON ep.manager_id = m.id
WHERE
    s.date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY
    ep.first_name,
    ep.last_name,
    m.first_name,
    m.last_name,
    d.department_name
ORDER BY
    ep.first_name,
    ep.last_name;
