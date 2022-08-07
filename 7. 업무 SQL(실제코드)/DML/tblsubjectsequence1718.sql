select * from tblprocedureList;
select * from tblprocedureSubject;
select * from tblOpeningprocedure;
select * from tblpossiblesubject;

select * from tblsubjectschedule;


select * from tblopeningProcedure o 
    inner join tblprocedurelist l on o.procedurelist = l.procedurelistseq
        inner join tblproceduresubject s on l.procedurelistseq = s.procedureListSeq
            where o.openingprocedureseq =18;
            

select * from tblproceduresubject where procedurelistseq = 8;   --과정별 과목 번호
select * from tblpossiblesubject where subjectseq =3;

create SEQUENCE seqSubSchedule;
--17번
--insert into tblsubjectschedule values(seqSubSchedule.nextVal, to_date('2022-04-28','yyyy-mm-dd'), to_date('2022-05-28', 'yyyy-mm-dd'), 17, 10);
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-04-28'), to_date('2022-05-28'), 17, 10); --13
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-05-29'), to_date('2022-06-28'), 17, 44); --20
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-06-29'), to_date('2022-07-28'), 17, 19); --23
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-07-29'), to_date('2022-08-28'), 17, 14); --30
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-08-29'), to_date('2022-09-16'), 17, 14); --3
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-09-17'), to_date('2022-09-28'), 17, 5); --5
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-09-29'), to_date('2022-10-13'), 17, 11); --7



select * from tblopeningProcedure o 
    inner join tblprocedurelist l on o.procedurelist = l.procedurelistseq
        inner join tblproceduresubject s on l.procedurelistseq = s.procedureListSeq
            where o.openingprocedureseq =18;
            
select * from tblproceduresubject where procedurelistseq = 9;   --과정별 과목 번호
select * from tblpossiblesubject where subjectseq =7;

select * from tblsubjectschedule;

--18번
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-06-17'), to_date('2022-07-17'), 18, 23); --15
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-07-18'), to_date('2022-08-17'), 18, 33); --1
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-08-18'), to_date('2022-09-17'), 18, 4); --11
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-09-18'), to_date('2022-10-17'), 18, 31); --19
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-10-18'), to_date('2022-11-01'), 18, 56); --16
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-11-02'), to_date('2022-11-17'), 18, 61); --24
insert into tblsubjectschedule values(seqSubSchedule.nextVal,to_date('2022-11-18'), to_date('2022-11-28'), 18, 11); --7

commit;


