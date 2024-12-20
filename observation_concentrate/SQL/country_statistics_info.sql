SELECT 
    Countries.Country,
    Countries.Capital,
    Countries.GDP_TrUSD,
    Countries.Population AS Country_Population,
    Countries.Area_SqKm AS Country_Area_SqKm,
    Countries.Continent,
    Cities.Population AS City_Population,
    Cities.Area_SqKm AS City_Area_SqKm
FROM 
    Countries
INNER JOIN 
    Cities
ON 
    Countries.Capital = Cities.City;

-- TEST QUERY WITH RANDOM GENERATED DATA
DROP TABLE IF EXISTS Countries
CREATE TABLE Countries (
    Country VARCHAR(255),
    Capital VARCHAR(255),
    GDP_TrUSD FLOAT,
    Population INT,
    Area_SqKm INT,
    Continent VARCHAR(255)
);

INSERT INTO Countries (Country, Capital, GDP_TrUSD, Population, Area_SqKm, Continent)
VALUES
    ('Palau', 'Ngerulmud City', 7200.93, 17279, 953, 'Oceania'),
    ('Guatemala', 'Guatemala City', 5706.58, 10556861, 71696, 'North America'),
    ('Guinea-Bissau', 'Bissau City', 2001.10, 1169595, 29597, 'Africa'),
    ('Aruba', 'Oranjestad City', 7089.05, 107939, 137, 'North America'),
    ('Comoros', 'Moroni City', 3400.90, 780192, 2065, 'Africa'),
    ('Libya', 'Tripoli City', 7969.91, 5650595, 1482878, 'Africa'),
    ('Oman', 'Muscat City', 4090.66, 4161567, 268619, 'Asia'),
    ('Barbados', 'Bridgetown City', 7909.63, 271916, 411, 'North America'),
    ('Djibouti', 'Djibouti City', 6976.60, 615686, 21060, 'Africa'),
    ('Seychelles', 'Victoria City', 1626.07, 94296, 470, 'Africa');

DROP TABLE IF EXISTS Cities
CREATE TABLE Cities (
    City VARCHAR(255),
    Population INT,
    Area_SqKm INT
);
INSERT INTO Cities (City, Population, Area_SqKm)
VALUES
    ('Ngerulmud City', 391, 1.5),
    ('Guatemala City', 1000000, 469),
    ('Bissau City', 492000, 77),
    ('Oranjestad City', 35000, 21),
    ('Moroni City', 54000, 30),
    ('Tripoli City', 1150000, 400),
    ('Muscat City', 1400000, 3500),
    ('Bridgetown City', 110000, 40),
    ('Djibouti City', 623000, 103),
    ('Victoria City', 26500, 20),
    ('Koror', 11000, 65),
    ('Quetzaltenango', 180000, 127),
    ('Cacheu', 32000, 54),
    ('San Nicolas', 15000, 19),
    ('Fomboni', 25000, 40),
    ('Benghazi', 650000, 314),
    ('Salalah', 340000, 840),
    ('Speightstown', 3500, 5),
    ('Ali Sabieh', 40000, 120),
    ('Anse Boileau', 4200, 9);
