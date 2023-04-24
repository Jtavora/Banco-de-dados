CREATE TABLE funcionarios (
nome VARCHAR(50),
cargo VARCHAR(50),
salario DECIMAL(10, 2)
);

INSERT INTO funcionarios(nome, cargo, salario)
VALUES
('Ana Maria', 'RH', 3500.00),
('Carlos Souza', 'Analista de Sistemas', 4500.00),
('Mariana Lima', 'Assistente Administrativo', 2800.00),
('Fernando Santos', 'Coordenador de Vendas', 6500.00),
('Juliana Costa', 'Desenvolvedor Web', 5500.00),
('Lucas Ferreira', 'Designer Grafico', 4000.00),
('Livia Oliveira', 'Gerente de Marketing', 8000.00),
('Rafaela Rodrigues', 'Analista Financeiro', 6000.00),
('Thiago Alves', 'Gerente de Projetos', 7500.00),
('Vinicius Silva', 'Desenvolvedor Mobile', 5000.00);

select * from funcionarios;

drop table funcionarios;

select nome|| 'trabalha como ' ||cargo as nome_cargo from funcionarios;

select nome from funcionarios limit 2;

select nome from funcionarios order by random() limit 3;

select * from funcionarios where cargo like 'desenvolvedores%';
select * from funcionarios where upper(cargo) like upper('desenvolvedores%');
select * from funcionarios where cargo ilike 'desenvolvedores%';

select * from funcionarios order by nome asc;
select * from funcionarios order by salario desc;
select * from funcionarios order by cargo desc, salario asc;


