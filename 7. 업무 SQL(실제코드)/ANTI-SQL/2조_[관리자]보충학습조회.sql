-- 보충학습 관리 및 조회
create or replace view vwAddStudy
as
select 
    a.scoreseq,
    a."과정명",
    a."과목명",
    a."학생명",
    a."필기점수",
    a."실기점수",
    a."출결점수",
    a."총점",
    mi.name as "교사명",
    a."강의실"
from (
select 
    distinct s.scoreseq,
    ws.writtenscore * p.writtenpoint / 100 as "필기점수",
    ps.practicalscore * p.practicalpoint / 100 as "실기점수",
    ads.attendancescore * p.attendancepoint / 100 as "출결점수",
    ws.writtenscore * p.writtenpoint / 100 + 
    ps.practicalscore * p.practicalpoint / 100 + 
    ads.attendancescore * p.attendancepoint / 100 as "총점",
    mi.name as "학생명",
    r.roomname as "강의실",
    pl.procedurename as "과정명",
    sb.subjectname as "과목명",
    tea.memberinfoseq
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
                                                                                                                inner join tblteacher tea
                                                                                                                    on tea.teacherseq = ps.teacherseq
                                                                                                                        order by scoreseq) a inner join tblmemberinfo mi on mi.memberinfoseq = a.memberinfoseq where "총점" < 70;

--------------------------------------------------------------------------------
select * from vwAddStudy;
--------------------------------------------------------------------------------
