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

CREATE TABLE invoices(
  id  BIGSERIAL PRIMARY KEY NOT NULL,
  total_amount DECIMAL NOT NULL,
  generated-at TIMESTAMP NOT NULL,
  paid_at TIMESTAMP NOT NULL,
  medical_history_id INT,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items(
  id  BIGSERIAL PRIMARY KEY NOT NULL,
  unit_price DECIMAL NOT NULL,
  quantity INT ,
  total_price DECIMAL NOT NULL,
  invoice_id INT ,
  treatment_id INT
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
  FOREIGN KEY (invoice_id) REFERENCES invoices(id),
);

CREATE TABLE doctors (
  treatment_id INT,
  medical_history_id INT,
  FOREIGN KEY (treatment_id) REFERENCES treatments(id),
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
)