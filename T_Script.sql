	CREATE TABLE ALUNOS (
	id_aluno INT,
	nome_aluno VARCHAR(50),
	cpf VARCHAR(50),
	PRIMARY KEY (id_aluno)
);

	CREATE TABLE DISCIPLINAS (
	id_disciplina INT,
	nome_disciplina VARCHAR (50),
	carga_horaria INT,
	PRIMARY KEY (id_disciplina)
);

	CREATE TABLE NOTAS (
	id_nota INT,
	id_aluno INT,
	id_disciplina INT,
	nota DECIMAL (10,2),
	PRIMARY KEY (id_nota),
	FOREIGN KEY (id_aluno) REFERENCES ALUNOS (id_aluno),
	FOREIGN KEY (id_disciplina) REFERENCES DISCIPLINAS (id_disciplina)
); 	
	select * from alunos a, notas n, disciplinas d
	where a.id_aluno=n.id_aluno and n.id_disciplina=d.id_disciplina
	and n.nota >= 7 and d.id_disciplina = 1;

	select * from NOTAS n, alunos a
	where a.id_aluno = n.id_aluno and n.nota is null;

	select * from DISCIPLINAS where carga_horaria > 60;

	select avg (nota) media_nota from NOTAS n, alunos a, disciplinas d
	where a.id_aluno = n.id_aluno and n.id_disciplina = d.id_disciplina 
	and n.nota is not null;
	
	select * from NOTAS n, alunos a, disciplinas d
	where a.id_aluno = n.id_aluno and n.id_disciplina = d.id_disciplina
	and n.nota is null and d.id_disciplina = 2;

	select count (n.id_disciplina) pessoas_cadastradas from notas n, alunos a, disciplinas d 
	where a.id_aluno = n.id_aluno and n.id_disciplina = d.id_disciplina;
	
	select * from NOTAS where id_nota not null = (id_nota/2), id_aluno;

	INSERT INTO ALUNOS (id_aluno, nome_aluno, cpf)
	VALUES
	(1, 'Gabriela', '148.419.126-90'),
	(2, 'Santana', '142.419.126-90'),
	(3, 'Tigas', '148.413.126-90');

	INSERT INTO DISCIPLINAS (id_disciplina, nome_disciplina, carga_horaria)
	VALUES
	(1, 'Matematica', 80),
	(2, 'Historia', 40),
	(3, 'Fisica', 120);

	INSERT INTO NOTAS (id_nota, id_aluno, id_disciplina, nota)
	VALUES
	(1, 1, 1, 10),
	(2, 1, 2, 7),
	(3, 1, 3, 8),
	(4, 2, 1, 5),
	(5, 2, 2, 10),
	(6, 2, 3, 8),
	(7, 3, 1, 8),
	(8, 3, 2, NULL);
	