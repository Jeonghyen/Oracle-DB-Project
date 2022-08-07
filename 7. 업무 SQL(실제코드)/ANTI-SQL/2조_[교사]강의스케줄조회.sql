-- [교사] 강의 스케줄 조회 (과목번호, 과정명, 과정기간,  과목명, 과목기간, 강의실, 교재명, 교육생 등록 인원)

create or replace view vwTeacherCheck
as
select 
    pl.procedurename as "과정명",
    op.procedurestart as "과정시작날짜",
    op.procedureend as "과정종료날짜",
    sj.subjectname as "과목명",
    ss.subjectstart as "과목시작날짜",
    ss.subjectend as "과목종료날짜",
    case
        when subjectstart > sysdate then '강의예정'
        when subjectstart < sysdate and subjectend > sysdate then '강의중'
        when subjectend < sysdate then '강의종료'
    end as "강의진행사항",
    r.roomname as "강의실",
    b.bookname as "교재명",
    op.studentsum as "교육생 등록 인원",
    mi.id as "아이디",
    substr(t.ssn, 8) as "비밀번호" 
from tblSubjectSchedule ss
    inner join tblPossibleSubject ps
        on ss.possiblesubjectseq = ps.possiblesubjectseq
         inner join tblteacher t
            on ps.teacherseq = t.teacherseq
                inner join tblmemberinfo mi
                    on mi.memberinfoseq = t.memberinfoseq
                        inner join tblopeningprocedure op
                            on op.openingprocedureseq = ss.openingprocedureseq
                                inner join tblProcedureList pl
                                    on pl.procedurelistseq = op.procedurelist
                                        inner join tblSubject sj
                                            on sj.subjectseq = ps.subjectseq
                                                inner join tblroom r
                                                    on r.roomseq = op.roomseq
                                                        inner join tblBookList bl
                                                            on bl.subjectseq = sj.subjectseq
                                                                inner join tblbook b
                                                                    on b.bookseq = bl.bookseq
                                                                        order by subjectscheduleseq;

-----------------------------------------------------------------------------------------
select * from vwTeacherCheck where "아이디" = 'rhnjkwgajkl' and "비밀번호" = '1094202';
-----------------------------------------------------------------------------------------
        
-- 특정 과목을 과목 번호로 선택 시 교육생 정보 확인(과정명, 학생명, 전화번호, 등록일, 수료 or 중도탈락 여부) + 과정명 추가
create or replace view vwStudentInfoCheck
as
select 
    s.studentseq "학생번호",
    pl.procedurename as "과정명",
    mi.name as "학생명",
    s.tel as "전화번호",
    s.regdate "등록일",
    case
        when e.completestateseq = 1 then '수료'
        when e.completestateseq = 2 then '중도탈락'
    end as "수료여부",
    sj.subjectseq as "과목번호"
from tblstudent s 
    inner join tblmemberinfo mi 
        on mi.memberinfoseq = s.memberinfoseq
            inner join tblenrolment e
                on e.studentseq = s.studentseq
                    inner join tblopeningprocedure op
                        on e.openingprocedureseq = op.openingprocedureseq
                            inner join tblProcedureList pl
                                on pl.procedurelistseq = op.procedurelist 
                                    inner join tblproceduresubject psj
                                        on psj.procedurelistseq = op.procedurelist
                                            inner join tblsubject sj
                                                on sj.subjectseq = psj.subjectseq
                                                        order by s.studentseq; 

      
--------------------------------------------------------------------------------
select * from vwStudentInfoCheck where "과목번호" = 2;                    
--------------------------------------------------------------------------------

