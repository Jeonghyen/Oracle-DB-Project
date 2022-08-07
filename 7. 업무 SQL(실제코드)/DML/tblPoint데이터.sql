
alter table tblPoint add subjectScheduleSeq number not null;

alter table tblPoint
    add constraint tblPoint_subjectScheduleSeq_fk foreign key(subjectScheduleSeq) references tblSubjectSchedule(subjectScheduleSeq);
    


--tblPoint 데이터


create sequence seqPoint;
create sequence seqPoint2 start with 15;
create sequence seqSub2 start with 17;
select seqSub2.currVal from dual;

select * from tblPoint;
desc tblPoint;
select * from tblsubjectschedule order by subjectend , subjectScheduleSeq; --26번까지

insert into tblPoint values (seqPoint2.nextVal, '20','50','30',45);

commit;
delete from tblPoint where pointSeq = 14;







