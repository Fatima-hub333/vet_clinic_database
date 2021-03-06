/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals(
  id                          INT GENERATED ALWAYS AS IDENTITY,
  name                        VARCHAR(150) NOT NULL,
  date_of_birth               DATE NOT NULL,
  escape_attempts             INT NOT NULL,
  neutered                    BOOLEAN NOT NULL,
  weight_kg                   DECIMAL NOT NULL,
  PRIMARY KEY(id)
);

ALTER TABLE animals ADD species VARCHAR(100);

-- Third Milestone
CREATE TABLE owners(
  id                     INT GENERATED ALWAYS AS IDENTITY,
  full_name              VARCHAR(100) NOT NULL,
  age                    INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE species(
  id                    INT GENERATED ALWAYS AS IDENTITY,
  name                  VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT;

ALTER TABLE animals ADD CONSTRAINT animal_species FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals ADD owner_id INT;

ALTER TABLE animals ADD CONSTRAINT animal_owner FOREIGN KEY (owner_id) REFERENCES owners (id);

-- Fourth Day Milestone

CREATE TABLE vets(
  id                                   INT GENERATED ALWAYS AS IDENTITY,
  name                                 VARCHAR(100),
  age                                  INT,
  date_of_graduation                   DATE,
  PRIMARY KEY (id)
);

CREATE TABLE specializations (
  id       INT GENERATED ALWAYS AS IDENTITY,
  species_id    INT,
  vet_id      INT,
  FOREIGN KEY (species_id) REFERENCES species (id),
  FOREIGN KEY (vet_id) REFERENCES vets (id)
);


CREATE TABLE visits (
  id     INT GENERATED ALWAYS AS IDENTITY,
  date_of_visit    DATE,
  animal_id       INT,
  vet_id          INT,
  PRIMARY KEY (id),
  FOREIGN KEY (animal_id) REFERENCES animals (id),
  FOREIGN KEY (vet_id) REFERENCES vets (id)            
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- FACING ERROR WHILE INSERTING DATA IN OWNERS TABLE SO PUT THIS 7 RESOLVE THAT ISSUE
ALTER TABLE owners ALTER column age DROP NOT NULL;