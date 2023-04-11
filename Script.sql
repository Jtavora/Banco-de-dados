create table produtos (
	id int primary key,
	nome varchar(255),
	preco decimal,
	categoria varchar(50)
);

create database teste;

drop database teste;

drop table produtos;

insert into produtos values (244,'Maca',2.55,'frutas'), 
(45,'Cana de açucar',20.99,'frutas'), (322,'Banana',2.90,'frutas'), (
89,'Goiaba',4.99,'frutas');


