WITH RECURSIVE game_folder_structure AS (
    SELECT id, name, parent_id, 0 AS depth, CAST(name AS VARCHAR(1000)) AS path
    FROM folders
    WHERE name = 'Games' AND parent_id IS NULL
	
	UNION ALL
	
    SELECT f.id, f.name, f.parent_id, gfs.depth + 1,
           CAST(gfs.path || '/' || f.name AS VARCHAR(1000)) AS path
    FROM folders f
    JOIN game_folder_structure gfs ON f.parent_id = gfs.id
)
SELECT id, name, parent_id, depth, path
FROM game_folder_structure
ORDER BY path;



-- RANDOM DATA ENTRY FOR TESTING QUERY
CREATE TABLE folders (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES folders(id)
);
-- Root Folder (Games)
INSERT INTO folders (name, parent_id) VALUES
('Games', NULL);  -- Root folder for all games

-- First-level folders (Genres under Games)
INSERT INTO folders (name, parent_id) VALUES
('RPG', 1),        -- RPG under Games
('FPS', 1),        -- FPS under Games
('Strategy', 1);   -- Strategy under Games

-- Second-level folders (Specific Games under Genres)
INSERT INTO folders (name, parent_id) VALUES
('Final Fantasy', 2),  -- Final Fantasy under RPG
('Call of Duty', 3),   -- Call of Duty under FPS
('Civilization', 4);   -- Civilization under Strategy
