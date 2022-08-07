-- A.06
-- 시험관리 및 성적 조회
-- 특정 개설 과정을 선택하는 경우 개설된 과목 정보를 출력하고, 
-- 개설 과목 별로 성적 등록 여부, 시험 문제 파일 등록 여부를 확인할 수 있어야 한다.
CREATE OR REPLACE VIEW vwTestManagementAndGradeCheck AS 
SELECT 
    pl.procedurename as "개설된 과정 이름",
    sb.subjectname as "개설 과목명",
    case s.scoresum
        when null then 'N'
        else 'Y'
    end as "성적 등록 여부",
    case que.question
        when null then 'N'
        else 'Y'
    end as "시험 파일 등록 여부"
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
                                                                                                                                        INNER join tbltest te
                                                                                                                                            on te.subjectscheduleseq = sch.subjectscheduleseq
                                                                                                                                                inner join tblquestion que
                                                                                                                                                    on que.testseq = te.testseq
                                                                                                                                                       order by scoreseq;
                                                        

  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--과목별 출력시 
--개설 과정명, 
--개설 과정기간, 
--강의실명, 
--개설 과목명, 
--교사명, 
--교재명 등을 출력하고, 
--해당 개설 과목을 수강한 모든 교육생들의 성적 정보
--(교육생 이름, 주민번호, 필기, 실기)를 같이 출력한다.


CREATE OR REPLACE VIEW vwTestManagementSubject AS 
SELECT
    distinct s.scoreseq,
    pl.procedurename as "개설 과정명",
    op.procedurestart as "개설 시작기간", 
    op.procedureend as "개설 종료기간" ,
    r.roomname as "강의실명",
    sb.subjectname as "개설 과목명",
    t.teacherseq as "교사번호",
    bb.bookname as "교재명",
    mi.name as "학생명",
    sd.ssn as "학생 주민번호",
    ws.writtenscore * p.writtenpoint / 100 as "필기", 
    ps.practicalscore * p.practicalpoint / 100 as "실기", 
    ads.attendancescore * p.attendancepoint / 100 as "출결"
    
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
                                                                                                                                        order by scoreseq;        
                                                                                                                
                                                    
                                                
                    
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 교육생 개인별 출력시 
-- 교육생 이름, 
-- 주민등록 번호 뒷자리, 
-- 개설 과정명, 
-- 개설 과정 기간, 
-- 강의실명 등을 출력하고 
-- 교육생 개인이 수강한 모든 개설 과목에 대한 성적 정보(개설 과목명, 개설 과목 기간, 교사명 , 필기, 실기)를 같이 출력한다.

CREATE OR REPLACE VIEW vwTestManagementIndividual AS 
SELECT
    distinct s.scoreseq,
    pl.procedurename as "개설 과정명",
    op.procedurestart as "개설 시작기간", 
    op.procedureend as "개설 종료기간" ,
    r.roomname as "강의실명",
    sb.subjectname as "개설 과목명",
    t.teacherseq, 
    bb.bookname as "교재명",
    mi.name as "학생명",
    sd.ssn as "학생 주민번호",
    ws.writtenscore * p.writtenpoint / 100 as "필기", 
    ps.practicalscore * p.practicalpoint / 100 as "실기", 
    ads.attendancescore * p.attendancepoint / 100 as "출결"
    
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
                                                                                                                                        order by scoreseq;   










