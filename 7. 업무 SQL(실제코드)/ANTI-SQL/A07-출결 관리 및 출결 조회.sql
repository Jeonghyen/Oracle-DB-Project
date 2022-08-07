-- A07
-- 출결 관리 및 출결 조회
-- 관리자는 모든 과정에 대한 출결 관리 및 조회를 할 수 있어야 한다.
-- 모든 출결 조회는 근태 상황을 구분할 수 있어야 한다. (정상, 지각, 조퇴, 외출, 병가, 기타)       
CREATE OR REPLACE VIEW vwAttendance AS
SELECT  

    p.procedurename as "과정명",
    mi.name as "학생이름",
    a.attendancedate as "날짜",
    a.intime as "입실시간",
    a.outtime as "퇴실시간",
    at.attendancestatename as "근태상황"
    
FROM tblmemberinfo mi
    INNER JOIN tblstudent s
        on mi.memberinfoseq = s.memberinfoseq
            INNER JOIN tblenrolment e
                on s.studentseq = e.studentseq
                    INNER JOIN tblattendance a
                        on e.enrolmentseq = a.enrolmentseq
                            INNER JOIN tblopeningprocedure o
                                on e.openingprocedureseq = o.openingprocedureseq
                                    INNER JOIN tblprocedurelist p
                                        on o.procedurelist = p.procedurelistseq
                                            INNER JOIN tblattendancestate at
                                                on at.attendancestateseq = a.attendancestateseq;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                                                              
-- 출결 현황을 기간별(년, 월, 일) 조회할 수 있어야 한다.                                         
-- 년도별
SELECT
    * 
FROM vwattendancesearch
    where substr("날짜", 1, 2) = 22; 

-- 월별
SELECT
    * 
FROM vwattendancesearch
    where substr("날짜", 4, 2) = 05; 

-- 일별  
SELECT
    * 
FROM vwattendancesearch
    where substr("날짜", 7, 2) = 19;      

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 특정(특정 과정, 특정 인원) 출결 현황을 조회할 수 있어야 한다.

-- 과정별 검색
SELECT
    * 
FROM vwAttendance
    WHERE "과정명" = '반응형 UI/UX 웹콘텐츠 개발자 양성과정A5';

-- 인원별 검색
SELECT
    * 
FROM vwAttendance
    WHERE "학생이름" = '최민진';
    
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
