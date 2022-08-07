-- A05
-- 교육생 관리
-- 교육생 정보 출력 (교육생 정보 출력시 교육생 이름, 주민번호, 전화번호, 등록일, 수강(신청) 횟수, 취업여부를 출력) 

SELECT  
    mi.name as "이름", 
    s.ssn as "주민번호", 
    s.tel as "전화번호", 
    s.regdate as "등록일자", 
    s.employment as "취업여부",
    count(mi.memberinfoseq) as "수강신청 횟수"
FROM tblmemberinfo mi
    INNER JOIN tblstudent s
        on mi.memberinfoseq = s.memberinfoseq
            WHERE mi.memberinfoseq > 10 
                group by mi.name, s.ssn, s.tel, s.regdate, s.employment;
 
CREATE OR REPLACE VIEW vwStudentManagement AS 
SELECT  
    mi.name as "이름", 
    s.ssn as "주민번호", 
    s.tel as "전화번호", 
    s.regdate as "등록일자", 
    s.employment as "취업여부",
    count(mi.memberinfoseq) as "수강신청 횟수"
FROM tblmemberinfo mi
    INNER JOIN tblstudent s
        on mi.memberinfoseq = s.memberinfoseq
            WHERE mi.memberinfoseq > 10 
                group by mi.name, s.ssn, s.tel, s.regdate, s.employment;
                
SELECT
    * 
FROM vwstudentmanagement;
                
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 교육생 정보 검색
-- 특정 교육생 선택시 교육생이 수강 신청한 또는 수강중인 수강했던 
-- 개설 과정 정보(과정명, 과정기간(시작 년월일, 끝 년월일), 강의실, 수료 및 중도 탈락의 여부, 수료 및 중도탈락 날짜를 출력한다.

CREATE OR REPLACE VIEW vwstudentinfosearch AS 
SELECT 
    mi.name as "이름",
    p.procedurename as "개설과정 정보",
    o.procedurestart as "과정 시작일",
    o.procedureend as "과정 종료일",
    r.roomname as "강의실",
    c.completestate as "수료상태 여부",
    e.completedate as "수료 및 중도탈락 날짜"
FROM tblmemberinfo mi
    INNER JOIN tblstudent s
        on mi.memberinfoseq = s.memberinfoseq
            INNER JOIN tblenrolment e
                on s.studentseq = e.studentseq
                        INNER JOIN tblopeningprocedure o
                            on e.openingprocedureseq = o.openingprocedureseq
                                INNER JOIN tblprocedurelist p
                                    on o.procedurelist = p.procedurelistseq
                                        INNER JOIN tblroom r
                                            on o.roomseq = r.roomseq
                                                INNER JOIN tblcompletestate c
                                                    on e.completestateseq = c.completestateseq;
                                                 


                                                    
SELECT
    * 
FROM vwstudentinfosearch
    where "이름" = '천혜현';
                                                    
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 기본정보 추가
-- 학생등록 
INSERT INTO tblstudent (studentseq, ssn, tel, regdate, employment, memberinfoseq) VALUES ((select max(tblstudent.studentseq) + 1 from tblstudent), '990801-1123344', '010-8071-2383', '2022-05-09', 'N', (select max(tblmemberinfo.memberinfoseq) from tblmemberinfo));
INSERT INTO tblmemberinfo (memberinfoseq, name, id) VALUES ((select max(tblmemberinfo.memberinfoseq) + 1 from tblmemberinfo), '변창현', 'akskqlkdkkk');


-- 학생 기본정보 수정
-- 멤버 테이블에 아이디 수정
update tblmemberinfo set ID = 	'원하는 id' where memberinfoseq = 학생의 seq번호;
-- 멤버 테이블에 이름 수정
update tblmemberinfo set name = 'OOO' where memberinfoseq = 학생의 seq번호;
-- 학생 테이블에 전화번호 수정
update tblstudent set tel = '전화번호' where studentseq = 학생의 seq 번호;
-- 학생 테이블에 주민번호 수정
update tblstudent set ssn = '주민번호' where studentseq = 학생의 seq 번호;


-- 기본정보 삭제
-- 멤버 테이블에 학생 아이디로 정보 삭제 (이름은 동명이인때매 X )
delete from tblmemberinfo where id = '학생 아이디 입력';
-- 학생 테이블에 학생 주민번호로 정보 삭제
delete from tblstudent where ssn = '학생 주민번호 입력';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
