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
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE species (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(100) NOT NULL);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT, ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owners_id INT, ADD CONSTRAINT fk_owners_id FOREIGN KEY (owners_id) REFERENCES owners(id);

CREATE TABLE species (
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 name VARCHAR(100) NOT NULL);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	age INT NOT NULL,
	date_of_graduation date
);

CREATE TABLE specializations (
    species_id INT,
    vets_id INT,
    CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits ( 
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	animal_id INT REFERENCES animals(id),	
	vet_id INT REFERENCES vets(id),	
	date_of_graduation DATE 
);

ALTER TABLE animals ADD CONSTRAINT unique_animal_id UNIQUE (id);
