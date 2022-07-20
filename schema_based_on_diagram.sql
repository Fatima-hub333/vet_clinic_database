CREATE TABLE medical_histories(
  id                          INT GENERATED ALWAYS AS IDENTITY,
  admitted_at     TIMESTAMP NOT NULL,
  patient_id    INT NOT NULL,
  status        VARCHAR NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE patients(
  id                          INT GENERATED ALWAYS AS IDENTITY,
  name   VARCHAR NOT NULL,
  date_of_birth      DATE NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE treatments(
  id                          INT GENERATED ALWAYS AS IDENTITY,
  type   VARCHAR NOT NULL,
  name   VARCHAR NOT NULL,
  PRIMARY KEY(id)
);