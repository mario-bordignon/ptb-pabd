-- 1-) 
CREATE TABLE pessoa (
    ID INT PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    idade INT CHECK (idade >= 0)
);

-- 2-)
ALTER TABLE pessoa
ADD CONSTRAINT unique_pessoa UNIQUE (ID, nome, sobrenome); -- optei por não incluir ID pois já é PK

-- 3-)
ALTER TABLE pessoa
ALTER COLUMN idade SET NOT NULL;

-- 4-)
CREATE TABLE endereco (
    ID INT PRIMARY KEY,
    rua VARCHAR(50) NOT NULL
);

ALTER TABLE pessoa
ADD endereco_id INT;

ALTER TABLE pessoa
ADD CONSTRAINT fk_pessoa_endereco
FOREIGN KEY (endereco_id)
REFERENCES endereco(ID);
