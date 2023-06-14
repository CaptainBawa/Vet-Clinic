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
