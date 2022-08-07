-- B05 기자재 조회 기능


-- 기자재 조회 기능
select * from vwequipment;

-- 기자재명으로 검색
select * from vwequipment where "기자재" like '%LG%'; --jdbc로 해야함

-- 카테고리별
select * from vwequipment where "카테고리" = '키보드';

-- 사용가능한 기자재만 보기
select * from vwequipment where "카테고리" = '키보드' and "사용가능여부" = '가능';

-- 사용위치별로 보기
select * from vwequipment where "사용위치" = '1강의실' and "카테고리" = '키보드' and "사용가능여부" = '가능';

-- 수량확인하기
select "기자재", count(*) as "수량" from vwequipment group by "기자재";



-- 기자재 상태 수정하기 -- 확인!
begin
    procequipmentstate(1, '불가능');
end;
