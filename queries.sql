/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon%';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name <> 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg 
-- (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

---------------------------------------------------------------------------------------------

-- Inside a transaction update the animals table by setting the species column to unspecified. 
-- Verify that change was made. Then roll back the change and verify that the species columns 
-- went back to the state before the transaction.
BEGIN;
-- update the animals table by setting the species column to unspecified. 
UPDATE animals SET species = unspecified;
-- Verify that change was made.
SELECT * FROM animals;
-- roll back the changeS
ROLLBACK;
-- verify that the species columns went back to the state before the transaction.
SELECT * FROM animals;

---------------------------------------------------------------------------------------------

-- Inside a transaction
BEGIN;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have 
-- species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Verify that changes were made.
SELECT * FROM animals;

--Commit the transaction.
COMMIT;

-- Verify that changes persist after commit.
SELECT * FROM animals;

---------------------------------------------------------------------------------------------

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists.

BEGIN;
-- delete all records
DELETE FROM animals;
-- verify if all records in the animals table IS deleted
SELECT * FROM animals;
-- rollback verify if all records in the animals table still exists
ROLLBACK;
SELECT * FROM animals;

---------------------------------------------------------------------------------------------

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction

BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
-- Create a savepoint for the transaction.
SAVEPOINT animals_savepoint;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
ROLLBACK TO animals_savepoint;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- Commit transaction
COMMIT;

---------------------------------------------------------------------------------------------

-- Write queries to answer the following questions:
-- How many animals are there?
-- How many animals have never tried to escape?
-- What is the average weight of animals?
-- Who escapes the most, neutered or not neutered animals?
-- What is the minimum and maximum weight of each type of animal?
-- What is the average number of escape attempts per animal type of those 
-- born between 1990 and 2000?

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(*) FROM animals WHERE escape_attempts > 0 GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those 
-- born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;



---------------------------------------------------------------------------------------------
-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
-- List of all animals that are pokemon (their type is Pokemon).
-- List all owners and their animals, remember to include those that don't own any animal.
-- How many animals are there per species?
-- List all Digimon owned by Jennifer Orwell.
-- List all animals owned by Dean Winchester that haven't tried to escape.
-- Who owns the most animals?

-- What animals belong to Melody Pond?
SELECT animals.*, full_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.*, species.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't 
-- own any animal.
SELECT owners.full_name, animals.*
FROM owners
LEFT JOIN animals ON owners.owner_id = animals.id;

-- How many animals are there per species?
SELECT species.name, COUNT(animals.*) AS animal_count
FROM species
LEFT JOIN animals ON species.species_id = animals.id
GROUP BY species.name;


-- List all Digimon owned by Jennifer Orwell.
SELECT animals.*, owners.full_name, species.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';


-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.*, owners.full_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;


-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.*) AS animal_count
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC;

---------------------------------------------------------------------------------------------
-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
-- How many different animals did Stephanie Mendez see?
-- List all vets and their specialties, including vets with no specialties.
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
-- What animal has the most visits to vets?
-- Who was Maisy Smith's first visit?
-- Details for most recent visit: animal information, vet information, and date of visit.
-- How many visits were with a vet that did not specialize in that animal's species?
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.


-- Who was the last animal seen by William Tatcher?
SELECT vets.name, animals.name, visits.visit_date
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(animals.id) AS animal_count
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name AS specialty
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name, animals.name, visits.visit_date
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.animal_id) AS visit_count
FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.id
ORDER BY visit_count DESC;

-- Who was Maisy Smith's first visit?
SELECT animals.name, vets.name, vets.date_of_graduation, MIN(visits.visit_date) 
AS first_visit_date
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.id, vets.id
ORDER BY first_visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(*) AS visits_count
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
LEFT JOIN specializations ON vets.id = specializations.vet_id 
AND animals.id = specializations.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT animals.name, COUNT(*) AS visit_count
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name
ORDER BY visit_count DESC
LIMIT 1;




