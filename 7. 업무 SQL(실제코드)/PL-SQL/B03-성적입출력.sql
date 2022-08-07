-- 학생 이름을 입력하면 수강신청 번호를 알려주는 함수
create or replace function fnenrolmentseq(
    pname in varchar2 --학생이름
) return number
is
    venrolmentseq number;
begin
    select e.enrolmentseq into venrolmentseq
    from tblenrolment e 
        inner join tblstudent st 
            on e.studentseq = st.studentseq 
                inner join tblmemberinfo i 
                    on i.memberinfoseq = st.memberinfoseq 
                        where i.name = pname;
    
    return venrolmentseq;
end fnenrolmentseq;


-- 성적 입력
-- 필기, 실기, 출석 점수를 입력하면 각각의 테이블에 한번에 insert해주기 -- 확인~!
create or replace procedure procScore(
    ptestseq in number,
    penrolmentseq in number,
    pwrittenscore in number,
    ppracticalscore in number,
    pattendancescore in number
)
is
begin
    insert into tblwrittenscore values (seqWritten.nextVal, ptestseq, penrolmentseq, pwrittenscore);
    insert into tblpracticalscore values ((select max(practicalscoreseq)+1 from tblpracticalscore), ptestseq, penrolmentseq, ppracticalscore);
    insert into tblattendancescore values ((select max(attendancescoreseq)+1 from tblattendancescore), penrolmentseq, pattendancescore);
end procScore;


create or replace view vwscoreinput
as
select 
    distinct s.scoreseq,
    t.teacherseq as "교사번호",
    pl.procedurename as "과정명",
    mi.name as "학생명" ,
    sd.tel as "전화번호",
    cs.completestate as "수료상태",
    en.completedate as "수료 및 중도탈락 날짜",
    sb.subjectname as "과목명",
    ws.writtenscore as "필기점수",
    ps.practicalscore as "실기점수",
    ads.attendancescore as "출결점수"
from tblscore s 
    inner join tblwrittenscore ws 
        on s.writtenscoreseq = ws.writtenscoreseq
            inner join tblpoint p
                on s.pointseq = p.pointseq
                    inner join tblpracticalscore ps
                        on ps.practicalscoreseq = s.practicalscoreseq
                            inner join tblAttendanceScore ads
                                on s.attendancescoreseq = ads.attendancescoreseq
                                    inner join tblenrolment en
                                        on en.enrolmentseq = ads.enrolmentseq
                                            inner join tblstudent sd
                                                on sd.studentseq = en.studentseq
                                                    inner join tblmemberinfo mi
                                                        on mi.memberinfoseq = sd.memberinfoseq
                                                            inner join tblopeningprocedure op
                                                                on op.openingprocedureseq = en.openingprocedureseq
                                                                    inner join tblroom r
                                                                        on r.roomseq = op.roomseq
                                                                            inner join tblProcedureList pl
                                                                                on pl.procedurelistseq = op.procedurelist
                                                                                    inner join tblProcedureSubject psj
                                                                                        on psj.procedurelistseq = pl.procedurelistseq
                                                                                         inner join tblsubjectschedule sch
                                                                                            on sch.subjectscheduleseq = p.subjectscheduleseq
                                                                                                inner join tblpossiblesubject ps
                                                                                                    on ps.possiblesubjectseq = sch.possiblesubjectseq
                                                                                                        inner join tblsubject sb
                                                                                                            on sb.subjectseq = ps.subjectseq
                                                                                                                inner join tblteacher t
                                                                                                                    on ps.teacherseq = t.teacherseq
                                                                                                                       left outer  join tblbooklist bl
                                                                                                                           on bl.subjectseq = sb.subjectseq
                                                                                                                                left outer join tblbook bb
                                                                                                                                    on bb.bookseq = bl.bookseq
                                                                                                                                        left outer join tblcompletestate cs
                                                                                                                                            on cs.completestateseq = en.completestateseq                                                                                           
                                                                                                                                                order by scoreseq;


-- 과목번호/과정명/과정기간/강의실/과목명/과목기간/교재명/출결배점등록여부/필기배정등록여부/실기배점등록여부
create or replace view vwteacehrsubjectpoint
as
select
    t.teacherseq as "교사번호",
    i.name as "교사명",
    pl.procedurename as "과정명",
    op.procedurestart as "과정 시작",
    op.procedureend as "과정 끝",
    sb.subjectname as "과목명",
    sch.subjectstart as "과목 시작",
    sch.subjectend as "과목 끝",
    bb.bookname as "교재명",
    case
        when p.attendancepoint is not null then 'Y'
        else 'N'
    end as "출결점수배점등록",
    case
        when p.writtenpoint is not null then 'Y'
        else 'N'
    end as "필기점수배점등록",
    case
        when p.practicalpoint is not null then 'Y'
        else 'N'
    end as "실기점수배점등록"
from tblopeningprocedure op
    inner join tblprocedurelist pl
        on op.procedurelist = pl.procedurelistseq
            inner join tblsubjectschedule sch
                on op.openingprocedureseq = sch.openingprocedureseq
                    inner join tblpoint p
                        on p.subjectscheduleseq = sch.subjectscheduleseq
                            inner join tblpossiblesubject ps
                                on ps.possiblesubjectseq = sch.possiblesubjectseq
                                    inner join tblteacher t
                                        on t.teacherseq = ps.teacherseq
                                            inner join tblmemberinfo i
                                                on i.memberinfoseq = t.teacherseq
                                                    inner join tblsubject sb
                                                        on sb.subjectseq = ps.subjectseq
                                                            inner join tblbooklist bl
                                                                on bl.subjectseq = sb.subjectseq
                                                                    inner join tblbook bb
                                                                        on bb.bookseq = bl.bookseq;