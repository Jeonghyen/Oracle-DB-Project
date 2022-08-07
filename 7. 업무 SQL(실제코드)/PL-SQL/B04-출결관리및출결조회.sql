create or replace view vwattendance
as
select
    t.teacherseq as "교사 번호",
    pl.procedurename as "과정명",
    i.name as "학생명",
    att.inTime as "출근시간",
    att.outTime as "퇴근시간",
    aas.attendancestatename as "근태사항",
    att.attendancedate as "날짜"
from tblAttendance att
    inner join tblEnrolment e
        on e.enrolmentseq = att.enrolmentseq
            inner join tblStudent st
                on st.studentseq = e.studentseq
                    inner join tblopeningProcedure op
                        on op.openingprocedureseq = e.openingprocedureseq
                            inner join tblprocedureList pl
                                on pl.procedurelistseq = op.procedurelist
                                    inner join tblsubjectschedule sh
                                        on sh.openingprocedureseq = op.openingprocedureseq
                                            inner join tblpossiblesubject ps
                                                on ps.possiblesubjectseq = sh.possiblesubjectseq
                                                    inner join tblTeacher t
                                                        on t.teacherseq = ps.teacherseq
                                                            inner join tblmemberinfo i
                                                                on i.memberinfoseq = st.memberinfoseq
                                                                    inner join tblattendancestate aas
                                                                        on aas.attendancestateseq = att.attendancestateseq                                                                            
                                                                                order by "날짜";
                                                                                
-- 교사번호를 받아오는 함수
create or replace function fnteacherSeq(

 pid varchar2

 
)return number
is
vteachseq number;
begin

   select teacherseq into vteachseq from tblteacher where memberinfoseq = (select memberinfoseq from tblmemberinfo where id = pid);  --학생번호17

return vteachseq;