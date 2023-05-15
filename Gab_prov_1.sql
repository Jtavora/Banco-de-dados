create database teste;

create table Clientes(

	id_cliente int primary key,
	Nome varchar(256),
	Endereco varchar(600),
	telefone varchar(256)

);

create table Produtos(
	
	id_produto int primary key,
	Nome varchar(256),
	Preco int

);

CREATE TABLE funcionarios (
	
	id_funcionario int primary key,
	nome VARCHAR(50),
	cargo VARCHAR(50),
	salario DECIMAL
	
);

create table Pedidos(

	id_pedido int primary key,
	data_pedido date,
	cliente_id int references clientes(id_cliente),
	funcionario_id int references funcionarios(id_funcionario)

);

create table itens_de_pedidos(

	id_itens int primary key,
	pedido_id int references pedidos(id_pedido),
	produto_id int references produtos(id_produto),
	qunatidade int
	
);

insert into Clientes values
	(1, 'Claudio', 'Rua A', '7504-7501'),
	(2, 'Rogerio', 'Rua A', '9753-8903'),
	(3, 'Arnaldo', 'Asa sul', '3156-5657'),
	(4, 'Ana', 'Ceilandia', '2131-4567');

insert into Produtos values 
	(10, 'Computador', 1299.99),
	(20, 'Caneta', 2.99), 
	(30, 'Caderno', 49.99),
	(40, 'Grafite', 3.99);

insert into funcionarios values 
	(100, 'Roger', 'Gerente', 5200),
	(200, 'Andreia', 'Estagiaria', 750), 
	(300, 'Antonio', 'Caixa', 1200);

insert into Pedidos values 
	(111, '2022-12-03', 3, 200),
	(222, '2022-01-01', 2, 300), 
	(333, '2022-01-01', 1, 100),
	(444, '2022-12-07', 1, 200);

insert into itens_de_pedidos values 
	(1000, 111, 10, 3),
	(2000, 222, 20, 1), 
	(3000, 333, 30, 5),
	(4000, 444, 40, 2);

--1
select nome, preco from produtos p order by preco;

--2
select nome, preco from produtos p where preco > 1000

--3
insert into funcionarios values 
	(400, 'Paulo', 'Programador', 9000);
select nome, salario from funcionarios f where salario > 5000 order by salario;

--4
select c.nome, c.endereco from clientes c, pedidos p where c.id_cliente = p.cliente_id and data_pedido = '2022-01-01'; 

--5
select p.nome 
from clientes c, produtos p, pedidos p2, itens_de_pedidos idp  
where c.id_cliente = p2.cliente_id 
and idp.pedido_id = p2.id_pedido 
and idp.produto_id = p.id_produto  
and c.endereco = 'Rua A'; 

--6
insert into produtos values
	(50, 'Ouro', 10000),
	(60, 'Prata', 5000);

insert into Pedidos values 
	(555, '2022-12-03', 3, 200),
	(666, '2022-01-01', 2, 300);

insert into itens_de_pedidos values 
	(5000, 111, 50, 3),
	(6000, 222, 60, 1);
	
select c.nome 
from clientes c, produtos p, pedidos p2, itens_de_pedidos idp  
where c.id_cliente = p2.cliente_id 
and idp.pedido_id = p2.id_pedido 
and idp.produto_id = p.id_produto  
and p.preco > 2000 order by c.nome;

--7
select 'O vendedor '||f.nome||' foi responsavel pelo pedido '||p2.id_pedido||' realizado pelo cliente '||c.nome
from clientes c, produtos p, pedidos p2, itens_de_pedidos idp, funcionarios f 
where c.id_cliente = p2.cliente_id 
and idp.pedido_id = p2.id_pedido 
and idp.produto_id = p.id_produto
and p2.funcionario_id = f.id_funcionario; 

--8
select 'O vendedor '||f.nome||' vendeu produto '||p.nome ||' para o cliente '||c.nome
from clientes c, produtos p, pedidos p2, itens_de_pedidos idp, funcionarios f 
where c.id_cliente = p2.cliente_id 
and idp.pedido_id = p2.id_pedido 
and idp.produto_id = p.id_produto
and p2.funcionario_id = f.id_funcionario; 

--9
create view todos_vendedores as 
select f.id_funcionario from funcionarios f;

create view todos_pedidos as 
select p.funcionario_id from pedidos p;

create view vendedores_sem_vendas as
(select * from todos_vendedores) except (select * from todos_pedidos);

select 'O vendedor '||f.nome||' nao realizou nenuma venda.' from vendedores_sem_vendas vsv, funcionarios f
where f.id_funcionario = vsv.id_funcionario;

--10
create view todos_clientes as 
select c.id_cliente from clientes c;

create view todos_pedidos_clientes as 
select p.cliente_id from pedidos p;

create view clientes_sem_compras as
(select * from todos_clientes) except (select * from todos_pedidos_clientes);

select 'O cliente '||c.nome||' nao realizou nenhum pedido.' from clientes_sem_compras csc, clientes c 
where c.id_cliente = csc.id_cliente;