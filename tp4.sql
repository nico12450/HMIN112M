desc user_tables;

--afficher le nom des tables de la base
select table_name from user_tables;

--afficher les informations des tables sur lesquelles on a des droits
select table_name from user_catalog;

--afficher le nombre d'attributs de la table EMP
select count(*) from user_tab_columns where table_name = 'EMP';

--liste des contraintes créées par l'utilisateur
select * from user_constraints where table_name = 'EMP' or table_name = 'DEPT';

--informations sur les contraintes de clé primaire
select * from user_constraints where (table_name = 'EMP' and constraint_type = 'P') or (table_name = 'DEPT' and constraint_type = 'P';

grant select on EMP to jromieu;
grant update on DEPT to mfournel;

insert into mfournel.dept values (12,'NICOLAS','MONTPELLIER');