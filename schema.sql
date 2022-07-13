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