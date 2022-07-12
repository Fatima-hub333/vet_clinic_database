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
