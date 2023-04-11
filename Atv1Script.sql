create table Produtos(
	
	id int primary key,
	Nome varchar(256),
	Preco int,
	Categoria varchar(56)

);

insert into Produtos values (166, 'Salgadinho', 20.00, 'Consumiveis'),
(244, 'Sapato', 149.99, 'Calcado'), (777, 'Camiseta', 49.99, 'Vestuario'),
(298, 'Pepsi', 3.99, 'Consumiveis');

select (nome, preco) from Produtos where categoria = 'Vestuario';

select * from Produtos where preco > 50;

insert into produtos values (3, 'Brigadeiro', 20, 'Consumiveis');

update produtos set preco = 89.99 where preco = 20; 

insert into produtos values (4,'Brinquedo', 200, 'Infantil');

delete from produtos where id = 4;


