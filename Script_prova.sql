	CREATE TABLE funcionarios (
	id_funcionarios INT,
	nome_funcionarios VARCHAR (50),
	salario_funcionarios DECIMAL (10,2),
	id_departamento INT,
	PRIMARY KEY (id_funcionarios),
	FOREIGN KEY (id_departamento) REFERENCES departamento (id_departamento)
	);

	INSERT INTO funcionarios (id_funcionarios, nome_funcionarios, salario_funcionarios, id_departamento)
	VALUES
	(1, 'João', 5000,1),
	(2, 'Maria', 6000,2),
	(3, 'Carlos', 5500,1),
	(4, 'Ana', 4500,2),
	(5, 'Paulo', 7000,3),
	(6, 'Lucia', 6500,2);

	CREATE TABLE departamento (
	id_departamento INT,
	nome_departamento VARCHAR (50),
	PRIMARY KEY (id_departamento) 
	);
	
	INSERT INTO departamento (id_departamento, nome_departamento)
	VALUES
	(1, 'Vendas'),
	(2, 'Marketing'),
	(3, 'TI'),
	(4, 'Estagiario'),
	(5, 'Financeiro'),
	(6, 'RH'),
	(7, 'Administração');
	
--Usando o UNION, 'ALL' pega todos os elementos da tabela
	SELECT nome_funcionarios, id_departamento FROM funcionarios f 
	WHERE id_departamento = 1 UNION 
	SELECT nome_departamento, id_departamento FROM departamento d;
--Selecionar o nome dos funcionarios e o nome do departamento, quando o id do departamento é 1	
	SELECT nome_funcionarios, nome_departamento FROM funcionarios f, departamento d
	WHERE f.id_departamento = d.id_departamento AND f.id_departamento = 1; 
--Selecionar o nome dos funcionarios e o nome do departamento, quando o id do departamento é 1, usando o INNER JOIN
	SELECT f.nome_funcionarios, d.nome_departamento FROM funcionarios f
	INNER JOIN departamento d ON f.id_departamento = d.id_departamento
	WHERE f.id_departamento = 1;
--Aparece todas as tabelas juntas e desalinhadas
	SELECT f.nome_funcionarios, d.nome_departamento FROM funcionarios f, departamento d
	WHERE f.id_departamento = 1;
--Outra maneira de escrever o código, é equivalente as outras maneiras, entretanto, se e somente se, o id do departamento d e do f estiverem iguais
	SELECT f.nome_funcionarios, d.nome_departamento FROM funcionarios f, departamento d
	WHERE f.id_departamento = 1 AND d.id_departamento = 1;
--Selecionar o id do departamento onde não há gente trabalhando
	SELECT d.id_departamento FROM departamento d 
	EXCEPT SELECT f.id_departamento FROM funcionarios f;
--Selecionar o nome do departamento onde não há gente trabalhando
	SELECT d.nome_departamento FROM departamento d, (SELECT d.id_departamento FROM departamento d 
	EXCEPT SELECT f.id_departamento FROM funcionarios f) d2
	WHERE d.id_departamento = d2.id_departamento;
--Criar a view onde o id do departamento que não há gente trabalhando
	CREATE VIEW depto_sem_func
	AS SELECT d.id_departamento FROM departamento d 
	EXCEPT SELECT f.id_departamento FROM funcionarios f;
--Selecionar o nome do departamento onde não há gente trabalhando, usando view
	SELECT d.nome_departamento FROM departamento d, depto_sem_func d2
	WHERE d.id_departamento = d2.id_departamento;
--Criar a view onde o nome do departamento que não há gente trabalhando
	CREATE VIEW nome_dept_sem_func 
	AS SELECT d.nome_departamento FROM departamento d, depto_sem_func d2
	WHERE d.id_departamento = d2.id_departamento;
--Selecionar o nome do departamento onde não há gente trabalhando, usando INNER JOIN
	SELECT d.nome_departamento FROM departamento d
	INNER JOIN (SELECT d.id_departamento FROM departamento d 
	EXCEPT SELECT f.id_departamento FROM funcionarios f) d2 
	ON d.id_departamento = d2.id_departamento;
--Selecionar o nome do departamento onde não há gente trabalhando, apenas com select
	SELECT d.nome_departamento, d.id_departamento FROM departamento d
	WHERE d.id_departamento NOT IN (SELECT f.id_departamento FROM funcionarios f);
--Selecionar o nome do departamento onde há gente trabalhando, apenas com select
	SELECT d.nome_departamento, d.id_departamento FROM departamento d
	WHERE d.id_departamento IN (SELECT f.id_departamento FROM funcionarios f);
--Selecionar todos os conteudos do departamento e dos funcionarios, usando o LEFT OUTER JOIN
--a tabela da esquerda terá os primeiros conteudos
	SELECT * FROM departamento d
	LEFT OUTER JOIN funcionarios f 
	ON d.id_departamento = f.id_departamento;
--Selecionar todos os conteudos do departamento e dos funcionarios, usando o LEFT OUTER JOIN
--a tabela da esquerda terá os primeiros conteudos, apenas os id de departamentos 'NULL'
	SELECT * FROM departamento d
	LEFT OUTER JOIN funcionarios f 
	ON d.id_departamento = f.id_departamento
	WHERE f.id_funcionarios IS NULL;
--Selecionar todos os conteudos do departamento e dos funcionarios, usando o RIGHT OUTER JOIN
--a tabela da direita terá os primeiros conteudos
	SELECT * FROM funcionarios f
	RIGHT OUTER JOIN departamento d 
	ON d.id_departamento = f.id_departamento;
--Selecionar todos os conteudos do departamento e dos funcionarios, usando o RIGHT OUTER JOIN
--a tabela da direita terá os primeiros conteudos, apenas os id de departamentos 'NULL'
	SELECT * FROM funcionarios f
	RIGHT OUTER JOIN departamento d 
	ON d.id_departamento = f.id_departamento
	WHERE f.id_funcionarios IS NULL;






