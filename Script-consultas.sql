USE hospital;

-- Todos os dados e o valor médio das consultas do ano de 2020 e das que foram feitas sob convênio.

SELECT AVG(valor) from consultas WHERE data_e_hora between '2020-01-01' AND '2020-12-31' AND convenio <= 4;

-- Todos os dados e o valor médio das consultas do ano de 2015 e das que foram feitas sob convênio.

SELECT AVG(valor) from consultas WHERE data_e_hora between '2015-01-01' AND '2015-12-31' AND convenio <= 4;

-- Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta.

SELECT * from internacoes WHERE data_prevista_de_alta < data_efetiva_de_alta;

-- Receituário completo da primeira consulta registrada com receituário associado.

SELECT * from receitas WHERE id = 1;

-- Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio).

INSERT INTO convenios (id, nome, cnpj, fim_da_carencia) VALUES (0, 'Sem convênio', '0', '0000-00-00');
UPDATE consultas SET convenio = '0' WHERE id = '10';

SELECT * from consultas ORDER BY valor DESC;
SELECT * from consultas ORDER BY valor ASC;

UPDATE consultas set convenio = '0' WHERE valor = '150';

SELECT * from consultas WHERE convenio = 0 ORDER BY valor DESC;

-- Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir 
-- do valor de diária do quarto e o número de dias entre a entrada e a alta.
SELECT *, DATEFIFF(data_efetiva_de_alta, data_de_entrada) dias_internados, quarto.valor_diario, DATEDIFF(data_efetiva_de_alta, data_de_entrada) * tipos.valor_diario valor_total FROM Internacoes INNER JOIN Quartos on Internacoes.quarto = Quartos.id INNER JOIN quartos on quartos.id = quartos.id_tipo;

-- Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”.
SELECT * from quartos WHERE tipo = 'apartamento';
SELECT data_de_entrada, procedimentos, quarto from internacoes WHERE quarto = '1';

-- Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes 
-- eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, 
-- ordenando por data de realização da consulta.
SELECT p.cpf, c.data_e_hora, e.especialidade FROM Consultas c INNER JOIN Pacientes p on p.cpf = c.paciente INNER JOIN Especialidades e on e.id = c.especialidade WHERE c.especialidade <> 1 AND YEAR(c.data_e_hora) - year(p.data_de_nascimento) < 19 AND YEAR (c.data_e_hora) - YEAR(p.data_de_nascimento) > 0 ORDER BY c.data_e_hora;

-- Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas
-- por médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.
SELECT p.nome, m.cpf, i.data_de_entrada, i.procedimentos, q.id FROM internacoes i INNER JOIN Medicos m on m.cpf  = i.medico INNER JOIN Pacientes p on p.cpf = i.paciente INNER JOIN Quartos q on q.id = i.quarto WHERE q.tipo = 3 AND m.especialidade = 7;

-- Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou.
SELECT m.nome, count(m.cpf) as 'Quantidade de consultas' FROM Medicos m INNER JOIN Consultas c on c.medico = m.cpf GROUP BY m.cpf;

-- Todos os médicos que tenham "Gabriel" no nome.
INSERT INTO Medicos (nome, cpf, crm, rg, categoria, especialidade) VALUES
('Gabriel Cenoura', '66614678900', 'CRM124256', 'RG644221', '1', '1');
SELECT * from Medicos WHERE nome LIKE '%Gabriel%';

-- Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação.
SELECT enf.nome, enf.cre, COUNT(enf.cpf) as Participacao FROM enfermeiros enf INNER JOIN internacoes i on i.enfermeiro = enf.cpf GROUP BY enf.cpf HAVING Participacao > 1;
