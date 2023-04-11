create table Clientes(

	id int primary key,
	Nome varchar(256),
	Email varchar(500),
	Data_Nascimento date,
	Endereco varchar(600)

);

insert into Clientes values
	(1, 'Claudio', 'Claudio@gmail.com', '1989-03-24', 'Aguas claras'),
	(2, 'Rogerio', 'Rogerio@gmail.com', '2004-03-12', 'Asa norte'),
	(3, 'Arnaldo', 'Arnaldo@gmail.com', '2003-09-30', 'Asa sul'),
	(4, 'Ana', 'Ana@gmail.com', '1977-09-03', 'Ceilandia');
	

select * from clientes;

select (Nome, Email) from clientes where data_nascimnto < '1990-01-01';

insert into Clientes values
	(5, 'Pedro', 'Pedro@gmail.com', '2001-10-12', 'Rua 12 norte'),
	(6, 'Paulo', 'Paulo@gmail.com', '2007-07-22', 'Rua 4 sul');

select * from clientes where Endereco like '%Rua%';

update clientes set endereco = 'Rua 14 sul' where id = 2;

delete from clientes where id = 4;
