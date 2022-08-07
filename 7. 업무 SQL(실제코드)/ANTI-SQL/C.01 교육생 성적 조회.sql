--C.01 교육생 성적 조회

--내정보와 과정세부정보 조회
create view vwStinfo
as
select  distinct 
sr.studentseq as "학생번호",
me.name as "이름",
me.id as "아이디",
sr.ssn as "주민번호",
sr.tel as "전화번호",
pl.procedurename as "과정명",
op.procedurestart as "과정기간시작",
op.procedureend as "과정기간끝",
r.roomname as "강의실"
from
tblSubjectSchedule ss
inner join tblOpeningProcedure op
on ss.openingprocedureseq = op.openingprocedureseq
inner join tblEnrolment e
on e.openingprocedureseq = op.openingprocedureseq
inner join tblStudent sr
on sr.studentseq = e.studentseq
inner join tblMemberInfo me
on me.memberinfoseq = sr.memberinfoseq
inner join tblProcedureList pl
on pl.procedurelistseq = op.procedurelist
inner join tblRoom r
on r.roomseq = op.roomseq ;

select*from vwStinfo;

--내정보 조회
select*from  vwStinfo where "학생번호"= fnStudentSeq('dkdghvrhd'); 



--교육생 성적조회
--과목번호, 과목명, 과목기간(시작 년월일, 끝 년월일),교재명, 교사명, 과목별 배점 정보(출결, 필기, 실기 배점), 과목별 성적 정보(출결, 필기, 실기 점수), 과목별 시험날짜, 시험문제

create view vwStscinfo
as
select 
  distinct s.scoreseq,
  sd.studentseq as "학생번호",
      sb.subjectseq as"과목번호",
    sb.subjectname as"과목명",
    sch.subjectstart as"과목기간시작",
    sch.subjectend as"과목기간끝",
    bb.bookname as"교재명",
      (select name from tblMemberInfo where memberinfoseq = (select memberinfoseq from tblTeacher where teacherseq = t.teacherseq)) as"교사명",
        p.writtenpoint as"필기배점",
    p.practicalpoint as"실기배점",
    p.attendancepoint as"출결배점",
    ws.writtenscore as"필기점수",
    ps.practicalscore as"실기점수",
    ads.attendancescore as"출결점수",
    te.testdate as"시험날짜",
    ty.typename as"유형이름",
    q.question as"시험문제"
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
                                                                                                                                       inner join tblTest te
                                                                                                            on te.subjectScheduleSeq=sch.subjectScheduleSeq
                                                                                                            inner join tblQuestion q
                                                                                                            on te.testseq=q.testseq
                                                                                                            inner join tblType ty
                                                                                                            on ty.typeseq = te.typeseq
                                                                                                                order by scoreseq;

 
select*from vwStscinfo;

-- 내성적조회
 select*from  vwStscinfo where "학생번호"= fnStudentSeq('dkdghvrhd'); --수료완료한 학생의 성적조회
 select*from  vwStscinfo where "학생번호"= fnStudentSeq('ipskhaxwfd'); --수료중인 학생의 성적조회
 
