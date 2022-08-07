--tblWrittenScore데이터

select * from tblTest;
select * from tblenrolment;
select * from tbltype;
select * from tblopeningprocedure;

select * from tblenrolment where enrolmentseq = 75;

select t.testseq, e.studentseq, o.openingprocedureseq, s.subjectscheduleseq,s.subjectend, e.enrolmentseq, e.enrolmentstateseq
from  tblopeningprocedure o
    inner join tblsubjectschedule s 
        on o.openingprocedureseq = s.openingprocedureseq
            inner join tblenrolment e on o.openingprocedureseq = e.openingprocedureseq
             inner join tblTest t on t.subjectscheduleseq = s.subjectscheduleseq
                where t.typeseq = 2 and o.openingprocedureseq in (11,15) and e.studentseq in (5, 8, 10, 13, 22,17, 20, 21, 23,26) and e.enrolmentstateseq =1
                    and t.testseq not between 61 and 69
                    order by t.testseq;
                    
select * from tbltest where typeseq = 2 order by testseq;

select * from tblwrittenscore;


create sequence seqWritten;
insert into tblWrittenScore values(seqWritten.nextVal, 1, 1, '90');
insert into tblWrittenScore values(seqWritten.nextVal, 1, 23, '96');
insert into tblWrittenScore values(seqWritten.nextVal, 1, 22, '97');
insert into tblWrittenScore values(seqWritten.nextVal, 1, 21, '91');
insert into tblWrittenScore values(seqWritten.nextVal, 1, 2, '80');

insert into tblWrittenScore values(seqWritten.nextVal, 3, 1, '80');
insert into tblWrittenScore values(seqWritten.nextVal, 3, 23, '96');
insert into tblWrittenScore values(seqWritten.nextVal, 3, 22, '99');
insert into tblWrittenScore values(seqWritten.nextVal, 3, 21, '70');
insert into tblWrittenScore values(seqWritten.nextVal, 3, 2, '80');


insert into tblWrittenScore values(seqWritten.nextVal, 5, 1, '80');
insert into tblWrittenScore values(seqWritten.nextVal, 5, 23, '76');
insert into tblWrittenScore values(seqWritten.nextVal, 5, 22, '97');
insert into tblWrittenScore values(seqWritten.nextVal, 5, 21, '91');
insert into tblWrittenScore values(seqWritten.nextVal, 5, 2, '70');


insert into tblWrittenScore values(seqWritten.nextVal, 7, 1, '80');
insert into tblWrittenScore values(seqWritten.nextVal, 7, 23, '55');
insert into tblWrittenScore values(seqWritten.nextVal, 7, 22, '60');
insert into tblWrittenScore values(seqWritten.nextVal, 7, 21, '51');
insert into tblWrittenScore values(seqWritten.nextVal, 7, 2, '60');


insert into tblWrittenScore values(seqWritten.nextVal, 9, 1, '50');
insert into tblWrittenScore values(seqWritten.nextVal, 9, 23, '96');
insert into tblWrittenScore values(seqWritten.nextVal, 9, 22, '80');
insert into tblWrittenScore values(seqWritten.nextVal, 9, 21, '82');
insert into tblWrittenScore values(seqWritten.nextVal, 9, 2, '86');



insert into tblWrittenScore values(seqWritten.nextVal, 11, 1, '90');
insert into tblWrittenScore values(seqWritten.nextVal, 11, 23, '40');
insert into tblWrittenScore values(seqWritten.nextVal, 11, 22, '50');
insert into tblWrittenScore values(seqWritten.nextVal, 11, 21, '60');
insert into tblWrittenScore values(seqWritten.nextVal, 11, 2, '70');



insert into tblWrittenScore values(seqWritten.nextVal, 13, 1, '80');
insert into tblWrittenScore values(seqWritten.nextVal, 13, 23, '96');
insert into tblWrittenScore values(seqWritten.nextVal, 13, 22, '100');
insert into tblWrittenScore values(seqWritten.nextVal, 13, 21, '100');
insert into tblWrittenScore values(seqWritten.nextVal, 13, 2, '100');



--15번과정


insert into tblWrittenScore values(seqWritten.nextVal, 57, 5, '50');
insert into tblWrittenScore values(seqWritten.nextVal, 57, 6, '60');
insert into tblWrittenScore values(seqWritten.nextVal, 57, 3, '70');
insert into tblWrittenScore values(seqWritten.nextVal, 57, 4, '80');
insert into tblWrittenScore values(seqWritten.nextVal, 57, 42, '90');


insert into tblWrittenScore values(seqWritten.nextVal, 59, 95, '100');
insert into tblWrittenScore values(seqWritten.nextVal, 59, 6, '90');
insert into tblWrittenScore values(seqWritten.nextVal, 59, 3, '80');
insert into tblWrittenScore values(seqWritten.nextVal, 59, 4, '80');
insert into tblWrittenScore values(seqWritten.nextVal, 59, 42, '70');


select * from tblwrittenscore order by testseq;
commit;
select * from tblpracticalScore order by testseq;