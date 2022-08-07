-- B.03 성적 입출력
-- 교사번호3. 강의를 마친 과목 출력




-- 성적입력사용
begin
    procScore(23, fnenrolmentseq('천혜현'),90, 80, 100);
end;



                                                                        
-- 과목 목록 출력  
-- 과목 목록 출력 시 과정명, 과정기간, 강의실, 과목명, 과목기간, 교재명, 출결, 필기, 실기 배점 등록여부
select * from vwteacehrsubjectpoint where "교사번호" = fnteacherSeq('eufhfjsjwjl') and "과목 끝" < sysdate;
commit;            




-- 특정 과목을 선택 시 교육생 정보(이름, 전화번호, 수료 또는 중도탈락) 및 성적이 출결, 필기, 실기로 구분되어서 출력되어야한다.
--교육생 이름/전화번호/수료 또는 중도탈락/ 출결/필기/실기 점수
-- 선생님 3, 과목번호로 선택 시 교육생 정보 출력                                                                                                                                               
select * from vwscoreinput where "교사번호" = fnteacherSeq('eufhfjsjwjl') and "과목명" = 'Spring';

-- 선생님 이름 출력
select i.name from tblTeacher t inner join tblmemberinfo i on t.memberinfoseq = i.memberinfoseq where t.teacherseq = fnteacherSeq('eufhfjsjwjl');