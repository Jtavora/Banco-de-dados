create database Escola;

create table Alunos(
	ID_Aluno int primary key,
	Nome_aluno varchar(256),
	CPF varchar(50) 
);

create table Disciplinas(
	ID_Disciplina int primary key,
	Nome_Disciplina varchar(256),
	Carga_Horaria int
);

create table Notas(
	ID_Nota int primary key,
	ID_Aluno int,
	foreign key (ID_Aluno) references Alunos(ID_Aluno),
	ID_Disciplina int,
	foreign key (ID_Disciplina) references Disciplinas(ID_Disciplina),
	Notas decimal
);

insert into alunos 
	values
	(1, 'João Távora', '123.456.345-01'),
	(2, 'Petrus wave', '445.667.908-31'),
	(3, 'Gabriel Cunha', '789.456.990.21'),
	(4, 'Rafael Nogueira', '444.567.331-90'),
	(5, 'Kelvin Pimentel', '881.445.678-31');

insert into disciplinas  
	values
	(100, 'História', 60),
	(101, 'Matemática', 75);

insert into notas 
	values
	(200, 1, 100, 9.5),
	(201, 2, 100, 7.5),
	(202, 2, 101, 9.5),
	(203, 3, 101, 4.5),
	(204, 4, 100, 3.2),
	(205, 5, 100, 7.5),
	(206, 5, 101, 5.5);

UPDATE disciplinas  
SET nome_disciplina  = 'Matemática'
WHERE id_disciplina = 101;


select *
from alunos a, disciplinas d, notas n
where n.ID_Disciplina = d.id_disciplina
and a.id_aluno  = N.id_aluno
and n.notas >= 7
and d.nome_disciplina ilike '%matemática%';

