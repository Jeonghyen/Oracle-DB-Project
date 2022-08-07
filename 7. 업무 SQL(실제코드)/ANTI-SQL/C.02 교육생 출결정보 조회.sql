--C.02 교육생 출결정보 조회


--전체 출력
select attendancedate as 날짜, intime as 출근, outtime as 퇴근, 
(select attendancestatename from tblattendancestate 
    where attendancestateseq = a.attendancestateSeq) as 출결상태
from tblAttendance a where enrolmentseq = fngetenrol('dkdghvrhd');


--월별 출력
select attendancedate as 날짜, intime as 출근, outtime as 퇴근, 
(select attendancestatename from tblattendancestate 
    where attendancestateseq = a.attendancestateSeq) as 출결상태
from tblAttendance a 
    where enrolmentseq = fngetenrol('dkdghvrhd') and substr(a.attendancedate, 4,2) = 11;

--일별 출력

select attendancedate as 날짜, intime as 출근, outtime as 퇴근, 
(select attendancestatename from tblattendancestate 
    where attendancestateseq = a.attendancestateSeq) as 출결상태
from tblAttendance a 
    where enrolmentseq = fngetenrol('dkdghvrhd') and to_char(a.attendancedate, 'yymmdd') = '220106';
