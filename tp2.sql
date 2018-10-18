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

alter table emp add constraint emp_pk primary key (num);

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

--


CREATE TABLE DEPT
       (N_DEPT NUMBER(3),
        NOM VARCHAR2(14),
        LIEU VARCHAR2(13) );

alter table dept add constraint emp_pk primary key (n_dept);

INSERT INTO DEPT VALUES
        (10,'recherche','Rennes');
INSERT INTO DEPT VALUES (20,'vente','Metz');
INSERT INTO DEPT VALUES
        (30,'direction','Gif');
INSERT INTO DEPT VALUES
        (40,'fabrication','Toulon');

COMMIT;

--requetes

--1
select nom, fonction, embauche from emp;

--2
select num, nom, salaire from emp where salaire <= 2000;

--3
select nom from emp where comm is not null order by comm desc;

--4
select nom, embauche from emp where embauche >= '01-JAN-91';

--5
select emp.nom, lieu from emp join dept on emp.N_DEPT = dept.N_DEPT;

--6
select e1.nom employe, e2.nom superieur from emp e1 join emp e2 on e1.N_SUP = e2.num;

--7
select nom from emp where fonction  = (select fonction from emp where nom = 'CODD');

--8
select nom, salaire from emp where salaire >= (select max(salaire) from emp where n_dept = 30);

--9
select e1.nom employe from emp e1 join emp e2 on e1.N_SUP = e2.num where e1.n_dept != e2.n_dept;

--10
select nom from emp where n_dept in (select n_dept from emp where embauche >= '01-JAN-98');

--11
select nom, fonction, salaire from emp where salaire in (select max(salaire) from emp);

--12
select n_dept, sum(salaire), count(nom), min(salaire), avg(salaire), max(salaire) from emp group by n_dept;

--13
drop view nbEmpDep;
create view nbEmpDep as select n_dept, count(*) nb from emp group by n_dept;
select distinct n_dept from emp where n_dept in (select n_dept from nbEmpDep where nb = (select max(nb) from nbEmpDep));

--14
select distinct n_dept from emp where n_dept not in (select n_dept from emp where fonction = 'ingenieur');

--15
--la vue renvoie l'ensemble des fonctions exercées par les employés des divers departements
drop view fonctionDept;
create view fonctionDept as select distinct fonction from emp;
select * from fonctionDept;


