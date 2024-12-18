---- PROMPT ----

-- I have two different tables of climate data. The first has "date", "temperature", "humidity", "wind speed average", and "solar radiation average". 
-- The second table has "date", "quarter", "cloud index", and "rain precipitation". The data are day intervals in the first table (one observation per day), 
-- but quarter-day intervals in the second table (one observation per quarter of the day or each 6h). The "date" is formatted as "2018-01-01" in the first table 
-- and the "1/1/18" in the second table with the "quarter" column ranging from 1 through 4 to represent the day quarter. 

-- Using SQL, generate a query code that joins two tables: (1) the first table, and (2) the aggregate of the second one by the "date" using GROUP BY 
-- (reformat the "date" column if required for the aggregation). Aggregate "cloud index" by average and rain precipitation by summation in the second table. 

-- Create tables from the scratch in the code with five days of data (5 observations in the first table, and 20 observations in the second table).


---- CHATBOT CODE ----
-- Create the first table
DROP TABLE IF EXISTS climate_table1;
CREATE TABLE climate_table1 (
    date_ DATE,
    temperature FLOAT,
    humidity INT,
    wind_speed_avg INT,
    solar_radiation_avg INT
);

-- Insert sample data in the first table
INSERT INTO climate_table1 (date_, temperature, humidity, wind_speed_avg, solar_radiation_avg) VALUES
('2018-01-01', -3.7, 84, 10, 20),
('2018-01-02', -7.1, 73, 15, 25),
('2018-01-03', -1.2, 77, 2, 22),
('2018-01-04', 0.5, 65, 20, 54),
('2018-01-05', 3.2, 85, 10, 78);

-- Create the second table
DROP TABLE IF EXISTS climate_table2;
CREATE TABLE climate_table2 (
    date_ DATE,
	q INT,
    cloud_index FLOAT,
	rain_precipitation INT
);

-- Insert sample data in the second table
INSERT INTO climate_table2 (date_, q, cloud_index, rain_precipitation) VALUES
('1/1/18', 1, 8.1, 4),
('1/1/18', 2, 7.2, 3),
('1/1/18', 3, 9.0, 16),
('1/1/18', 4, 8.1, 12),
('1/2/18', 1, 3.1, 4),
('1/2/18', 2, 2.1, 1),
('1/2/18', 3, 1.1, 1),
('1/2/18', 4, 0.1, 0),
('1/3/18', 1, 0.0, 0),
('1/3/18', 2, 0.0, 0),
('1/3/18', 3, 0.0, 0),
('1/3/18', 4, 0.0, 0),
('1/4/18', 1, 4.1, 1),
('1/4/18', 2, 5.2, 1),
('1/4/18', 3, 3.6, 3),
('1/4/18', 4, 3.3, 6),
('1/5/18', 1, 2.1, 1),
('1/5/18', 2, 2.3, 1),
('1/5/18', 3, 2.0, 0),
('1/5/18', 4, 1.1, 2);

-- Query to join the first table to the aggregated second table
SELECT
	A.date_,
	A.temperature,
	A.humidity,
    A.wind_speed_avg,
    A.solar_radiation_avg,
	B.cloud_index,
	B.rain_precipitation
FROM climate_table1 AS A
JOIN (
	SELECT 
		FORMAT(CONVERT(DATE, date_, 101), 'yyyy-MM-dd') AS date_,
		AVG(cloud_index) AS cloud_index, 
		SUM(rain_precipitation) AS rain_precipitation
	FROM climate_table2
	GROUP BY date_) AS B
ON A.date_ = B.date_


---- THE OUTPUT WOULD BE THIS ----
-- date_	temperature	humidity	wind_speed_avg	solar_radiation_avg	cloud_index	rain_precipitation
-- 2018-01-01	-3.7	84	10	20	8.1	35
-- 2018-01-02	-7.1	73	15	25	1.6	6
-- 2018-01-03	-1.2	77	2	22	0	0
-- 2018-01-04	0.5	65	20	54	4.05	11
-- 2018-01-05	3.2	85	10	78	1.875	4
