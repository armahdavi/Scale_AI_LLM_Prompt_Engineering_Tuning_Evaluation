-- Declare variables for the current date and floor date (30 days ago)
DECLARE @current_date DATE = CAST(GETDATE() AS DATE);
DECLARE @floor_date DATE = DATEADD(DAY, -30, @current_date);

-- Query to retrieve player information for the specified bounty ID
SELECT DISTINCT
    p.player_username,
    p.player_email_address
FROM Players p
JOIN Sessions s
    ON s.player_id = p.player_id
JOIN PlayersBounties pb
    ON pb.player_id = p.player_id
WHERE 
    s.session_date BETWEEN @floor_date AND @current_date
    AND s.session_length >= 1
    AND pb.bounty_id = 'BK1YW2Z8-RSIJ-Z1NK-GRC4-O3QPCHN6F5AU';




---- HERE ARE SOME RANDOM DATA CREATION TO APPLY THE ABOVE QUERY ----

-- Create Players table
DROP TABLE IF EXISTS Players; -- Drop tables if they already exist
CREATE TABLE Players (
    player_id INT,
    player_username VARCHAR(100),
    account_creation_date DATE,
    player_email_address VARCHAR(100),
    player_birthday DATE,
    player_active BIT
);
-- Insert data into Players table
INSERT INTO Players (player_id, player_username, account_creation_date, player_email_address, player_birthday, player_active) 
VALUES 
(1, 'playerOne', '2021-01-01', 'player1@example.com', '1990-05-12', 1),
(2, 'playerTwo', '2021-02-10', 'player2@example.com', '1995-08-22', 1),
(3, 'playerThree', '2020-11-05', 'player3@example.com', '1988-03-30', 0),
(4, 'playerFour', '2021-03-15', 'player4@example.com', '2000-12-12', 1),
(5, 'playerFive', '2021-05-20', 'player5@example.com', '1992-10-18', 1);

-- Create Sessions table
DROP TABLE IF EXISTS Sessions;
CREATE TABLE Sessions (
    session_id INT,
    player_id INT,
    session_date DATE,
    session_start_time TIME,
    session_end_time TIME,
    session_length INT
    
);

-- Insert data into Sessions table
INSERT INTO Sessions (session_id, player_id, session_date, session_start_time, session_end_time, session_length)
VALUES 
(1, 1, '2022-09-15', '12:00:00', '13:00:00', 60),
(2, 1, '2022-09-16', '14:00:00', '15:30:00', 90),
(1, 2, '2022-09-15', '09:00:00', '10:00:00', 60),
(2, 2, '2022-09-14', '11:00:00', '11:45:00', 45),
(3, 2, '2022-09-13', '13:00:00', '14:00:00', 60),
(4, 2, '2022-09-12', '14:30:00', '16:00:00', 90),
(1, 3, '2022-09-12', '15:00:00', '16:30:00', 90),
(2, 3, '2022-09-11', '12:00:00', '12:45:00', 45),
(1, 4, '2022-09-10', '08:30:00', '09:30:00', 60),
(2, 4, '2022-09-09', '17:00:00', '18:00:00', 60),
(3, 4, '2022-09-08', '19:00:00', '20:00:00', 60),
(4, 4, '2022-09-07', '14:00:00', '15:30:00', 90),
(5, 4, '2022-09-06', '15:00:00', '16:00:00', 60),
(1, 5, '2022-09-05', '10:00:00', '11:00:00', 60),
(2, 5, '2022-09-04', '16:30:00', '18:00:00', 90);


DROP TABLE IF EXISTS Bounties;
-- Create Bounties table
CREATE TABLE Bounties (
    bounty_id VARCHAR(36) PRIMARY KEY,
    bounty_name VARCHAR(100),
    bounty_mission_id INT
);
-- Insert data into Bounties table
INSERT INTO Bounties (bounty_id, bounty_name, bounty_mission_id)
VALUES 
('7GA4C1E5-D9Z5-56A0-8556-6BB5B0711E5J', 'Treasure Hunt', 101),
('1DA5C3F1-A9B7-43E2-8422-8DD8B0711C3K', 'Dragon Slayer', 102),
('4DF2G1H8-B6D3-57F9-9228-3CC7A0711F7L', 'Rescue Princess', 103),
('3FG6B1A7-C8E5-44A9-8335-2BB4C0711H2M', 'Defend the Castle', 104),
('6HG8D2F3-A2E6-59B8-7744-5CC8D0711I9N', 'Find the Artifact', 105),
('9JK4E3C2-B3F7-66A7-9953-8DD6A0711J8O', 'Conquer the Dungeon', 106),
('8LM7C1D6-D4G8-77B6-6682-9FF5B0711K7P', 'Protect the Village', 107),
('5NO9D3E7-E5H9-88C5-9971-7GG6A0711L6Q', 'Raid the Bandits', 108),
('4PQ8F2C5-F6J1-99D4-7743-6HH8D0711M5R', 'Defeat the Warlord', 109),
('7RS6B3A4-G7K2-11C3-6642-5II9B0711N4S', 'Escort the Caravan', 110),
('3TU9C1F6-H8L3-22B2-5531-4JJ7A0711O3T', 'Search the Caves', 111),
('9VW7D3E5-J9M4-33A1-4420-3KK8B0711P2U', 'Steal the Jewel', 112),
('8XY6B2F4-K1N5-44C0-3319-2LL9A0711Q1V', 'Capture the Flag', 113),
('6ZA9C3D2-L2O6-55A9-2208-1MM7B0711R0W', 'Bounty Hunter', 114),
('5AB8F4C3-M3P7-66B8-1197-9NN6A0711S9X', 'Save the Forest', 115);


DROP TABLE IF EXISTS PlayersBounties;
-- Create PlayersBounties table
CREATE TABLE PlayersBounties (
    player_id INT,
    bounty_id VARCHAR(36),
);
-- Insert sample data into the PlayersBounties table
INSERT INTO PlayersBounties (player_id, bounty_id)
VALUES 
(1, '8LM7C1D6-D4G8-77B6-6682-9FF5B0711K7P'),
(1, 'LP6LP8AT-OJE5-007L-JH0M-CC2AAKXJZ67E'),
(2, 'KOTDX9HT-W4LD-D5PK-OXZE-G3VX3G4266E3'),
(2, '8LM7C1D6-D4G8-77B6-6682-9FF5B0711K7P'),
(2, '7GA4C1E5-D9Z5-56A0-8556-6BB5B0711E5J'),
(2, '71H0CMZM-06RE-1UGP-7EN5-GHIC03IQXCEF'),
(3, 'H80944LS-G24C-NZ2J-V16Q-1JX61DC9AEF1'),
(4, '8LM7C1D6-D4G8-77B6-6682-9FF5B0711K7P'),
(4, '8LM7C1D6-D4G8-77B6-6682-9FF5B0711K7P'),
(4, 'TUXS23FX-C4DH-DJ92-4L7J-BIOSICXMTSOM'),
(4, '7GA4C1E5-D9Z5-56A0-8556-6BB5B0711E5J'),
(5, '8LM7C1D6-D4G8-77B6-6682-9FF5B0711K7P'),
(5, '8LM7C1D6-D4G8-77B6-6682-9FF5B0711K7P'),
(5, 'BK1YW2Z8-RSIJ-Z1NK-GRC4-O3QPCHN6F5AU'),
(5, 'BK1YW2Z8-RSIJ-Z1NK-GRC4-O3QPCHN6F5AU');
