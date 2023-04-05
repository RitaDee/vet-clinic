/*Queries that provide answers to the questions from all projects.*/
SELECT * from animals WHERE name LIKE '%mon';
SELECT * from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT * from animals WHERE neutered = true AND escape_attempts < 3;
SELECT * from animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species != 'digimon' OR species IS NULL;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth  > '2022-01-01';
SAVEPOINT del2022;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO del2022;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE  weight_kg < 0;
COMMIT TRANSACTION;

SELECT COUNT (*) FROM animals;
SELECT COUNT (*) FROM animals WHERE escape_attempts != 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered as neutered_animals , COUNT(*) as number_of_escape FROM animals WHERE escape_attempts > 0 GROUP BY neutered;
SELECT species, MIN(weight_kg) as minimum_weight , MAX(weight_kg) as maximum_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) as avg_number_of_escape FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT animals.name AS animals_name, owners.full_name 
FROM animals
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name AS animals_name, species.name AS species_type
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT full_name, animals.name FROM owners LEFT JOIN animals ON animals.owners_id = owners.id;

SELECT species.name, count(animals) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT full_name, animals.name FROM animals 
JOIN owners ON owners.id = animals.owners_id 
WHERE full_name = 'Jennifer Orwell';

SELECT animals.name, animals.escape_attempts FROM animals 
INNER JOIN owners ON owners.id = animals.owners_id 
WHERE owners.full_name = 'Dean Winchester' 
AND animals.escape_attempts < 1;

SELECT owners.full_name , COUNT(animals.name) AS total_animals FROM owners 
JOIN animals ON animals.owners_id=owners.id GROUP BY owners.full_name ORDER BY total_animals 
DESC LIMIT 1;

SELECT v.date_of_visit, a.name, vt.name 
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets vt ON v.vet_id = vt.id 
WHERE vt.name='William Tatcher' 
ORDER BY v.date_of_visit DESC 
LIMIT 1;


SELECT COUNT(a.name) from visits v 
JOIN animals a 
ON v.animal_id = a.id 
JOIN vets vt 
ON v.vet_id = vt.id 
WHERE vt.name='Stephanie Mendez';

SELECT species.name 
AS species_type, vt.name 
AS vet_name from specializations s 
JOIN species 
ON s.species_id = species.id FULL 
JOIN vets vt 
ON s.vets_id = vt.id;

SELECT v.date_of_visit as visit_date, a.name 
AS animal_name, vt.name as vet_name from visits v 
JOIN animals a 
ON v.animal_id = a.id 
JOIN vets vt
ON v.vet_id = vt.id 
WHERE vt.name =' Stephanie Mendez' 
AND v.date_of_visit
BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name, COUNT(a.name) 
AS count_visits FROM visits v 
JOIN animals a ON v.animal_id=a.id 
JOIN vets vt ON v.vet_id=vt.id 
GROUP BY a.name 
HAVING COUNT(a.name) = (
    SELECT MAX(myf.count_visits) 
    FROM ( select a.name, COUNT(a.name) 
    AS count_visits from visits v 
    JOIN animals a ON v.animal_id = a.id 
    JOIN vets vt ON v.vet_id = vt.id 
    GROUP BY a.name) 
    AS myf
);

SELECT v.date_of_visit as visit_day, a.name 
AS animal_name, vt.name AS vet_name 
FROM visits v JOIN animals a 
ON v.animal_id = a.id 
JOIN vets vt 
ON v.vet_id=vt.id 
WHERE vt.name='Maisy Smith' 
ORDER BY v.date_of_visit
LIMIT 1;


SELECT v.date_of_visit as visit_day, a.name 
AS animal_name, vt.name 
AS vet_name 
FROM visits v 
JOIN animals a 
ON v.animal_id = a.id 
JOIN vets vt
ON v.vet_id = vt.id 
ORDER BY v.date_of_visit
DESC LIMIT 1;


SELECT vets.name, s.species_id 
FROM vets 
LEFT JOIN specializations s 
ON s.vets_id=vets.id 
WHERE species_id IS NULL;


SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id
WHERE owner_id = 4 GROUP BY species.name ORDER BY COUNT(*) DESC LIMIT 1;
