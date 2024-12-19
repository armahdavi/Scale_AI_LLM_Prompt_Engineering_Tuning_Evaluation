-------------------------------------
-- RANDOM DATA CREATION PER PROMPT --
-------------------------------------
DROP TABLE IF EXISTS GameStats
CREATE TABLE GameStats (
    Username NVARCHAR(50),
    GameID INT,
    Rank NVARCHAR(20), -- Rank as descriptive categories
    MoneySpent DECIMAL(10, 2)
);

-- Insert random observations into the GameStats table
INSERT INTO GameStats (Username, GameID, Rank, MoneySpent) VALUES
('PlayerOne', 1001, 'Challenger', 150.00),
('GamerGirl', 1002, 'Diamond', 75.50),
('DragonSlayer', 1003, 'Platinum', 200.00),
('NinjaMaster', 1004, 'Gold', 120.75),
('SpeedDemon', 1005, 'Silver', 95.30),
('RogueAssassin', 1006, 'Bronze', 110.25),
('KnightKing', 1007, 'Platinum', 50.00),
('ShadowHunter', 1008, 'Diamond', 85.40),
('WarriorQueen', 1009, 'Challenger', 220.00),
('MageLord', 1010, 'Gold', 130.50),
('BattleMage', 1011, 'Silver', 45.00),
('FireSorcerer', 1012, 'Bronze', 60.75),
('FrostWizard', 1013, 'Platinum', 90.00),
('DarkKnight', 1014, 'Diamond', 170.20),
('ArchAngel', 1015, 'Challenger', 80.00);


-- Query
WITH PlayerDetails AS (
    SELECT
        Username,
        GameID,
        Rank,
        MoneySpent
    FROM
        PlayerRank
)
SELECT
    Rank,
    AVG(MoneySpent) AS AverageMoneySpent
FROM
    PlayerDetails
WHERE
    Rank IN ('Challenger', 'Bronze')
GROUP BY
    Rank;
