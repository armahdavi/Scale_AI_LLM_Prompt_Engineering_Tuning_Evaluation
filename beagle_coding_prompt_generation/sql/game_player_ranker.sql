CREATE TABLE players (
    player_id INT PRIMARY KEY,      -- Unique identifier for each player
    player_name NVARCHAR(100),      -- Name of the player
    xp INT,                         -- Experience points of the player
    rank_ NVARCHAR(50)              -- Rank of the player
);

-- Example data for query test; The query will be run over real streaming data though
INSERT INTO players (player_id, player_name, xp, rank_)
VALUES
    (1, 'PlayerOne', 120, 'Silver II'),
    (2, 'PlayerTwo', 175, 'Silver III'),
    (3, 'PlayerThree', 230, 'Silver IV'),
    (4, 'PlayerFour', 290, 'Silver V'),
    (5, 'PlayerFive', 345, 'Silver II'),
    (6, 'PlayerSix', 410, 'Silver III'),
    (7, 'PlayerSeven', 470, 'Silver IV'),
    (8, 'PlayerEight', 520, 'Silver V');


-- Step 1: Extract rank information and isolate the Roman numeral part
WITH rank_data AS (
    SELECT
        player_id,               -- Player's ID
        player_name,             -- Player's name
        xp,                      -- Player's XP
        rank_,                   -- Player's rank (e.g., 'Silver II')
        -- Extract the Roman numeral part after 'Silver' (e.g., 'Silver II' -> 'II')
        LTRIM(SUBSTRING(rank_, CHARINDEX(' ', rank_) + 1, LEN(rank_))) AS roman_numeral
    FROM players
    -- Filter to only include ranks that start with 'Silver'
    WHERE rank_ LIKE 'Silver%'
),
-- Step 2: Convert Roman numeral to corresponding integer value
roman_to_int AS (
    SELECT 
        player_id,               -- Player's ID
        player_name,             -- Player's name
        xp,                      -- Player's XP
        rank_,                   -- Player's rank (e.g., 'Silver II')
        roman_numeral,           -- The extracted Roman numeral (e.g., 'II')
        -- Convert Roman numerals into integers using a CASE statement
        CASE
            WHEN roman_numeral = 'I' THEN 1
            WHEN roman_numeral = 'II' THEN 2
            WHEN roman_numeral = 'III' THEN 3
            WHEN roman_numeral = 'IV' THEN 4
            WHEN roman_numeral = 'V' THEN 5
            WHEN roman_numeral = 'VI' THEN 6
            WHEN roman_numeral = 'VII' THEN 7
            WHEN roman_numeral = 'VIII' THEN 8
            WHEN roman_numeral = 'IX' THEN 9
            WHEN roman_numeral = 'X' THEN 10
            ELSE NULL
        END AS rank_numeric       -- Numeric version of the Roman numeral rank
    FROM rank_data
)
-- Step 3: Calculate average rank per 100 XP range
SELECT 
    -- Group XP into 100 XP ranges (e.g., 0-99, 100-199, 200-299, etc.)
    FLOOR(xp / 100) * 100 AS xp_range,
    -- Calculate the average of the numeric rank for each XP range
    AVG(rank_numeric) AS avg_rank
FROM roman_to_int
-- Only include records where the rank could be successfully converted to a number
WHERE rank_numeric IS NOT NULL
-- Group by the calculated XP range
GROUP BY FLOOR(xp / 100) * 100
-- Order the result by XP range
ORDER BY FLOOR(xp / 100) * 100;

