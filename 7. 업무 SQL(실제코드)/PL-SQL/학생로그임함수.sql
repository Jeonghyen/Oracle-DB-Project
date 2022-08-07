--학생로그임함수.sql
--아이디 > 학생번호, 아이디 > 수강신청번호 함수

--아이디 > 수강한 수강신청번호 출력
create or replace function fngetenrol(

 pid varchar2

 
)return number
is
venrolseq number;
begin
select enrolmentseq into venrolseq from tblenrolment
   where studentseq =
   (select studentseq from tblstudent where memberinfoseq = (select memberinfoseq from tblmemberinfo where id = pid))
    and enrolmentstateseq = 1;  --학생번호17

return venrolseq;
end;

--아이디> 학생번호 출력
create or replace function fnstudentSeq(

 pid varchar2

 
)return number
is
vstuseq number;
begin

   select studentseq into vstuseq from tblstudent where memberinfoseq = (select memberinfoseq from tblmemberinfo where id = pid);  --학생번호17

return vstuseq;
end;

commit;
--사용

select fngetenrol('vcxupitdap') from dual;
select fnstudentseq('vcxupitdap') from dual;
