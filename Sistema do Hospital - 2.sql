-- DROP schema hospital;

CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;

-- Criando tabelas

CREATE TABLE `Medicos` (
  `nome` varchar(255) NOT NULL,
  `cpf` varchar(11) PRIMARY KEY,
  `crm` varchar(13) UNIQUE NOT NULL,
  `rg` varchar(255) UNIQUE,
  `categoria` integer NOT NULL,
  `especialidade` integer NOT NULL
);

CREATE TABLE `Categorias` (
  `id` integer PRIMARY KEY,
  `categoria` varchar(255)
);

CREATE TABLE `Especialidades` (
  `id` integer PRIMARY KEY,
  `especialidade` varchar(255)
);

CREATE TABLE `Pacientes` (
  `nome` varchar(255) NOT NULL,
  `data_de_nascimento` date,
  `endereco` integer NOT NULL,
  `telefone` integer,
  `email` integer,
  `cpf` varchar(255) PRIMARY KEY,
  `rg` varchar(255) UNIQUE,
  `convenio` integer NOT NULL DEFAULT 1
);

CREATE TABLE `Telefone` (
  `id` integer PRIMARY KEY,
  `telefone` varchar(11),
  `tipo` varchar(255) COMMENT 'se o telefone é fixo, celular, etc.'
);

CREATE TABLE `emails` (
  `id` integer PRIMARY KEY,
  `partelocal` varchar(64) COMMENT 'o "nome de usuário" que vem antes do "@"',
  `dominio` varchar(255) COMMENT 'o que vem depois do "@", ex: gmail.com'
);

CREATE TABLE `Convenios` (
  `id` integer PRIMARY KEY,
  `nome` varchar(255) NOT NULL,
  `cnpj` varchar(15) NOT NULL,
  `fim_da_carencia` date
);

CREATE TABLE `Enderecos` (
  `id` integer PRIMARY KEY,
  `logradouro` varchar(255) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `numero` integer NOT NULL,
  `complemento` varchar(255),
  `ponto_de_referencia` varchar(255),
  `bairro` varchar(255) NOT NULL,
  `cidade` varchar(255) NOT NULL,
  `estado` char(2) NOT NULL,
  `cep` char(8) NOT NULL
);

CREATE TABLE `Consultas` (
  `id` integer PRIMARY KEY,
  `data_e_hora` datetime NOT NULL,
  `medico` varchar(11) NOT NULL,
  `especialidade` integer NOT NULL,
  `paciente` varchar(255) NOT NULL,
  `valor` double NOT NULL,
  `convenio` integer NOT NULL,
  `carteira` integer NOT NULL,
  `receita` integer
);

CREATE TABLE `Receitas` (
  `id` integer PRIMARY KEY,
  `data` datetime NOT NULL,
  `medicamento` varchar(255) NOT NULL,
  `quantidade` text,
  `instrucoes` text COMMENT 'Descrever o uso'
);

CREATE TABLE `Internacoes` (
  `id` integer PRIMARY KEY,
  `paciente` varchar(255) NOT NULL,
  `data_de_entrada` datetime NOT NULL,
  `data_prevista_de_alta` datetime,
  `data_efetiva_de_alta` datetime NOT NULL,
  `procedimentos` text NOT NULL COMMENT 'Descrever o procedimento realizado',
  `medico` varchar(11) NOT NULL,
  `enfermeiro` varchar(255) NOT NULL,
  `quarto` integer NOT NULL
);

CREATE TABLE `Enfermeiros` (
  `nome` varchar(255) NOT NULL,
  `cpf` varchar(255) PRIMARY KEY,
  `CRE` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `Quartos` (
  `id` integer PRIMARY KEY,
  `tipo` varchar(255) COMMENT 'Os quartos podem ser apartamentos, quartos duplos e enfermaria.',
  `valor_diario` varchar(255) NOT NULL
);

-- Adicionando chaves estrangeiras

ALTER TABLE `Medicos` ADD FOREIGN KEY (`categoria`) REFERENCES `Categorias` (`id`);

ALTER TABLE `Medicos` ADD FOREIGN KEY (`especialidade`) REFERENCES `especialidades` (`id`);

ALTER TABLE `Pacientes` ADD FOREIGN KEY (`endereco`) REFERENCES `Enderecos` (`id`);

ALTER TABLE `Pacientes` ADD FOREIGN KEY (`telefone`) REFERENCES `Telefone` (`id`);

ALTER TABLE `Pacientes` ADD FOREIGN KEY (`email`) REFERENCES `emails` (`id`);

ALTER TABLE `Pacientes` ADD FOREIGN KEY (`convenio`) REFERENCES `Convenios` (`id`);

ALTER TABLE `Consultas` ADD FOREIGN KEY (`medico`) REFERENCES `Medicos` (`cpf`);

ALTER TABLE `Consultas` ADD FOREIGN KEY (`especialidade`) REFERENCES `Especialidades` (`id`);

ALTER TABLE `Consultas` ADD FOREIGN KEY (`paciente`) REFERENCES `Pacientes` (`cpf`);

ALTER TABLE `Consultas` ADD FOREIGN KEY (`convenio`) REFERENCES `Convenios` (`id`);

ALTER TABLE `Consultas` ADD FOREIGN KEY (`receita`) REFERENCES `Receitas` (`id`);

ALTER TABLE `Internacoes` ADD FOREIGN KEY (`paciente`) REFERENCES `Pacientes` (`cpf`);

ALTER TABLE `Internacoes` ADD FOREIGN KEY (`medico`) REFERENCES `Medicos` (`cpf`);

ALTER TABLE `Internacoes` ADD FOREIGN KEY (`enfermeiro`) REFERENCES `Enfermeiros` (`cpf`);

ALTER TABLE `Internacoes` ADD FOREIGN KEY (`quarto`) REFERENCES `Quartos` (`id`);



-- Inserindo dados nas tabelas

INSERT INTO Categorias (id, categoria) VALUES 
(1, 'Especialista'),
(2, 'Residente'),
(3, 'Generalista');

INSERT INTO especialidades (id, especialidade) VALUES
(1, 'Cardiologia'),
(2, 'Ortopedia'),
(3, 'Neurologia'),
(4, 'Psiquiatria'),
(5, 'Pediatria'),
(6, 'Clínica Geral'),
(7, 'Gastrenterologia'),
(8, 'Dermatologia');

INSERT INTO Medicos (nome, cpf, crm, rg, categoria, especialidade) VALUES
('Medikua Nor', '12345678900', 'CRM122456', 'RG644321', '1', '1'),
('Luke Skywalker', '23456789012', 'CRM234567', 'RG543210', '2', '2'),
('Hari Seldon', '34567890123', 'CRM345678', 'RG432109', '1', '3'),
('Neo Spock', '45678901234', 'CRM456789', 'RG321098', '3', '4'),
('Dors Venabili', '56789012345', 'CRM567890', 'RG210987', '1', '5'),
('Eto Demerzel', '67890123456', 'CRM678901', 'RG109876', '2', '6'),
('Leia Organa', '78901234567', 'CRM789012', 'RG098765', '1', '7'),
('Han Solo', '89012345678', 'CRM890123', 'RG987654', '3', '8'),
('Emmett Brown', '90123456789', 'CRM901234', 'RG876543', '2', '1'),
('Tricia McMillan', '01334567890', 'CRM012345', 'RG765432', '1', '2'),
('Bayta Darell', '12245678901', 'CRM123456', 'RG654321', '3', '3');

insert into emails (id, partelocal,dominio) values
('1','tony.stark','example.com'),
('2','hermione.granger','example.com'),
('3','luke.skywalker','example.com'),
('4','leia.organa','example.com'),
('5','harry.potter','example.com'),
('6','katniss.everdeen','example.com'),
('7','james.bond','example.com'),
('8','daenerys.targaryen','example.com'),
('9','tony.montana','example.com'),
('10','lara.croft','example.com'),
('11','aragorn.elessar','example.com'),
('12','ellen.ripley','example.com'),
('13','marty.mcfly','example.com'),
('14','katara.waterbender','example.com'),
('15','jack.sparrow','example.com'),
('16','eleven','example.com');

INSERT INTO telefone (id, telefone, tipo) VALUES
('1', '12345678900', 'Casa'),
('2', '23456789011', 'Casa'),
('3', '45678901233', 'Casa'),
('4', '56789012344', 'Casa');

INSERT INTO enderecos (id, logradouro, nome, numero, complemento, ponto_de_referencia, bairro, cidade, estado, cep) VALUES
(1, 'Casa', 'Corvinal', '004', 'Azul', 'Casa azul', 'London', 'Hogwarts', 'BA', '00000004'),
(2, 'Casa', 'Grifinória', '004', 'Vermelho', 'Casa vermelha', 'London', 'Hogwarts', 'BA', '00000004'),
(3, 'Casa', 'Sonserina', '004', 'Verde', 'Casa verde', 'London', 'Hogwarts', 'BA', '00000004'),
(4, 'Casa', 'Lufa-Lufa', '004', 'Amarelo', 'Casa amarela', 'London', 'Hogwarts', 'BA', '00000004');

INSERT INTO convenios (id, nome, cnpj, fim_da_carencia) VALUES
(1, 'Convenio A', '12345678901234', '2015-01-12'),
(2, 'Convenio B', '23456789012345', '2015-02-15'),
(3, 'Convenio C', '34567890123456', '2015-04-30'),
(4, 'Convenio D', '45678901234567', '2015-06-14');

INSERT INTO pacientes (nome, data_de_nascimento, endereco, email, telefone, rg, cpf, convenio) VALUES
('Tony Stark', '1980-05-15', '1', '1', '1', '98765432', '13345678900', 1),
('Hermione Granger', '1981-09-19', '1', '2', '1', '88654321', '24456789011', 2),
('Anakin Skywalker', '1977-05-25', '2', '3', '2', '76543210', '34567890122', 1),
('Bail Organa', '1977-03-22', '3', '4', '3', '65432109', '45678901233', 3),
('Harry Potter', '1980-07-31', '2', '5', '2', '54321098', '56789012344', 2),
('Katniss Everdeen', '1994-05-08', '3', '6', '3', '43210987', '67890123455', 1),
('James Bond', '1965-03-07', '4', '7', '4', '32109876', '78901234566', 3),
('Daenerys Targaryen', '1986-06-17', '2', '8', '2', '21098765', '89012345677', 4),
('Tony Montana', '1958-11-02', '4', '9', '4', '10987654', '90123456788', 4),
('Lara Croft', '1972-02-14', '3', '10', '3', '98865432', '71234567897', 1),
('Aragorn Elessar', '2931-03-06', '2', '11', '2', '87654321', '12345678900', 2),
('Ellen Ripley', '2092-01-07', '3', '12', '3', '75544210', '23456789011', 3),
('Marty McFly', '1968-06-17', '4', '13', '4', '65532109', '34567790122', 4),
('Walter White', '1992-02-17', '2', '14', '2', '54421098', '45679901233', 4),
('Jack Sparrow', '1690-03-04-', '2', '15', '2', '65632110', '56789222344', 2),
('Eleven Things', '1971-11-06', '4', '16', '4', '65792109','56718012345', 2);

INSERT INTO receitas (id, data, medicamento, quantidade, instrucoes) VALUES
(1, '2015-02-01', 'Paracetamol, Amoxicilina', '30 comprimidos, 20 comprimidos', 'Tomar 1 comprimido de Paracetamol a cada 6 horas, tomar 1 comprimido de Amoxicilina duas vezes ao dia'),
(2, '2015-02-02', 'Rivotril', '30 comprimidos', 'Tomar 1 comprimido à noite antes de dormir'),
(3, '2015-02-03', 'Cefalexina, Pomada de Neomicina', '14 comprimidos, 1 tubo', 'Tomar 1 comprimido de Cefalexina duas vezes ao dia, aplicar a pomada de Neomicina conforme necessário'),
(4, '2015-03-03', 'Omeprazol, Ranitidina', '30 comprimidos, 30 comprimidos', 'Tomar 1 comprimido de Omeprazol antes do café da manhã, tomar 1 comprimido de Ranitidina antes do jantar'),
(5, '2015-02-04', 'Dipirona, Ibuprofeno', '20 comprimidos, 10 comprimidos', 'Tomar 1 comprimido de Dipirona a cada 8 horas, tomar 1 comprimido de Ibuprofeno a cada 12 horas'),
(6, '2015-03-04', 'Paracetamol, Dipirona', '25 comprimidos, 15 comprimidos', 'Tomar 1 comprimido de Paracetamol a cada 6 horas, tomar 1 comprimido de Dipirona a cada 8 horas'),
(7, '2015-04-25', 'Omeprazol', '30 comprimidos', 'Tomar 1 comprimido de Omeprazol antes do café da manhã'),
(8, '2015-02-05', 'Pomada de Neomicina', '1 tubo', 'Aplicar a pomada de Neomicina conforme necessário'),
(9, '2015-03-06', 'Rivotril, Diazepam', '30 comprimidos, 20 comprimidos', 'Tomar 1 comprimido de Rivotril à noite antes de dormir, tomar 1 comprimido de Diazepam duas vezes ao dia'),
(10, '2015-06-14', 'Ibuprofeno, Paracetamol', '20 comprimidos, 30 comprimidos', 'Tomar 1 comprimido de Ibuprofeno a cada 12 horas, tomar 1 comprimido de Paracetamol a cada 6 horas'),
(11, '2015-06-15', 'Dipirona, Pomada de Neomicina', '15 comprimidos, 1 tubo', 'Tomar 1 comprimido de Dipirona a cada 8 horas, aplicar a pomada de Neomicina conforme necessário'),
(12, '2015-06-16', 'Amoxicilina', '20 comprimidos', 'Tomar 1 comprimido de Amoxicilina duas vezes ao dia'),
(13, '2015-07-20', 'Rivotril', '30 comprimidos', 'Tomar 1 comprimido à noite antes de dormir'),
(14, '2015-08-07', 'Cefalexina, Pomada de Neomicina', '14 comprimidos, 1 tubo', 'Tomar 1 comprimido de Cefalexina duas vezes ao dia, aplicar a pomada de Neomicina conforme necessário'),
(15, '2015-02-08', 'Omeprazol, Ranitidina', '30 comprimidos, 30 comprimidos', 'Tomar 1 comprimido de Omeprazol antes do café da manhã, tomar 1 comprimido de Ranitidina antes do jantar'),
(16, '2015-02-09', 'Dipirona, Ibuprofeno', '20 comprimidos, 10 comprimidos', 'Tomar 1 comprimido de Dipirona a cada 8 horas, tomar 1 comprimido de Ibuprofeno a cada 12 horas'),
(17, '2015-02-10', 'Paracetamol, Dipirona', '25 comprimidos, 15 comprimidos', 'Tomar 1 comprimido de Paracetamol a cada 6 horas, tomar 1 comprimido de Dipirona a cada 8 horas'),
(18, '2015-02-10', 'Omeprazol', '30 comprimidos', 'Tomar 1 comprimido de Omeprazol antes do café da manhã'),
(19, '2015-12-01', 'Pomada de Neomicina', '1 tubo', 'Aplicar a pomada de Neomicina conforme necessário'),
(20, '2015-12-25', 'Rivotril, Diazepam', '30 comprimidos, 20 comprimidos', 'Tomar 1 comprimido de Rivotril à noite antes de dormir, tomar 1 comprimido de Diazepam duas vezes ao dia');

INSERT INTO consultas (id, data_e_hora, medico, especialidade, paciente, valor, convenio, carteira, receita) VALUES
('1', '2015-02-01 10:30', '12345678900', '1', '56789012344', '150', '1', '1', '1'),
('2', '2015-02-02 15:45', '23456789012', '2', '67890123455', '200', '2', '2', '2'),
('3', '2015-02-03 09:15', '34567890123', '3', '45679901233', '180', '3', '3', '3'),
('4', '2015-03-03 14:20', '45678901234', '4', '89012345677', '220', '4', '4', '4'),
('5', '2015-02-04 11:10', '56789012345', '5', '13345678900', '190', '1', '1', '5'),
('6', '2015-03-04 16:55', '67890123456', '6', '45679901233', '170', '2', '2', '6'),
('7', '2015-04-25 13:40', '78901234567', '7', '45679901233', '210', '3', '3', '7'),
('8', '2015-02-05 10:20', '89012345678', '8', '71234567897', '160', '4', '4', '8'),
('9', '2015-03-06 15:15', '90123456789', '1', '56718012345', '230', '1', '1', '9'),
('10', '2015-06-14 09:50', '01334567890', '2', '34567790122', '240', '2', '2', '10'),
('11', '2015-06-15 14:35', '12245678901', '3', '23456789011', '170', '3', '3', '11'),
('12', '2015-06-16 11:25', '12345678900', '1', '56789012344', '150', '1', '1', '12'),
('13', '2015-07-20 10:30', '23456789012', '2', '24456789011', '200', '2', '2', '13'),
('14', '2015-08-07 15:45', '34567890123', '3', '34567790122', '180', '3', '3', '14'),
('15', '2015-02-08 09:15', '45678901234', '4', '56718012345', '220', '4', '4', '15'),
('16', '2015-02-09 14:20', '56789012345', '5', '56789012344', '190', '1', '1', '16'),
('17', '2015-02-10 11:10', '67890123456', '6', '67890123455', '170', '2', '2', '17'),
('18', '2015-02-10 16:55', '78901234567', '7', '45679901233', '210', '3', '3', '18'),
('19', '2015-12-01 13:40', '89012345678', '8', '89012345677', '160', '4', '4', '19'),
('20', '2015-12-25 10:20', '90123456789', '1', '13345678900', '230', '1', '1', '20');

INSERT INTO quartos (id, tipo, valor_diario) VALUES
(1, 'Apartamento', '500'),
(2, 'Quartos duplos', '250'),
(3, 'Enfermaria', '100');

INSERT INTO enfermeiros (nome, cpf, CRE) VALUES
('Joana Dark', '25415698755', '060606'),
('Nina Simone', '32598745886', '252628'),
('David Bowie', '22145225458', '064512'),
('Doja Catlin', '87456962455', '658695'),
('Donald Glover', '80748565505', '328514'),
('Post Malone', '65848565505', '365842'),
('Phelomena Cunk', '05148565505', '202125'),
('Joaquin Phoenix', '85588565505', '845721'),
('Remi Wolf', '87459565505', '758514'),
('Bobby Demarco', '54156358531', '145521');

INSERT INTO internacoes (id, paciente, data_de_entrada, data_prevista_de_alta, data_efetiva_de_alta, procedimentos, medico, enfermeiro, quarto) VALUES
(1, '71234567897', '2016-02-24', '2016-02-25', '2016-02-25', 'Cirurgia', '45678901234', '25415698755', '1'),
(2, '23456789011', '2016-02-28', '2016-02-29', '2016-03-01', 'Cirurgia', '56789012345', '32598745886', '2'),
(3, '23456789011', '2016-03-12', '2016-03-25', '2016-03-24', 'Cirurgia', '45678901234', '32598745886', '2'),
(4, '23456789011', '2016-04-24', '2016-04-25', '2016-04-25', 'Cirurgia', '67890123456', '87456962455', '3'),
(5, '56789222344', '2016-08-24', '2016-08-25', '2016-08-26', 'Cirurgia', '45678901234', '80748565505', '3'),
(6, '90123456788', '2016-08-26', '2016-08-30', '2016-09-30', 'Cirurgia', '67890123456', '22145225458', '2'),
(7, '45679901233', '2016-10-06', '2016-10-25', '2016-10-15', 'Cirurgia', '67890123456', '54156358531', '1');

ALTER TABLE Internacoes ADD COLUMN segundo_enfermeiro varchar(255);

UPDATE internacoes SET segundo_enfermeiro = '32598745886' WHERE id = '1';
UPDATE internacoes SET segundo_enfermeiro = '87456962455' WHERE id = '2';
UPDATE internacoes SET segundo_enfermeiro = '80748565505' WHERE id = '3';
UPDATE internacoes SET segundo_enfermeiro = '54156358531' WHERE id = '4';
UPDATE internacoes SET segundo_enfermeiro = '22145225458' WHERE id = '5';
UPDATE internacoes SET segundo_enfermeiro = '32598745886' WHERE id = '6';
UPDATE internacoes SET segundo_enfermeiro = '05148565505' WHERE id = '7';


