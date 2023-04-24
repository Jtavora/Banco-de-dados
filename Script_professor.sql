create table alunos (
    id_aluno serial primary key,
    nome_aluno varchar(100) not null,
    cpf varchar(11) not null
);

create table disciplinas (
    id_disciplina serial primary key,
    nome_disciplina varchar(100) not null,
    carga_horaria int not null
);

create table notas (
    id_nota serial primary key,
    id_aluno int not null references alunos(id_aluno),
    id_disciplina int not null references disciplinas(id_disciplina),
    nota decimal(4,2) not null
);

-- os inserts deverão estar listados abaixo (e necessariamente deverão preencher dados suficientes nas tabelas de forma
-- que todas as queries deverão retornar valores nas queries). O que significa que para montar a versão final do script
-- vocês terão de retocar e refazer múltiplas vezes os insert into.

insert into alunos(nome_aluno, cpf) values
	('ana', '1'),
	('paulo', '2'),
	('carlos', '3'),
	('claudio', '4');

insert into disciplinas(nome_disciplina, carga_horaria) values
	('matemática', 60),
	('história', 50),
	('física', 70);

insert into notas(id_aluno, id_disciplina, nota) values
	(1, 1, 10),
	(1, 2, 5),
	(2, 1, 7);


-- 1.	selecione os alunos que tiraram nota maior ou igual a 7 na disciplina de “matemática”;

select a.nome_aluno
from alunos a, notas n, disciplinas d
where a.id_aluno = n.id_aluno
and n.id_disciplina = n.id_disciplina
and d.nome_disciplina ilike '%matemática%'
and n.nota >= 7.0;

-- 2.	lista o nome e o cpf dos alunos que não possuem notas cadastradas no sistema;

/*
para encadear as operações você pode criar view(s) para as operações. os resultados das views podem ser vistos como tabelas normais
na interface do dbeaver à esquerda (views) para fins de aprendizado, elas podem ajudar vocês a visualizar as operações passo a passo 
(em casos de operações com múltiplas etapas). cada vez que a tabela original for atualizada, ao visualizar a view, a mesma também será atualizada. 
ou seja, a view representa a operação nomeada em si, que é executada toda vez que a view é acessada
*/

create view id_todos_alunos as 
select a.id_aluno from alunos a;

create view id_alunos_com_notas as
select n.id_aluno from notas n;

create view alunos_sem_nota as
(select * from id_todos_alunos) except (select * from id_alunos_com_notas);

select a.nome_aluno, a.cpf
from alunos_sem_nota asn, alunos a
where asn.id_aluno = a.id_aluno;

/* fazendo como uma única operação... (há multiplas formas de nomear as operações na própria query) */
select a.nome_aluno, a.cpf
from alunos a, (select a.id_aluno from alunos a except select n.id_aluno from notas n) alunos_s_nota 
where a.id_aluno = alunos_s_nota.id_aluno;

-- 3.	selecione o nome das disciplinas que possuem carga horária maior que 60 horas;

select d.nome_disciplina
from disciplinas d
where d.carga_horaria > 60;

-- 4.	liste o nome das disciplinas e a média geral de notas dos alunos;

-- aqui utilizaremos uma função de agregação no meio das operações (a estilo da random, lower, dentre outras)
select d.nome_disciplina, avg(n.nota) -- o avg é a função de agregação
from disciplinas d, notas n 
where d.id_disciplina = n.id_disciplina
group by d.nome_disciplina; 
/* o group by é a função de agrupamento. ao utilizar o group by os unicos campos que podem aparecer no projeçã do select
 * são ou os campos de agrupamento ou campos onde aplicamos funções de agregação (como por exemplo o avg(n.nota))
 */

-- 5.	selecione o nome dos alunos que não possuem nota cadastrada na disciplina de “história”;

-- utilizaremos a view id_todos_alunos já criada anteriormente

create view id_alunos_com_notas_em_historia as
select n.id_aluno
from notas n, disciplinas d
where n.id_disciplina = d.id_disciplina 
and d.nome_disciplina like '%história%';

select * from id_todos_alunos except select * from id_alunos_com_notas_em_historia;


-- 6.	selecione o nome das disciplinas que possuem mais que 3 alunos cadastrados;

-- mais um exemplo de agrupamento com função de agregação

select d.nome_disciplina, count(n.id_nota)
from disciplinas d, notas n
where d.id_disciplina = n.id_disciplina
group by d.nome_disciplina;

-- 7.	liste o nome dos alunos e a média das notas obtidas em todas as disciplinas cadastradas.

-- mais um exemplo de agrupamento com função de agregação

select a.id_aluno, avg(n.nota)
from disciplinas d, notas n, alunos a 
where d.id_disciplina = n.id_disciplina 
and n.id_aluno = a.id_aluno
group by a.id_aluno
