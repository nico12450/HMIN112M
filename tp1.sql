--suppression des tables

drop table fournisseurs;
drop table prix;
drop table commandes;
drop table clients;

--creation d'une base
--create database if not exists ma_base;

--creation des tables

create table fournisseurs(nomF varchar(20) not null, adresseF varchar(50));
create table prix(nomF varchar(20) not null, nomP varchar(20), cout integer);
create table commandes(nCom integer not null, nomC varchar(20) not null, nomP varchar(20), qte integer);
create table clients(nomC varchar(20) not null, adresseC varchar(20), solde integer);

--ajout des contraintes

--ajout des clés primaires

--alter table fournisseurs add constraint fournisseurs_NotNull not null (nomF);
alter table fournisseurs add constraint fournisseurs_pk primary key (nomF);
--alter table prix add constraint prix_NotNull not null (nomF);
--alter table prix add constraint prix_NotNull2 not null (nomP);
alter table prix add constraint prix_pk primary key (nomF,nomP);
--alter table commandes add constraint commandes_notNull not null(nCom);
alter table commandes add constraint commandes_pk primary key (nCom);
--alter table clients add constraint clients_notNull not null (nomC)
alter table clients add constraint clients_pk primary key (nomC);

--autres contraintes

alter table prix add constraint coutPositif check (cout>0);
--alter table commandes add constraint clientUnique unique (nomC);
--alter table commandes add constraint vraiClient check (nomC in (select nomC from clients));
alter table commandes add constraint clientFK foreign key (nomC) references clients(nomC); 
alter table commandes add constraint nbCommandesPositif check (qte>0);

--script moodle pour remplir la table

------------------------------FOURNISSEURS-------------------------------------

insert into fournisseurs values ('Abounayan', '92190 Meudon');
insert into fournisseurs values ('Cima','75010 Paris');
insert into fournisseurs values ('Preblocs','92230 Genevilliers');
insert into fournisseurs values ('Samaco','75116 Paris');

-----------------------------PRIX----------------------------------------------

insert into prix values ('Abounayan', 'sable',300);
insert into prix values ('Abounayan', 'brique',1500);
insert into prix values ('Abounayan', 'parpaing',1150);
insert into prix values ('Preblocs','tuile',1150);
insert into prix values ('Preblocs','parpaing',1200);
insert into prix values ('Samaco','parpaing',1150);
insert into prix values ('Samaco','ciment',125);
insert into prix values ('Samaco','brique',1200);

------------------------------CLIENTS--------------------------------------------
insert into clients values ('jean','75006 Paris',-12000);
insert into clients values ('paul','75003 Paris',0);
insert into clients values ('vincent','94200 Ivry',3000);
insert into clients values ('pierre','92400 Courbevoie',7000);

-----------------------------COMMANDES-------------------------------------------
insert into commandes values (1,'jean','brique',5);
insert into commandes values (2,'jean','ciment',1);
insert into commandes values (3,'paul','brique',3);
insert into commandes values (4,'paul','parpaing',9);
insert into commandes values (5,'vincent','parpaing',7);


--consultation

select * from fournisseurs;
select * from prix;
select * from commandes;
select * from clients;

select nomC from clients where solde<0;

select nomF from fournisseurs;

select distinct nomF from prix where nomP = 'briques' or nomP = 'parpaing';

select nomC,adresseC from clients where nomC like 'j%';

select distinct cl.nomC, cl.adresseC from clients cl join commandes co on cl.nomC = co.nomC where co.nomP = 'brique' and co.qte >= 5 and co.qte <= 10; 

select nomP, AVG(cout) from prix group by nomP;



--insertion

insert into commandes (nCom,nomC,nomP,qte) values (6,'paul','ciment',12);

update Clients set adresseC = '83000 Toulon' where nomC = 'jean';

update prix set cout = cout * 1.15 where nomF = 'Samaco';

update fournisseurs set nomF = 'Technal', adresseF = '69005 Lyon' where nomF = 'Samaco';

 



