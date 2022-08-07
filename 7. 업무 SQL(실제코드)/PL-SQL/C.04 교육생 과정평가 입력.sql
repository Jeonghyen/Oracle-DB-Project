--C.04 교육생 과정평가 입력.sql

create or replace procedure procRate(
pratenum number,
pcontent varchar2,
pid varchar2
)
is 
vopeningseq number;
venddate date;
venrol number;
vcount number ;
begin    
select openingprocedureseq
into vopeningseq
from tblenrolment where enrolmentseq = fngetenrol(pid);

select procedureend into venddate
from tblopeningprocedure
where openingprocedureseq = (select openingprocedureseq
from tblenrolment where enrolmentseq =fngetenrol(pid) and tblenrolment.enrolmentstateseq = 1);

select count(*) into vcount from tblprocedureRate where enrolmentseq = fngetenrol(pid);

if vcount = 0 then
if to_char(venddate) < to_char(sysdate) then
insert into tblprocedurerate values (seqRate.nextVal, sysdate, pratenum, pcontent, fngetenrol(pid), vopeningseq );
else
dbms_output.put_line('수강중인 과정이 아직 수료 전입니다.');
end if;
else 
dbms_output.put_line('과정평가 내역이 이미 존재합니다.');
end if;

end;

--실행
--평점,내용,아이디
begin
    procrate(5, '좋아요', 'xklhqjwzvv');
end;