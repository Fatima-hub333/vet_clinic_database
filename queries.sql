/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name = '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE  name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- 2nd milestone

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

-- Inside Transaction
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon%';
COMMIT TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;
SELECT 8 FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;

UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO SP1;
SELECT * FROM animals;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT TRANSACTION;

-- Write queries to answer the following questions:
-- 1-How many animals are there?
SELECT COUNT(*) FROM animals;

-- 2- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- 3- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- 4- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- 5- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

-- 6- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth <= '2000-12-31' AND date_of_birth >= '1990-01-01' GROUP BY species;

-- Fourth day milestone
-- Who was the last animal seen by William Tatcher?
SELECT animals.animalname, vets.name, visits.date_of_visit 
FROM visits
INNER JOIN animals ON (animals.id = visits.animal_id)
INNER JOIN vets ON (vets.id = visits.vet_id)
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC 
LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(distinct visits.animal_id)
FROM visits
INNER JOIN animals ON (animals.id = visits.animal_id)
INNER JOIN vets ON (vets.id = visits.vet_id)
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.*, species.name as specialty
FROM vets
LEFT OUTER JOIN specializations ON (specializations.vet_id = vets.id)
LEFT JOIN species ON (species.id = specializations.species_id);

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name, animals.*, visits.date_of_visit
FROM visits
INNER JOIN animals ON (animals.id = visits.animal_id)
INNER JOIN vets ON (vets.id = visits.vet_id)
WHERE vets.name = 'Stephanie Mendez'
 and visits.date_of_visit between '2020-04-01' and '2020-08-30'
GROUP BY vets.name, animals.id, visits.date_of_visit;

-- What animal has the most visits to vets?
SELECT animals.*, COUNT(visits.date_of_visit) as visits_to_vet
FROM visits
INNER JOIN animals ON (animals.id = visits.animal_id)
GROUP BY animals.id
ORDER BY COUNT(visits.date_of_visit) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.*, vets.*, visits.date_of_visit
FROM visits
INNER JOIN animals ON (animals.id = visits.animal_id)
INNER JOIN vets ON (VETS.ID = visits.vet_id)
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT * FROM visits
JOIN animals ON animals.id = animal_id
JOIN vets ON vets.id = vet_id
ORDER BY date_of_visit DESC FETCH FIRST ROW ONLY;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) as visits_not_to_specialist
FROM visits
INNER JOIN vets AS vetid ON (vetid.id = visits.vet_id)
INNER JOIN animals ON (animals.id = visits.animal_id)
WHERE  animals.species_id NOT IN (
    SELECT coalesce(specializations.species_id, 0)
    FROM vets 
    LEFT OUTER JOIN specializations ON (specializations.vet_id = vets.id)
    WHERE vets.id = visits.vet_id
);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vets.name, species.name AS specialty, COUNT(animals.species_id)
FROM visits
INNER JOIN vets ON (vets.id = visits.vet_id)
INNER JOIN animals ON (animals.id = visits.animal_id)
INNER JOIN species ON (species.id = animals.species_id)
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name, species.name
ORDER BY COUNT(animals.species_id) DESC
LIMIT 1;