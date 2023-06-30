# Hospital Princeton-Plainsboro: Banco de Dados
O pequeno hospital local, Princeton-Plainsboro, busca desenvolver um novo sistema que atenda melhor às suas necessidades. Atualmente, parte da operação ainda se apoia em planilhas e arquivos antigos, mas espera-se que esses dados sejam transferidos para o novo sistema assim que ele estiver funcional. Para isso, foram tomadas ações para fazer com que o sistema possa ser usado.

<div align="center">
<img src="https://github.com/gabrielaasouza/Hospital-Princeton-Plainsboro/blob/main/Hospital/Imagens/Hospital.png" width="70%"/>
</div>

## 🔹 Parte 1: Conhecendo as necessidades
O hospital necessita de um sistema para sua área clínica que ajude a controlar consultas realizadas. Os médicos podem ser generalistas, especialistas ou residentes e têm seus dados pessoais cadastrados em planilhas digitais. Cada médico pode ter uma ou mais especialidades, que podem ser pediatria, clínica geral, gastroenterologia e dermatologia. Alguns registros antigos ainda estão em formulário de papel, mas será necessário incluir esses dados no novo sistema.

Os pacientes também precisam de cadastro, contendo dados pessoais (nome, data de nascimento, endereço, telefone e e-mail), documentos (CPF e RG) e convênio. Para cada convênio, são registrados nome, CNPJ e tempo de carência.

As consultas também têm sido registradas em planilhas, com data e hora de realização, médico responsável, paciente, valor da consulta ou nome do convênio, com o número da carteira. Também é necessário indicar na consulta qual a especialidade buscada pelo paciente.

Deseja-se ainda informatizar a receita do médico, de maneira que, no encerramento da consulta, ele possa registrar os medicamentos receitados, a quantidade e as instruções de uso. A partir disso, espera-se que o sistema imprima um relatório da receita ao paciente ou permita sua visualização via internet.

<div align="center">
<img src="https://github.com/gabrielaasouza/Hospital-Princeton-Plainsboro/blob/main/Hospital/Imagens/Hospital-I.png"/>
</div>

## 🔹 Parte 2: Aprofundando nosso entendimento

No hospital, as internações têm sido registradas por meio de formulários eletrônicos que gravam os dados em arquivos. 

Para cada internação, são anotadas a data de entrada, a data prevista de alta e a data efetiva de alta, além da descrição textual dos procedimentos a serem realizados. Elas também precisam ser vinculadas a quartos, com a numeração e o tipo. 

Cada tipo de quarto tem sua descrição e o seu valor diário (a princípio, o hospital trabalha com apartamentos, quartos duplos e enfermaria).

Também é necessário controlar quais profissionais de enfermaria estarão responsáveis por acompanhar o paciente durante sua internação. Para cada enfermeiro(a), é necessário nome, CPF e registro no conselho de enfermagem (CRE).

A internação, obviamente, é vinculada a um paciente – que pode se internar mais de uma vez no hospital – e a um único médico responsável.

<div align="center">
<img src="https://github.com/gabrielaasouza/Hospital-Princeton-Plainsboro/blob/main/Hospital/Imagens/Hospital-II.png"/>
</div>

## 🔹 Parte 3: Povoando o banco.

Crie scripts de povoamento das tabelas desenvolvidas na atividade anterior
Observe as seguintes atividades: 
- Inclua ao menos dez médicos de diferentes especialidades.
- Ao menos sete especialidades (considere a afirmação de que “entre as especialidades há pediatria, clínica geral, gastrenterologia e dermatologia”).
- Inclua ao menos 15 pacientes.
- Registre 20 consultas de diferentes pacientes e diferentes médicos (alguns pacientes realizam mais que uma consulta). As consultas devem ter ocorrido entre 01/01/2015 e 01/01/2022. Ao menos dez consultas devem ter receituário com dois ou mais medicamentos.
- Inclua ao menos quatro convênios médicos, associe ao menos cinco pacientes e cinco consultas.
- Criar entidade de relacionamento entre médico e especialidade. 
- Criar Entidade de Relacionamento entre internação e enfermeiro. 
- Arrumar a chave estrangeira do relacionamento entre convênio e médico.
- Criar entidade entre internação e enfermeiro.
- Colocar chaves estrangeira dentro da internação (Chaves Médico e Paciente).
- Registre ao menos sete internações. Pelo menos dois pacientes devem ter se internado mais de uma vez. Ao menos três quartos devem ser cadastrados. As internações devem ter ocorrido entre 01/01/2015 e 01/01/2022.
- Considerando que “a princípio o hospital trabalha com apartamentos, quartos duplos e enfermaria”, inclua ao menos esses três tipos com valores diferentes.
- Inclua dados de dez profissionais de enfermaria. Associe cada internação a ao menos dois enfermeiros.
- Os dados de tipo de quarto, convênio e especialidade são essenciais para a operação do sistema e, portanto, devem ser povoados assim que o sistema for instalado.

As alterações podem ser vistas <a href='https://github.com/gabrielaasouza/Hospital-Princeton-Plainsboro/blob/main/Sistema%20do%20Hospital%20-%202.sql' alt='Link para o documento'>aqui</a>.

## 🔹 Parte 4: Alterações? Sim, por favor.

Pensando no banco que já foi criado para o Projeto do Hospital, realize algumas alterações nas tabelas e nos dados usando comandos de atualização e exclusão:
- Crie um script que adicione uma coluna “em_atividade” para os médicos, indicando se ele ainda está atuando no hospital ou não.
- Crie um script para atualizar ao menos dois médicos como inativos e os demais em atividade.

```
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
```

## 🔹 Parte 5: Alterações? Sim, por favor.
Todos os dados e o valor médio das consultas do ano de 2020 e das que foram feitas sob convênio.
```
SELECT AVG(valor) from consultas WHERE data_e_hora between '2020-01-01' AND '2020-12-31' AND convenio <= 4;
```
Todos os dados e o valor médio das consultas do ano de 2015 e das que foram feitas sob convênio.
```
SELECT AVG(valor) from consultas WHERE data_e_hora between '2015-01-01' AND '2015-12-31' AND convenio <= 4;
```
Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta.
```
SELECT * from internacoes WHERE data_prevista_de_alta < data_efetiva_de_alta;
```
Receituário completo da primeira consulta registrada com receituário associado.
```
SELECT * from receitas WHERE id = 1;
```
Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio).
```
INSERT INTO convenios (id, nome, cnpj, fim_da_carencia) VALUES (0, 'Sem convênio', '0', '0000-00-00');
UPDATE consultas SET convenio = '0' WHERE id = '10';

SELECT * from consultas ORDER BY valor DESC;
SELECT * from consultas ORDER BY valor ASC;

UPDATE consultas set convenio = '0' WHERE valor = '150';

SELECT * from consultas WHERE convenio = 0 ORDER BY valor DESC;
```
Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta.
```
SELECT *, DATEFIFF(data_efetiva_de_alta, data_de_entrada) dias_internados, quarto.valor_diario, DATEDIFF(data_efetiva_de_alta, data_de_entrada) * tipos.valor_diario valor_total FROM Internacoes INNER JOIN Quartos on Internacoes.quarto = Quartos.id INNER JOIN quartos on quartos.id = quartos.id_tipo;
```
Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”.
```
SELECT * from quartos WHERE tipo = 'apartamento';
SELECT data_de_entrada, procedimentos, quarto from internacoes WHERE quarto = '1';
```
Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta.
```
SELECT p.cpf, c.data_e_hora, e.especialidade FROM Consultas c INNER JOIN Pacientes p on p.cpf = c.paciente INNER JOIN Especialidades e on e.id = c.especialidade WHERE c.especialidade <> 1 AND YEAR(c.data_e_hora) - year(p.data_de_nascimento) < 19 AND YEAR (c.data_e_hora) - YEAR(p.data_de_nascimento) > 0 ORDER BY c.data_e_hora;
```
Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadaspor médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.
```
SELECT p.nome, m.cpf, i.data_de_entrada, i.procedimentos, q.id FROM internacoes i INNER JOIN Medicos m on m.cpf  = i.medico INNER JOIN Pacientes p on p.cpf = i.paciente INNER JOIN Quartos q on q.id = i.quarto WHERE q.tipo = 3 AND m.especialidade = 7;
```
Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou.
```
SELECT m.nome, count(m.cpf) as 'Quantidade de consultas' FROM Medicos m INNER JOIN Consultas c on c.medico = m.cpf GROUP BY m.cpf;
```
Todos os médicos que tenham "Gabriel" no nome.
```
INSERT INTO Medicos (nome, cpf, crm, rg, categoria, especialidade) VALUES
('Gabriel Cenoura', '66614678900', 'CRM124256', 'RG644221', '1', '1');
SELECT * from Medicos WHERE nome LIKE '%Gabriel%';
```
Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação.
```
SELECT enf.nome, enf.cre, COUNT(enf.cpf) as Participacao FROM enfermeiros enf INNER JOIN internacoes i on i.enfermeiro = enf.cpf GROUP BY enf.cpf HAVING Participacao > 1;
```
