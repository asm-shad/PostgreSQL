CREATE DATABASE conservation_db;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) CHECK (
        conservation_status IN ('Endangered', 'Vulnerable')
    )
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id) ON DELETE CASCADE,
    ranger_id INT REFERENCES rangers(ranger_id) ON DELETE CASCADE,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(100) NOT NULL,
    notes TEXT
);

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

INSERT INTO rangers (name, region) VALUES
('David Stone', 'Rainforest Edge'),
('Eva Brooks', 'Coral Coastline'),
('Frank Harris', 'Savannah Plains'),
('Grace Miller', 'Highland Trails'),
('Henry Adams', 'River Delta'),
('Isla Lewis', 'Northern Hills'),
('Jack Lee', 'Foggy Basin'),
('Kara James', 'Sunset Ridge'),
('Leo Nash', 'Misty Mountains'),
('Mia Grant', 'Marshland Creek'),
('Noah Reed', 'Crimson Valley'),
('Olivia Wood', 'Shimmer Forest'),
('Paul Young', 'Verdant Zone'),
('Quinn Blake', 'Echo Canyon'),
('Ruby Hart', 'Storm Peak');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Golden Langur', 'Trachypithecus geei', '1953-01-01', 'Vulnerable'),
('Clouded Leopard', 'Neofelis nebulosa', '1821-01-01', 'Vulnerable'),
('Gharial', 'Gavialis gangeticus', '1789-01-01', 'Endangered'),
('Fishing Cat', 'Prionailurus viverrinus', '1832-01-01', 'Vulnerable'),
('Pygmy Hog', 'Porcula salvania', '1847-01-01', 'Endangered'),
('Black-necked Crane', 'Grus nigricollis', '1831-01-01', 'Vulnerable'),
('Indian Cobra', 'Naja naja', '1758-01-01', 'Vulnerable'),
('Great Hornbill', 'Buceros bicornis', '1758-01-01', 'Vulnerable'),
('Malabar Civet', 'Viverra civettina', '1836-01-01', 'Endangered'),
('King Cobra', 'Ophiophagus hannah', '1836-01-01', 'Vulnerable'),
('Nilgiri Tahr', 'Nilgiritragus hylocrius', '1841-01-01', 'Endangered'),
('Pink-headed Duck', 'Rhodonessa caryophyllacea', '1835-01-01', 'Endangered'),
('Sarus Crane', 'Grus antigone', '1758-01-01', 'Vulnerable'),
('Takin', 'Budorcas taxicolor', '1829-01-01', 'Vulnerable'),
('Wild Water Buffalo', 'Bubalus arnee', '1827-01-01', 'Endangered'),
('Zebra Mussel', 'Dreissena polymorpha', '1765-01-01', 'Vulnerable');


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 4, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(5, 5, 'Golden Valley', '2024-05-20 11:00:00', 'Family group sighted'),
(6, 6, 'Cloud Forest', '2024-05-21 14:25:00', NULL),
(7, 7, 'River Bend', '2024-05-22 08:40:00', 'Nesting behavior observed'),
(8, 8, 'Marshland Zone', '2024-05-23 15:10:00', NULL),
(9, 9, 'Grassland Edge', '2024-05-24 10:30:00', 'Tracks found'),
(10, 10, 'Highland Marsh', '2024-05-25 16:00:00', 'Flock of 5 seen'),
(11, 11, 'Swamp Region', '2024-05-26 09:50:00', NULL),
(12, 12, 'Forest Canopy', '2024-05-27 13:15:00', 'Heard call at dawn'),
(13, 13, 'Lowland Woods', '2024-05-28 07:30:00', 'Sighted near river'),
(14, 14, 'Rocky Outcrop', '2024-05-29 18:45:00', NULL),
(15, 15, 'Mountain Slope', '2024-05-30 12:00:00', 'Herd grazing'),
(16, 1, 'Wetlands', '2024-05-31 08:20:00', 'Rare duck sighted'),
(17, 2, 'Grass Flats', '2024-06-01 15:40:00', 'Pair observed'),
(18, 3, 'Hilltop', '2024-06-02 11:10:00', NULL),
(19, 4, 'River Delta', '2024-06-03 14:50:00', 'Buffalo herd crossing'),
(20, 5, 'Lake Shore', '2024-06-04 17:25:00', NULL);


SELECT * FROM species;
SELECT * FROM sightings;
SELECT * FROM rangers;

-- - Problem 1
INSERT INTO rangers (name, region) VALUES
('Derek Fox', 'Coastal Plains');

-- - Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species
FROM sightings;

-- - Problem 3
SELECT * FROM sightings
WHERE location LIKE '%Pass%';

-- - Problem 4
SELECT name, count(s.sighting_id) AS total_sightings
FROM rangers
LEFT JOIN sightings s USING (ranger_id)
GROUP BY rangers.name;

-- - Problem 5
SELECT s.common_name
FROM species s
LEFT JOIN sightings sg USING (species_id)
Where sg.sighting_id IS NULL;

-- - Problem 6
SELECT sp.common_name, si.sighting_time, ra.name
FROM sightings si
JOIN species sp ON si.species_id = sp.species_id
JOIN rangers ra ON si.ranger_id = ra.ranger_id
ORDER BY si.sighting_time DESC
LIMIT 2;

-- - Problem 7
UPDATE species 
SET conservation_status = 'Historic'
WHERE EXTRACT(YEAR FROM discovery_date) < 1800;

-- ALTER TABLE species DROP CONSTRAINT species_conservation_status_check;

-- ALTER TABLE species
-- ADD CONSTRAINT species_conservation_status_check
-- CHECK (conservation_status IN ('Vulnerable', 'Endangered', 'Historic'));

-- - Problem 8
CREATE OR REPLACE FUNCTION get_time_of_day(ts TIMESTAMP)
RETURNS TEXT AS 
$$
    BEGIN
    IF EXTRACT(HOUR FROM ts) < 12 THEN
        RETURN 'Morning';
    ELSIF EXTRACT(HOUR FROM ts) BETWEEN 12 AND 17 THEN
        RETURN 'Afternoon';
    ELSE
        RETURN 'Evening';
    END IF;
    END;
$$ 
LANGUAGE plpgsql;


SELECT 
  sighting_id,
  get_time_of_day(sighting_time) AS time_of_day
FROM sightings;



-- - Problem 9
