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
('Shadow Leopard', 'Panthera nebulosa', '2000-01-01', 'Endangered'),
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Endangered'),
('Golden Langur', 'Trachypithecus geei', '1953-01-01', 'Endangered'),
('Clouded Leopard', 'Neofelis nebulosa', '1821-01-01', 'Vulnerable'),
('King Cobra', 'Ophiophagus hannah', '1836-01-01', 'Vulnerable'),
('Indian Star Tortoise', 'Geochelone elegans', '1802-01-01', 'Vulnerable'),
('Nilgiri Tahr', 'Nilgiritragus hylocrius', '1847-01-01', 'Endangered'),
('Asian Black Bear', 'Ursus thibetanus', '1829-01-01', 'Vulnerable'),
('Malabar Civet', 'Viverra civettina', '1836-01-01', 'Endangered'),
('Lion-tailed Macaque', 'Macaca silenus', '1792-01-01', 'Endangered'),
('White-bellied Heron', 'Ardea insignis', '1832-01-01', 'Endangered'),
('Pygmy Hog', 'Porcula salvania', '1847-01-01', 'Endangered'),
('Gharial', 'Gavialis gangeticus', '1789-01-01', 'Endangered'),
('Fishing Cat', 'Prionailurus viverrinus', '1837-01-01', 'Vulnerable'),
('Hoolock Gibbon', 'Hoolock hoolock', '1917-01-01', 'Endangered'),
('Great Indian Bustard', 'Ardeotis nigriceps', '1832-01-01', 'Endangered');


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(5, 4, 'Foggy Basin', '2024-05-11 08:30:00', 'Seen crossing path'),
(6, 5, 'Sunset Ridge', '2024-05-12 09:00:00', 'Tracks found'),
(7, 6, 'Highland Trails', '2024-05-13 14:15:00', 'Observed from distance'),
(8, 7, 'Echo Canyon', '2024-05-14 15:45:00', 'Resting under tree'),
(9, 8, 'Storm Peak', '2024-05-15 17:00:00', 'Moving in herd'),
(10, 9, 'Marshland Creek', '2024-05-16 10:20:00', 'Single adult'),
(11, 10, 'Verdant Zone', '2024-05-17 12:50:00', 'Hunting activity'),
(12, 11, 'Misty Mountains', '2024-05-18 13:15:00', 'Calls heard'),
(13, 12, 'Rainforest Edge', '2024-05-19 11:10:00', 'Two juveniles'),
(14, 13, 'Coral Coastline', '2024-05-20 07:40:00', 'Seen near water'),
(15, 14, 'Savannah Plains', '2024-05-21 09:30:00', 'In shade'),
(16, 15, 'Crimson Valley', '2024-05-22 10:00:00', NULL),
(17, 3, 'River Delta', '2024-05-23 11:35:00', 'Digging near burrow'),
(18, 2, 'Bamboo Grove East', '2024-05-24 08:55:00', 'Wet fur observed'),
(19, 1, 'Peak Ridge', '2024-05-25 16:45:00', 'Short glimpse'),
(20, 5, 'Shimmer Forest', '2024-05-26 17:30:00', 'Feeding on fruits'),
(3, 6, 'Mountain Range', '2024-05-26 06:00:00', 'Spotted again'),
(1, 2, 'Snowfall Pass', '2024-05-27 18:00:00', 'Same individual as before'),
(4, 8, 'Northern Hills', '2024-05-27 19:15:00', 'Trumpeting heard'),
(2, 7, 'Bankwood Area', '2024-05-28 07:00:00', 'Large adult seen'),
(8, 9, 'Misty Mountains', '2024-05-28 12:00:00', 'Moving south');

SELECT * FROM species;
SELECT * FROM sightings;
SELECT * FROM rangers;

