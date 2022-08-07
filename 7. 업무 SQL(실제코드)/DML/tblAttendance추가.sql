select * from tblenrolment;
select * from tblopeningprocedure;
select * from tblenrolmentstate;

--출결 정보 있어야 할 학생들
select * from tblEnrolment where enrolmentstateseq =1 and openingprocedureseq <> 18;

/*
create table tblAttendance (
   attendanceSeq number not null primary key, -- 출결 번호(PK)
   enrolmentSeq number not null references tblEnrolment(enrolmentSeq),-- 수강신청 번호(FK)
   inTime VARCHAR2(30) null,-- 출근 시각
   outTime VARCHAR2(30) null,-- 퇴근 시각
   attendanceStateSeq number null references tblAttendanceState(attendanceStateSeq),-- 근태사항 번호(FK)
  attendancedate date not null -- 날짜
);
*/

select * from tblenrolment;
                
 select p.procedurestart, p.procedureend, e.enrolmentseq, e.completedate, e.enrolmentstateseq, e.studentseq
        from tblopeningprocedure  p inner join tblEnrolment e
            on p.openingprocedureSeq = e.openingprocedureSeq 
                where e.enrolmentstateseq = 1 and e.studentseq = 67 and p.openingprocedureseq <>18;
                
                             
 select e.studentseq, count(*)
        from tblopeningprocedure  p inner join tblEnrolment e
            on p.openingprocedureSeq = e.openingprocedureSeq 
                where e.enrolmentstateseq = 1 group by e.studentseq;  --18,67
                
                
select sysdate from dual;
                
set serveroutput ON;


--시험용
declare
    vstartDate date;
    vendDate date;
    venrolmentSeq tblAttendance.enrolmentSeq%type;
    vcompleteDate tblenrolment.completedate%type;
    vnum number := 0;
begin
    select p.procedurestart, p.procedureend, e.enrolmentSeq , e.completedate
        into vstartDate, vendDate, venrolmentSeq , vcompletedate
        from tblopeningprocedure  p inner join tblEnrolment e
            on p.openingprocedureSeq = e.openingprocedureSeq 
                where e.studentSeq =7;
    if vendDate <= sysdate then
        
          loop
         vstartDate := vstartDate + 1;
        if to_char(vstartDate, 'd') not in ('1','7') then
        vnum := vnum + 1;
         end if;
        exit when to_char(vstartDate) = to_char(sysdate + 1);
    
        end loop;
        
                        dbms_output.put_line(vnum);

        
    elsif vendDate > sysdate then
        
        if vcompletedate is null then
        loop
         vstartDate := vstartDate + 1;
        if to_char(vstartDate, 'd') not in ('1','7') then
        vnum := vnum + 1;
         end if;
        exit when to_char(vstartDate) = to_char(sysdate + 1);
        end loop;
    
        else 
              loop
         vstartDate := vstartDate + 1;
        if to_char(vstartDate, 'd') not in ('1','7') then
        vnum := vnum + 1;
         end if;
         exit when to_char(vstartDate) = to_char(vcompletedate);
        end loop;
                 end if;

                        dbms_output.put_line(vnum);
                        dbms_output.put_line(vstartdate);

    end if;               
end;


--프로시저
create or replace procedure procAddAttendance(
 pStudentNum number
)
is
    vstartDate date;
    vendDate date;
    venrolmentSeq tblAttendance.enrolmentSeq%type;
    vcompleteDate tblenrolment.completedate%type;
begin
    select p.procedurestart, p.procedureend, e.enrolmentSeq, e.completedate
        into vstartDate, vendDate, venrolmentSeq ,vcompletedate
        from tblopeningprocedure  p inner join tblEnrolment e
            on p.openingprocedureSeq = e.openingprocedureSeq 
                where e.studentSeq = pStudentNum  and p.openingprocedureseq <>18;
                
    if vendDate <= sysdate then
        loop
        if to_char(vstartDate, 'd') not in ('1','7') then
               insert into tblAttendance values (seqAttendance10.nextVal, venrolmentSeq, '09:00', '17:50', 1, vstartDate);
         end if;
        vstartDate := vstartDate + 1;
        exit when vstartDate = vcompleteDate + 1;
    end loop;
    
    elsif vendDate > sysdate then

  if vcompletedate is null then
        loop
        if to_char(vstartDate, 'd') not in ('1','7') then
                       insert into tblAttendance values (seqAttendance10.nextVal, venrolmentSeq, '09:00', '17:50', 1, vstartDate);
         end if;
                  vstartDate := vstartDate + 1;
        exit when to_char(vstartDate) = to_char(sysdate + 1);
        end loop;
    
        else 
              loop
        if to_char(vstartDate, 'd') not in ('1','7') then
                               insert into tblAttendance values (seqAttendance10.nextVal, venrolmentSeq, '09:00', '17:50', 1, vstartDate);
         end if;
                  vstartDate := vstartDate + 1;
         exit when to_char(vstartDate) = to_char(vcompletedate);
        end loop;
                 end if;
    end if;
end;


begin
    procaddattendance(8);
end;

--cursor로 studentSeq 루프로 입력
declare
    cursor vcursor is select studentseq from tblEnrolment where enrolmentstateseq =1 and openingprocedureseq <> 18;
    vSeq number;  --결과를 저장할 변수
begin
    open vcursor;   -- select문 실행 > 결과셋에 커서 연결(참조) > 탐색기능
    
--    fetch vcursor into vname;   --값을 가져와 변수에 저장
--    dbms_output.put_line(vname);

    loop
        fetch vcursor into vSeq;
        --dbms_output.put_line('확인');
                procaddattendance(vseq);
        exit when vcursor%notfound;  --boolean 그 다음행이 있는지 없는지 
    end loop;
    
    close vcursor;
end;

select * from tblAttendance order by attendanceSeq desc;
select * from tblEnrolment where enrolmentstateseq =1 and openingprocedureseq <> 18;



select count(*) from tblAttendance group by enrolmentseq;

create sequence seqAttendance10;

delete from tblAttendance;

select seqAttendance7.currVal from dual;

select * from tblenrolment order by openingprocedureseq;
select * from tblopeningprocedure;
select * from tblenrolmentstate;
select * from tblattendancestate;
select * from tblAttendance;
select * from tblAttendance where enrolmentseq = 42 order by attendanceseq ;


select * from tblproceduresubject order by subjectseq;

commit;




