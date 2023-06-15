/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Charmander', '2022-02-08', 0, false, -11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Angemon', '2005-06-12', 1, true, -45);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Blossom', '1998-10-13', 3, true, 17);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Ditto', '2022-05-14', 4, true, 22);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id) 
VALUES ('Charmander', '2020-02-08', 0, false, 11, 2, 4);


---------------------------------------------------------------------------------------------
-- Insert the following data into the owners table:
-- Sam Smith 34 years old.
-- Jennifer Orwell 19 years old.
-- Bob 45 years old.
-- Melody Pond 77 years old.
-- Dean Winchester 14 years old.
-- Jodie Whittaker 38 years old.

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34);

INSERT INTO owners (full_name, age)
VALUES ('Jennifer Orwell', 19);

INSERT INTO owners (full_name, age)
VALUES ('Bob', 45);

INSERT INTO owners (full_name, age)
VALUES ('Melody Pond', 77);

INSERT INTO owners (full_name, age)
VALUES ('Dean Winchester', 14);

INSERT INTO owners (full_name, age)
VALUES ('Jodie Whittaker', 38);

---------------------------------------------------------------------------------------------
-- Insert the following data into the species table:
-- Pokemon
-- Digimon

INSERT INTO species (name)
VALUES ('Digimon');

INSERT INTO species (name)
VALUES ('Pokemon');

---------------------------------------------------------------------------------------------

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon

-- If the name ends in "mon" it will be Digimon
UPDATE animals
SET species_id = 1
WHERE name LIKE '%mon' AND species_id IS NULL;
-- All other animals are Pokemon
UPDATE animals
SET species_id = 2
WHERE name NOT LIKE '%mon' AND species_id IS NULL;

---------------------------------------------------------------------------------------------

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.
-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.

-- Sam Smith owns Agumon.
UPDATE animals
SET owner_id = (SELECT owner_id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals
SET owner_id = (SELECT owner_id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');
-- Bob owns Devimon and Plantmon.
UPDATE animals
SET owner_id = (SELECT owner_id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');
-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals
SET owner_id = (SELECT owner_id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals
SET owner_id = (SELECT owner_id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

---------------------------------------------------------------------------------------------

-- Insert the following data for vets:
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.

-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('William Tatcher', 45, '2000-04-23');
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Maisy Smith', 26, '2019-01-17');
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Stephanie Mendez', 64, '1981-05-04');
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Jack Harkness', 38, '2008-06-08');
