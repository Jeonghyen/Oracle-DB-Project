-- B04. 출결 관리 및 출결 조회
-- 교사가 강의한 과정에 한해 모든 출결 확인 가능


-- 전체보기
select * from vwattendance where "교사 번호" = fnteacherSeq('eufhfjsjwjl');
-- 과정별보기
select * from vwattendance where "과정명" ='스마트웹 웹애플리케이션 개발자 양성과정' and "교사 번호" = fnteacherSeq('eufhfjsjwjl');

-- 년/월/일로 조회하기 > 5월 4일                                                                            
select * from vwattendance where "과정명" ='스마트웹 웹애플리케이션 개발자 양성과정' and "날짜" = to_date('2022-05-04', 'yyyy-mm-dd') and "교사 번호" = fnteacherSeq('eufhfjsjwjl');

-- 년/월/일로 조회하기 > 5월
select * from vwattendance where "과정명" ='스마트웹 웹애플리케이션 개발자 양성과정' and substr("날짜", 4,2) = 05 and "교사 번호" = fnteacherSeq('eufhfjsjwjl');
--select * from vwattendance where "과정명" ='스마트웹 웹애플리케이션 개발자 양성과정' and "날짜" between '2022-05-01' and '2022-05-31' and "교사 번호" = 3;

-- 년/월/일로 조회하기 > 22년
select * from vwattendance where "과정명" ='스마트웹 웹애플리케이션 개발자 양성과정' and substr("날짜", 1,2) = 22 and "교사 번호" = fnteacherSeq('eufhfjsjwjl');

-- 특정 인원 -- 오림윤 학생
select * from vwattendance where "과정명" ='스마트웹 웹애플리케이션 개발자 양성과정' and "교사 번호" = 3 and "학생명" = '오림윤';


