-- Query over atheletic performance progress

WITH PerformanceData AS (
  SELECT
    a.athleteId,
    a.eventName,
    a.year,
    a.country,
    a.score
  FROM
    Athletics a
  INNER JOIN Countries c ON a.country = c.country
  WHERE
    a.eventName IN ('100m', 'Long Jump', 'Shot Put') 
    AND a.year BETWEEN YEAR(GETDATE()) - 5 AND YEAR(GETDATE())
    AND c.region = 'Europe'
),
AveragedScores AS (
  SELECT
    eventName,
    year,
    AVG(score) AS averageScore
  FROM
    PerformanceData
  GROUP BY
    eventName, year
),
YearlyImprovement AS (
  SELECT
    eventName,
    year,
    averageScore,
    LAG(averageScore) OVER (PARTITION BY eventName ORDER BY year) AS previousAverage
  FROM
    AveragedScores
)
SELECT
  eventName,
  year,
  ROUND(((averageScore - previousAverage) / previousAverage) * 100, 2) AS ImprovementPercentage
FROM
  YearlyImprovement
WHERE
  previousAverage IS NOT NULL
ORDER BY
  eventName, year;



-- RANDOM DATA FOR TESTING QUERY

DROP TABLE IF EXISTS Athletics
CREATE TABLE Athletics (
    athleteId INT PRIMARY KEY,
    athleteName VARCHAR(100),
    eventName VARCHAR(50),
    year INT,
    country VARCHAR(50),
    score DECIMAL(5, 2)
);

INSERT INTO Athletics (athleteId, athleteName, eventName, year, country, score)
VALUES
(1, 'John Doe', '100m', 2019, 'France', 10.25),
(2, 'Jane Smith', '100m', 2019, 'Germany', 10.50),
(3, 'John Doe', '100m', 2020, 'France', 10.15),
(4, 'Jane Smith', '100m', 2020, 'Germany', 10.30),
(5, 'John Doe', '100m', 2021, 'France', 10.05),
(6, 'Jane Smith', '100m', 2021, 'Germany', 10.20),
(7, 'John Doe', '100m', 2022, 'France', 9.95),
(8, 'Jane Smith', '100m', 2022, 'Germany', 10.10),
(9, 'John Doe', '100m', 2023, 'France', 9.85),
(10, 'Jane Smith', '100m', 2023, 'Germany', 9.90),

(11, 'James Brown', 'Long Jump', 2019, 'Spain', 7.50),
(12, 'Alex Turner', 'Long Jump', 2019, 'Italy', 7.30),
(13, 'James Brown', 'Long Jump', 2020, 'Spain', 7.70),
(14, 'Alex Turner', 'Long Jump', 2020, 'Italy', 7.40),
(15, 'James Brown', 'Long Jump', 2021, 'Spain', 7.85),
(16, 'Alex Turner', 'Long Jump', 2021, 'Italy', 7.60),
(17, 'James Brown', 'Long Jump', 2022, 'Spain', 7.90),
(18, 'Alex Turner', 'Long Jump', 2022, 'Italy', 7.80),
(19, 'James Brown', 'Long Jump', 2023, 'Spain', 8.00),
(20, 'Alex Turner', 'Long Jump', 2023, 'Italy', 7.95),

(21, 'Paul Green', 'Shot Put', 2019, 'Poland', 18.50),
(22, 'Tom Lee', 'Shot Put', 2019, 'Sweden', 18.30),
(23, 'Paul Green', 'Shot Put', 2020, 'Poland', 18.70),
(24, 'Tom Lee', 'Shot Put', 2020, 'Sweden', 18.40),
(25, 'Paul Green', 'Shot Put', 2021, 'Poland', 18.90),
(26, 'Tom Lee', 'Shot Put', 2021, 'Sweden', 18.60),
(27, 'Paul Green', 'Shot Put', 2022, 'Poland', 19.10),
(28, 'Tom Lee', 'Shot Put', 2022, 'Sweden', 18.80),
(29, 'Paul Green', 'Shot Put', 2023, 'Poland', 19.25),
(30, 'Tom Lee', 'Shot Put', 2023, 'Sweden', 18.95);


DROP TABLE IF EXISTS Countries
CREATE TABLE Countries (
    country VARCHAR(50),
    region VARCHAR(100)
);

INSERT INTO Countries (country, region)
VALUES
('France', 'Europe'),
('Germany', 'Europe'),
('Spain', 'Europe'),
('Italy', 'Europe'),
('Poland', 'Europe'),
('Sweden', 'Europe'),
('USA', 'North America'),
('China', 'Asia');

