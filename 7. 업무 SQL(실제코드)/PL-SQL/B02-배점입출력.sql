create or replace procedure procPoint( -- 생성됨 -- 확인
    writtenpoint in number,
    practicalpoint in number,
    attendancepoint in number
)
is
    ROW_SCORE EXCEPTION;
begin
    insert into tblPoint values (seqPoint2.nextVal, writtenpoint,  practicalpoint, attendancepoint, fnGetsubjectseq(3, 'Spring', 15));
    if attendancepoint < 20 then
        raise ROW_SCORE;
    end if;
exception
    when ROW_SCORE then dbms_output.put_line('조건이 맞지않습니다.');
end procPoint;

-- 과목명을 입력하면 과목스케줄조회번호 받기 > 과목명 spring, 과목스케줄번호 45, 과정번호 15
-- 함수
create or replace function fnGetsubjectseq(
    pteacherseq in number,
    psubjectname in varchar2,
    popeningprocedureseq in number
) return number
is
    vsubjectscheduleseq number;
begin
    select
    sch.subjectscheduleseq into vsubjectscheduleseq
from tblsubject sb
    inner join tblpossiblesubject ps
        on sb.subjectseq = ps.subjectseq
            inner join tblsubjectschedule sch
                on sch.possiblesubjectseq = ps.possiblesubjectseq
                    inner join tblteacher t
                        on t.teacherseq = ps.teacherseq
                            where t.teacherseq = pteacherseq and sb.subjectname = psubjectname and sch.openingprocedureseq = popeningprocedureseq;
                            return vsubjectscheduleseq; 
end;

create or replace view vwpointsubject
as
select 
    p.teacherseq as "교사번호",
    i.name as "교사명",
    pl.procedurename as "과정명",
    o.procedurestart as "과정 시작",
    o.procedureend as "과정 끝",
    r.roomname as "강의실명",
    sb.subjectname as "과목명",
    h.subjectstart as "과목 시작",
    h.subjectend as "과목 끝",
    b.bookname as "교재명",
    pp.writtenpoint as "필기비율",
    pp.practicalpoint as "실기비율",
    pp.attendancepoint as "출결비율"
from tblsubjectSchedule h
    inner join tblOpeningProcedure o
        on h.openingprocedureseq = o.openingprocedureseq
            inner join tblRoom r
                on r.roomseq = o.roomseq
                    inner join tblPossibleSubject p
                        on p.possiblesubjectseq = h.possiblesubjectseq
                            inner join tblSubject s
                                on p.subjectseq = s.subjectseq
                                    inner join tblBookList bl
                                        on bl.subjectseq = s.subjectseq
                                            inner join tblBook b
                                                on b.bookseq = bl.bookseq
                                                    inner join tblPoint pp
                                                        on pp.subjectscheduleseq = h.subjectscheduleseq
                                                            inner join tblprocedurelist pl
                                                                on pl.procedurelistseq = o.procedurelist
                                                                    inner join tblsubject sb
                                                                        on sb.subjectseq = p.subjectseq
                                                                            inner join tblteacher t
                                                                                on t.teacherseq = p.teacherseq  
                                                                                    inner join tblmemberinfo i
                                                                                        on i.memberinfoseq = t.memberinfoseq;
 -- 과목 선택 시 출결, 필기, 실기, 시험 날짜 시험문제 입력할 수 있음
create or replace view vwtest
as
select 
    t.testseq as "시험번호",
    t.teacherseq as "교사번호",
    i.name as "교사명",
    pl.procedurename as "과정명",
    sb.subjectname as "과목명",
    t.testdate as "시험날짜",
    tp.typename as "시험유형",
    case
        when t.testdate is not null then 'Y'
        else 'N'
    end as "시험등록여부"
from tblTest t 
    right outer join tblsubjectSchedule s --inner join으로 변경해도 무관
        on s.subjectscheduleseq = t.subjectscheduleseq 
            inner join tblPossiblesubject p
                on p.possiblesubjectseq = s.possiblesubjectseq
                    inner join tblsubject sb
                        on sb.subjectseq = p.subjectseq
                            inner join tblopeningprocedure op
                                on op.openingprocedureseq = s.openingprocedureseq
                                    inner join tblprocedurelist pl
                                        on pl.procedurelistseq = op.procedurelist
                                            inner join tbltype tp
                                                on tp.typeseq = t.typeseq
                                                    inner join tblteacher t
                                                        on t.teacherseq = p.teacherseq
                                                            inner join tblmemberinfo i
                                                                on i.memberinfoseq = t.memberinfoseq;

-- 교사번호 시험번호 과정명 개설과목 문제번호 문제
create or replace view question
as
select 
 th.teacherseq as "교사번호",
 t.testseq as "시험번호",
 pl.procedurename as "과정명",
 sb.subjectname as "과목명",
 q.questionseq as "문제번호",
 q.question as "문제"
from tblquestion q
    inner join tbltest t
        on t.testseq = q.testseq
            inner join tblsubjectschedule sch
                on sch.subjectscheduleseq = t.subjectscheduleseq
                    inner join tblopeningprocedure op
                        on op.openingprocedureseq = sch.openingprocedureseq
                            inner join tblprocedurelist pl
                                on pl.procedurelistseq = op.procedurelist
                                    inner join tblpossiblesubject ps
                                        on ps.possiblesubjectseq = sch.possiblesubjectseq
                                            inner join tblsubject sb
                                                on sb.subjectseq = ps.subjectseq
                                                    inner join tblteacher th
                                                        on th.teacherseq = ps.teacherseq
                                                            inner join tblmemberinfo i
                                                                on i.memberinfoseq = th.memberinfoseq;
                                                                
-- 유형을 작성하면 유형번호가 나오는 함수
create or replace function fntesttype(
    ptypename in varchar2
) return number
is
    vtypeseq number;
begin
    select typeseq into vtypeseq from tbltype where typename = ptypename;
    return vtypeseq;
end fntesttype;

-- 시험 날짜, 시험 문제 등록
desc tblTest; -- 시험번호, 과목스케줄번호, 시험날짜, 유형번호
create or replace procedure procTestDate(
    psbschseq in number,
    pdate in date,
    ptype in varchar2
)
is
begin
    insert into tblTest values ((select max(testseq) + 1 from tblTest), psbschseq, pdate, fntesttype(ptype));
end procTestDate;

-- 유형번호로 이름 받아오는 함수
create or replace function fnTestType(
    psbschseq in number,
    ptypeseq in number
) return varchar2
is
    vtypename varchar2;
begin
    select ty.typename into vtypename
    from tblTest t 
        inner join tbltype ty 
            on t.typeseq = ty.typeseq 
                where t.subjectscheduleseq = psbschseq and ty.typeseq = ptypeseq;    
    return vtypename;
end fnTestType;


create or replace function fnteacherSeq(
 pid varchar2
)return number
is
vteachseq number;
begin
   select teacherseq into vteachseq from tblteacher  
   where memberinfoseq = (select memberinfoseq  
   from tblmemberinfo where id = pid);
   return vteachseq;
end;
commit;