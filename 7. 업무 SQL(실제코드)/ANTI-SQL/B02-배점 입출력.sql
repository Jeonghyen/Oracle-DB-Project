-- 프로젝트 쿼리문

-- B02. 교사 - 배점 입출력

-- 1. 배점 입출력 > tblPoint에 insert하는 구문
-- 프로시저로 입력받기


-- 배점 실제 입력
begin
    procPoint(40, 40, 20);
end;





-- 과목 목록 출력 시 과정명, 과정기간, 강의실, 과목명, 과목기간, 교재명, 출결, 필기,실기 배점      
select * from vwpointsubject where "교사번호" =  fnteacherSeq('eufhfjsjwjl') and "과목 끝" < sysdate;




-- 시험날짜 확인                             
select * from vwtest  where "교사번호" =  fnteacherSeq('eufhfjsjwjl') and "과목명" = 'Spring';



-- 시험문제 확인                        
select * from vwquestion where "교사번호" =  fnteacherSeq('eufhfjsjwjl') and "개설과목" = 'Spring' and "문제번호" = 23;





-- 시험등록
begin
    procTestDate(23, '2022-05-19', '실기');
end;


