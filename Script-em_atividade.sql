USE hospital;

SELECT * from Medicos;

ALTER TABLE Medicos ADD COLUMN atividade varchar(255);
-- Ativo = 1;
-- Inativo = 0;

-- INSERT INTO Medicos (atividade) VALUES ('1');

UPDATE Medicos SET atividade = '1' WHERE cpf = '12345678900';
UPDATE Medicos SET atividade = '1' WHERE cpf = '23456789012';
UPDATE Medicos SET atividade = '0' WHERE cpf = '34567890123';
UPDATE Medicos SET atividade = '1' WHERE cpf = '45678901234';
UPDATE Medicos SET atividade = '1' WHERE cpf = '56789012345';
UPDATE Medicos SET atividade = '0' WHERE cpf = '67890123456';
UPDATE Medicos SET atividade = '1' WHERE cpf = '78901234567';
UPDATE Medicos SET atividade = '0' WHERE cpf = '89012345678';
UPDATE Medicos SET atividade = '1' WHERE cpf = '90123456789';
UPDATE Medicos SET atividade = '1' WHERE cpf = '01334567890';
UPDATE Medicos SET atividade = '1' WHERE cpf = '12245678901';