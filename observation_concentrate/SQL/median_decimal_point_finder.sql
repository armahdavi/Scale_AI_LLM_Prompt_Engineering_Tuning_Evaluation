WITH cte AS (
    SELECT num,
           frequency,
           SUM(frequency) OVER (ORDER BY num) - frequency AS cum_sum_before,
           SUM(frequency) OVER (ORDER BY num) AS cum_sum_after,
           SUM(frequency) OVER () AS total_count
    FROM numbers
)
SELECT 
    CASE 
        WHEN MOD(total_count, 2) = 0 THEN
            (SELECT AVG(num)
             FROM cte
             WHERE cum_sum_before < total_count / 2 AND cum_sum_after >= total_count / 2)
        ELSE
            (SELECT num
             FROM cte
             WHERE cum_sum_before < (total_count + 1) / 2 AND cum_sum_after >= (total_count + 1) / 2)
    END AS median
FROM cte
LIMIT 1;


-----------------------------------
-- RANDOM DATA FOR QUERY TESTING --
-----------------------------------
DROP TABLE IF EXISTS numbers   
CREATE TABLE numbers (
   num INT,
   frequency INT
   );

INSERT INTO numbers (num, frequency)
VALUES
   (1, 100),
   (2, 50),
   (3, 30),
   (4, 120),
   (5, 70),
   (6, 30),
   (7, 100),
   (8, 10),
   (9, 150);


--------------------------------
-- QUERY OUTPUT AFTER TESTING --
--------------------------------

-- Output:
-- +--------+
-- | median |
-- +--------+
-- | 5.0000 |
-- +--------+
