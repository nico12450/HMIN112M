--rlwrap sqlplus ngamel/nicolas@venus/master

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

--SCRIPT de creation et remplissage de tables

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_TERRITORY = AMERICA;

DROP TABLE EMP;
DROP TABLE DEPT;

CREATE TABLE EMP
       (NOM VARCHAR2(10),
	NUM NUMBER(5),
        FONCTION VARCHAR2(15),
        N_SUP NUMBER(5),
        EMBAUCHE DATE,
        SALAIRE NUMBER(7,2),
        COMM NUMBER(7,2),
        N_DEPT NUMBER(3));    

INSERT INTO EMP VALUES
        ('MARTIN',16712,'directeur',25717,'23-MAY-90',20000,NULL,30);
INSERT INTO EMP VALUES
        ('DUPONT',17574,'administratif',16712,'03-MAY-05',2000,NULL,30);
INSERT INTO EMP VALUES
        ('DUPOND',26691,'commercial',27047,'04-APR-08',2500,2500,20);
INSERT INTO EMP VALUES
        ('LAMBERT',25012,'administratif',27047,'14-APR-91',2200,NULL,20);
INSERT INTO EMP VALUES
        ('JOUBERT',25717,'president',NULL,'10-OCT-92',30000,NULL,30);
INSERT INTO EMP VALUES
        ('LEBRETON',16034,'commercial',27047,'01-JUN-99',3000,0,20);
INSERT INTO EMP VALUES
        ('MARTIN',17147,'commercial',27047,'10-DEC-73',1500,500,20);
INSERT INTO EMP VALUES
        ('PAQUEL',27546,'commercial',27047,'03-SEP-93',2000,300,20);
INSERT INTO EMP VALUES
        ('LEFEBVRE',25935,'commercial',27047,'11-JAN-04',2300,100,20);
INSERT INTO EMP VALUES
        ('GARDARIN',15155,'ingenieur',24533,'22-MAR-85',2400,NULL,10);
INSERT INTO EMP VALUES
        ('SIMON',26834,'ingenieur',24533,'04-OCT-88',2000,NULL,10);
INSERT INTO EMP VALUES
        ('DELOBEL',16278,'ingenieur',24533,'16-NOV-94',2000,NULL,10);
INSERT INTO EMP VALUES
        ('ADIBA',25067,'ingenieur',24533,'05-OCT-97',3000,NULL,10);
INSERT INTO EMP VALUES
        ('CODD',24533,'directeur',25717,'12-SEP-75',5500,NULL,100);
INSERT INTO EMP VALUES
        ('LAMERE',27047,'directeur',25717,'07-SEP-99',4500,NULL,20);
INSERT INTO EMP VALUES
	('BALIN',17232,'administratif',24533,'03-OCT-97',1300,NULL,10);
INSERT INTO EMP VALUES
	('BARA',24831,'administratif', 16712,'10-SEP-08',1500,NULL,30);

INSERT INTO EMP VALUES
	('BARAQ',24832,'commercial', 16712,'10-SEP-08',1500,NULL,30);

INSERT INTO EMP VALUES
	('BARACK',24833,'ingenieur', 16712,'10-SEP-08',1500,NULL,30);
--


CREATE TABLE DEPT
       (N_DEPT NUMBER(3),
        NOM VARCHAR2(14),
        LIEU VARCHAR2(13) );



INSERT INTO DEPT VALUES
        (10,'recherche','Rennes');
INSERT INTO DEPT VALUES (20,'vente','Metz');
INSERT INTO DEPT VALUES
        (30,'direction','Gif');
INSERT INTO DEPT VALUES
        (40,'fabrication','Toulon');

COMMIT;

--

DROP TABLE SALGRADE;

CREATE TABLE SALGRADE (
 GRADE               NUMBER,
 SALMIN              FLOAT,
 SALMAX              FLOAT);

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

ALTER TABLE DEPT ADD CONSTRAINT dept_pk primary key (n_dept);

ALTER TABLE SALGRADE ADD CONSTRAINT salgrade_pk primary key (Grade);

ALTER TABLE EMP ADD CONSTRAINT emp_pk primary key (num);

ALTER TABLE EMP ADD CONSTRAINT nom_u UNIQUE(nom);

ALTER TABLE EMP ADD CONSTRAINT responsable foreign key (n_sup) references EMP(num);

ALTER TABLE EMP ADD CONSTRAINT dept foreign key (n_dept) references DEPT(n_dept);

ALTER TABLE EMP ADD CONSTRAINT commission check((comm is not null and fonction = 'commercial') or (comm is null and fonction!='commercial'));

--select * from user_constraints where table_name = 'EMP';

ALTER TABLE EMP DISABLE CONSTRAINT commission;

ALTER TABLE EMP ENABLE CONSTRAINT commission;

DROP TABLE REJETS;
CREATE TABLE REJETS
(ROW_ID ROWID,
OWNER VARCHAR2(30),
TABLE_NAME VARCHAR2(30),
CONSTRAINT VARCHAR2(30));

alter table EMP enable constraint commission exceptions into REJETS;

