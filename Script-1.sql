CREATE TABLE departamento (
	id_departamento INT,
	nome_departamento VARCHAR (50),
	PRIMARY KEY (id_departamento) 
	);
	
INSERT INTO departamento (id_departamento, nome_departamento)
	VALUES
	(1, 'Vendas'),
	(2, 'Marketing'),
	(3, 'TI');

CREATE TABLE funcionarios (
	id_funcionarios INT,
	nome_funcionarios VARCHAR (50),
	salario_funcionarios DECIMAL (10,2),
	id_departamento INT,
	PRIMARY KEY (id_funcionarios),
	FOREIGN KEY (id_departamento) REFERENCES departamento (id_departamento)
	);
order by f.salario_funcionarios, f.nome_funcionarios
INSERT INTO funcionarios (id_funcionarios, nome_funcionarios, salario_funcionarios, id_departamento)
	VALUES
	(1, 'João', 5000,1),
	(2, 'Maria', 6000,2),
	(3, 'Carlos', 5500,1),
	(4, 'Ana', 4500,2),
	(5, 'Paulo', 7000,3),
	(6, 'Lucia', 6500,2);

SELECT substring(nome_funcionarios, generate_series(1, length(nome_funcionarios)), 1) AS character
FROM funcionarios;

create table t10(id int primary key);	
insert into t10(id) values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

select nome_funcionarios from funcionarios f where nome_funcionarios = 'Carlos';
select id as pos from t10;

select nome_funcionarios, iter.pos
from (select nome_funcionarios from funcionarios where nome_funcionarios = 'Carlos') func,
	(select id as pos from t10) iter;

select nome_funcionarios, iter.pos
from (select nome_funcionarios from funcionarios where nome_funcionarios = 'Carlos') func,
	(select id as pos from t10) iter
where iter.pos <= length(func.nome_funcionarios);

select substring(nome_funcionarios, iter.pos, 1) 
from (select nome_funcionarios from funcionarios where nome_funcionarios = 'Carlos') func,
	(select id as pos from t10) iter
where iter.pos <= length(func.nome_funcionarios);

SELECT REPLACE(cast(salario_funcionarios as char(7)), '.', ',') AS campo_modificado
FROM funcionarios;

select nome_funcionarios || ' ' || REPLACE(cast(salario_funcionarios as char(7)), '.', ',') as dados_fake
from funcionarios;

select translate(a.dados_fake, '0123456789', '0')
from(
	select nome_funcionarios || ' ' || REPLACE(cast(salario_funcionarios as char(7)), '.', ',') as dados_fake
from funcionarios) a;

select * from generate_series(1,5);


create table tabela_ips (ip varchar(15) primary key);

insert into tabela_ips(ip)
select ((random() * 256 - 1)::int || '.' ||
		(random() * 256 - 1)::int || '.' ||
		(random() * 256 - 1)::int || '.' ||
		(random() * 256 - 1)::int)
from generate_series(1,5);

--Cria tabela já inserindo valores
create table tab_ip as
select ((random() * 256 - 1)::int || '.' ||
		(random() * 256 - 1)::int || '.' ||
		(random() * 256 - 1)::int || '.' ||
		(random() * 256 - 1)::int)
from generate_series(1,5);

select ip, split_part(ip, '.', 1) as ip_parte1
from tabela_ips ti;

select ip, 
	split_part(ip, '.', 1) as ip_parte1,
	split_part(ip, '.', 2) as ip_parte2,
	split_part(ip, '.', 3) as ip_parte3,
	split_part(ip, '.', 4) as ip_parte4
from tabela_ips;

select ip, 
	split_part(ip, '.', 1) as ip_parte1,
	split_part(ip, '.', 2) as ip_parte2,
	split_part(ip, '.', 3) as ip_parte3,
	split_part(ip, '.', 4) as ip_parte4
from (
	select ((random() * 256 - 1)::int || '.' ||
	(random() * 256 - 1)::int || '.' ||
	(random() * 256 - 1)::int || '.' ||
	(random() * 256 - 1)::int) as ip
from generate_series(1,5)) tab_teste;

select d.nome_departamento, avg(salario_funcionarios)::decimal(10,2)
from funcionarios f, departamento d
where f.id_departamento = d.id_departamento 
group by d.id_departamento;

select d.nome_departamento, max(f.salario_funcionarios), min(f.salario_funcionarios) 
from funcionarios f, departamento d
where f.id_departamento = d.id_departamento 
group by d.id_departamento;order by f.salario_funcionarios, f.nome_funcionarios

select d.nome_departamento, max(f.salario_funcionarios), min(f.salario_funcionarios), sum(f.salario_funcionarios) 
from funcionarios f, departamento d
where f.id_departamento = d.id_departamento 
group by d.id_departamento;

select d.nome_departamento, max(f.salario_funcionarios), min(f.salario_funcionarios), 
sum(f.salario_funcionarios) , count(f.nome_funcionarios)
from funcionarios f, departamento d
where f.id_departamento = d.id_departamento 
group by d.id_departamento;

--Soma acumulativas
select f.nome_funcionarios, f.salario_funcionarios, 
	sum(f.salario_funcionarios) over(order by f.salario_funcionarios, f.nome_funcionarios) as sal_acumulado
from funcionarios f;

SELECT d.nome_departamento, f.salario_funcionarios,
       SUM(f.salario_funcionarios) OVER (PARTITION BY d.id_departamento 
ORDER BY f.salario_funcionarios ASC) as valor_acumulado
FROM funcionarios f
INNER JOIN departamento d ON f.id_departamento = d.id_departamento;

--Incremennta o mes das datas
select 
 (('2020-01-01')::date + interval '1 month' * generate_series)::date as periodo,
 (random() * 10000)::int as vendas
 from generate_series(1, 24);

select periodo, vendas,
	lag(vendas, 1) over (order by periodo) as vendas_ultimo1,
	lag(vendas, 2) over (order by periodo) as vendas_ultimo2,
	(vendas + lag(vendas, 1) over(order by periodo)
			+ lag(vendas, 2) over(order by periodo)) as media_movel
from vendas;


 









	
	