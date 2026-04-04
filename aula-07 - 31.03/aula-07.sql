-- 1-)
CREATE SCHEMA avaliacaocontinua;

-- 2-)
CREATE TABLE avaliacaocontinua.company (
    company_name VARCHAR(255) NOT NULL PRIMARY KEY,
    city VARCHAR(255)
);

-- 3-)
CREATE TABLE avaliacaocontinua.employee (
    person_name VARCHAR(255) NOT NULL PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(255)
);

-- 4-)
CREATE TABLE avaliacaocontinua.manages (
    person_name VARCHAR(255) NOT NULL PRIMARY KEY,
    manager_name VARCHAR(255)
);

-- 5-)
CREATE TABLE avaliacaocontinua.works (
    person_name VARCHAR(255) NOT NULL PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2)
);

-- 6-)
ALTER TABLE avaliacaocontinua.works
ADD CONSTRAINT fk_works_employee
FOREIGN KEY (person_name) REFERENCES avaliacaocontinua.employee(person_name)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- 7-)
ALTER TABLE avaliacaocontinua.works
ADD CONSTRAINT fk_works_company
FOREIGN KEY (company_name) REFERENCES avaliacaocontinua.company(company_name)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- 8-)
ALTER TABLE avaliacaocontinua.manages
ADD CONSTRAINT fk_manages_employee
FOREIGN KEY (person_name) REFERENCES avaliacaocontinua.employee(person_name)
ON UPDATE CASCADE
ON DELETE CASCADE;