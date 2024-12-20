-- Define the query using Common Table Expressions (CTEs)
WITH LastQuarterSalaries AS (
    SELECT
        e.employee_id,
        e.team_id,
        e.salary,
        ROW_NUMBER() OVER (PARTITION BY e.team_id ORDER BY e.salary DESC) AS rank
    FROM Employees e
    JOIN Vacations v ON e.employee_id = v.employee_id
    WHERE v.last_vacation_date BETWEEN '2024-01-01' AND '2024-03-31'
),
TopEmployees AS (
    SELECT *
    FROM LastQuarterSalaries
    WHERE rank <= 5
),
LatestVacations AS (
    SELECT
        v.employee_id,
        v.last_vacation_date,
        v.vacation_type,
        ROW_NUMBER() OVER (PARTITION BY v.employee_id ORDER BY v.last_vacation_date DESC) AS rn
    FROM Vacations v
),
LatestVacationsFiltered AS (
    SELECT
        employee_id,
        last_vacation_date,
        vacation_type
    FROM LatestVacations
    WHERE rn = 1
)
SELECT
    t.employee_id,
    t.team_id,
    t.salary,
    t.rank,
    lv.last_vacation_date,
    lv.vacation_type
FROM TopEmployees t
LEFT JOIN LatestVacationsFiltered lv ON t.employee_id = lv.employee_id
ORDER BY t.team_id ASC, t.salary DESC;




----------------------------------------
-- FILLING WITH RANDOM DATA GENERATED --
----------------------------------------

DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    team_id INT,
    salary DECIMAL(10, 2)
);

INSERT INTO Employees (employee_id, team_id, salary)
VALUES 
    (1, 1, 80500.00),
    (2, 1, 85500.00),
    (3, 2, 90750.00),
    (4, 2, 82750.00),
    (5, 3, 78800.00),
    (6, 3, 95000.00),
    (7, 3, 85500.00);


DROP TABLE IF EXISTS Vacations
CREATE TABLE Vacations (
    vacation_id INT PRIMARY KEY,
    employee_id INT,
    last_vacation_date DATE,
    vacation_type VARCHAR(50)
);

INSERT INTO Vacations (vacation_id, employee_id, last_vacation_date, vacation_type)
VALUES 
    (1, 1, '2024-02-10', 'Personal Leave'),
    (2, 2, '2024-02-20', 'Annual Leave'),
    (3, 5, '2024-02-25', 'Personal Leave'),
    (4, 6, '2024-02-29', 'Annual Leave'),
    (5, 7, '2024-03-01', 'Personal Leave');



------------------------
-- THE OUTPUT RESULTS --
------------------------
-- employee_id	team_id	salary	rank	last_vacation_date	vacation_type
-- 2	1	85500.00	1	2024-02-20	Annual Leave
-- 1	1	80500.00	2	2024-02-10	Personal Leave
-- 6	3	95000.00	1	2024-02-29	Annual Leave
-- 7	3	85500.00	2	2024-03-01	Personal Leave
-- 5	3	78800.00	3	2024-02-25	Personal Leave
