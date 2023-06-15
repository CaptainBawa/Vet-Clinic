/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN DEFAULT FALSE,
    weight_kg NUMERIC
);
-- Adding new table header
ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

---------------------------------------------------------------------------------------------
-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

---------------------------------------------------------------------------------------------
-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

---------------------------------------------------------------------------------------------

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
-- Add column species_id which is a foreign key referencing species table
-- Add column owner_id which is a foreign key referencing the owners table

-- Remove column species
ALTER TABLE animals DROP COLUMN IF EXISTS species;


-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT fk_animals_species
FOREIGN KEY (species_id)
REFERENCES species(id);


-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_animals_owners
FOREIGN KEY (owner_id)
REFERENCES owners(id);


-- Renamed table ID's
ALTER TABLE owners RENAME COLUMN owner_id TO id;
ALTER TABLE species RENAME COLUMN species_id TO id;


---------------------------------------------------------------------------------------------
-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

-- There is a many-to-many relationship between the tables species and vets: 
-- a vet can specialize in multiple species, and a species can have multiple 
-- vets specialized in it. Create a "join table" called specializations to 
-- handle this relationship.

CREATE TABLE specializations (
    vet_id INT,
    species_id INT, 
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

-- There is a many-to-many relationship between the tables animals and vets: 
-- an animal can visit multiple vets and one vet can be visited by multiple 
-- animals. Create a "join table" called visits to handle this relationship, 
-- it should also keep track of the date of the visit.

CREATE TABLE visits (
    vet_id INT,
    animal_id INT,
    visit_date DATE,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (animal_id) REFERENCES animals(id) 
);


