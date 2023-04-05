/* Database schema to keep the structure of entire database. */
    CREATE TABLE animals (
   id INT,
   name VARCHAR(250),
   date_of_birth date,
   escape_attempts INT,
   neutered boolean,
   weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species VARCHAR(70);

CREATE TABLE owners (
    id INT,
    full_name VARCHAR(100) NOT NULL,
    age INT
)

CREATE TABLE species (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(100) NOT NULL);

ALTER TABLE animals DROP COLUMN species;