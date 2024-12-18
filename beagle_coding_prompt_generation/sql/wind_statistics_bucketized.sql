-- CTE to revise, bucketize and store wind data in the table
WITH revised_wind_table AS (
SELECT 
    wind_speed,
	wind_dir,
	CASE
		WHEN wind_dir BETWEEN 0 AND 337.5 THEN wind_dir + 22.5
		WHEN wind_dir BETWEEN 337.5 AND 360 THEN wind_dir - 337.5
	END AS revised_wind_dir
	
FROM 
    climate_table
)
SELECT 
    wind_speed,
    revised_wind_dir,
    NTILE(8) OVER (ORDER BY revised_wind_dir) AS wind_dir_bucket
INTO 
    revised_wind_results -- The revised wind data is stored in this table
FROM 
    revised_wind_table;

-- Final statistics over wind speed group by wind direction bucketize
SELECT 
	MIN(CAST(wind_speed AS INT)) AS min_,
	MAX(CAST(wind_speed AS INT)) AS max_,
	AVG(CAST(wind_speed AS INT)) as avg_,
	wind_dir_bucket
FROM 
	revised_wind_results
GROUP BY
	wind_dir_bucket
ORDER BY 
	avg_ ASC


---- CAN BE TESTED WITH FOLLOWING RANDOM DATA ----
-- Create the climat table
CREATE TABLE climate_table (
    wind_speed INT,
	wind_dir FLOAT
);

-- populating the climate table with some random data
INSERT INTO climate_table (wind_speed, wind_dir) VALUES
(12, 84),
(10, 163),
(0, 0),
(5,340),
(2,10),
(17,15),
(11,280),
(6,356),
(25,300),
(21,200),
(0,0),
(0,0),
(12,20),
(4,133),
(18,165),
(9,201),
(3,296),
(1,250),
(1,53),
(11,187);
