--tblSubject 데이터


alter table tblSubject
    add constraint tblSubject_subjectName_uq unique (subjectName);
    
create sequence seqSubject;

insert into tblSubject values (seqSubject.nextVal, 'Java');
insert into tblSubject values (seqSubject.nextVal, 'C');
insert into tblSubject values (seqSubject.nextVal, 'C++');
insert into tblSubject values (seqSubject.nextVal, 'C#');
insert into tblSubject values (seqSubject.nextVal, 'Python');
insert into tblSubject values (seqSubject.nextVal, 'ANSI-SQL');
insert into tblSubject values (seqSubject.nextVal, 'mySQL');
insert into tblSubject values (seqSubject.nextVal, 'JDBC');
insert into tblSubject values (seqSubject.nextVal, 'Oracle Cloud');
insert into tblSubject values (seqSubject.nextVal, 'AWS');
insert into tblSubject values (seqSubject.nextVal, 'RDBMS');
insert into tblSubject values (seqSubject.nextVal, 'Git');
insert into tblSubject values (seqSubject.nextVal, 'HTML');
insert into tblSubject values (seqSubject.nextVal, 'CSS');
insert into tblSubject values (seqSubject.nextVal, 'JavaScript');
insert into tblSubject values (seqSubject.nextVal, 'jQuery');
insert into tblSubject values (seqSubject.nextVal, 'JSP');
insert into tblSubject values (seqSubject.nextVal, 'Spring');
insert into tblSubject values (seqSubject.nextVal, 'myBatis');
insert into tblSubject values (seqSubject.nextVal, 'R');
insert into tblSubject values (seqSubject.nextVal, 'Linux');
insert into tblSubject values (seqSubject.nextVal, 'Android');
insert into tblSubject values (seqSubject.nextVal, 'IOS');
insert into tblSubject values (seqSubject.nextVal, 'React');
insert into tblSubject values (seqSubject.nextVal, 'nodejs');
insert into tblSubject values (seqSubject.nextVal, 'TypeScript');
insert into tblSubject values (seqSubject.nextVal, 'Hadoop');
insert into tblSubject values (seqSubject.nextVal, 'ASP');
insert into tblSubject values (seqSubject.nextVal, 'PHP');
insert into tblSubject values (seqSubject.nextVal, 'RUBY');

--select * from tblSubject;
