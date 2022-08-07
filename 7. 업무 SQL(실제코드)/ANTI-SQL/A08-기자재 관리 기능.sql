-- 기자재 관리 기능
-- 기자재 목록(카테고리명, 기자재명, 사용가능여부(가능/수리중/불가능), 사용 위치/반입날짜)을 확인할 수 있어야한다.
SELECT

    ec.categoryname as "기자재 카테고리",
    e.equipmentname as "기자재 이름",
    es.statename as "기자재 사용가능 여부",
    r.roomname as "기자재 사용 위치",
    e.importdate as "반입 날짜"
    
FROM tblequipment e
    INNER JOIN tblroom r
        on e.roomseq = r.roomseq
            INNER JOIN tblequipmentstate es
                on e.equipmentstateseq = es.equipmentstateseq
                    INNER JOIN tblequipmentcategory ec
                        on e.categoryseq = ec.categoryseq;

CREATE OR REPLACE VIEW vwEquipmentManage AS
SELECT

    ec.categoryname as "기자재 카테고리",
    e.equipmentname as "기자재 이름",
    es.statename as "기자재 사용가능 여부",
    r.roomname as "기자재 사용 위치",
    e.importdate as "반입 날짜"
    
FROM tblequipment e
    INNER JOIN tblroom r
        on e.roomseq = r.roomseq
            INNER JOIN tblequipmentstate es
                on e.equipmentstateseq = es.equipmentstateseq
                    INNER JOIN tblequipmentcategory ec
                        on e.categoryseq = ec.categoryseq;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 카테고리별로 출력할 수 있어야한다.
-- 앞서 위에서 만들어놓은 뷰를 이용하여 조건만 설정해서 출력
SELECT
    * 
FROM vwEquipmentManage
    WHERE "기자재 카테고리" = '키보드';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 사용위치별로 출력할 수 있어야한다.
SELECT
    * 
FROM vwEquipmentManage
    WHERE "기자재 사용 위치" = '1강의실';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 기자재 별로 총 수량을 출력할 수 있어야 한다.
SELECT

    "기자재 이름",
    COUNT(*) as 수량
    
FROM vwEquipmentManage
    group by "기자재 이름";
    

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 기자재 정보 입력시 카테고리명, 기자재명을 기본정보로 입력할 수 있어야한다.
-- 추가로 사용가능여부와 사용위치를 추가할 수 있어야한다.
-- 기자재 추가
INSERT INTO tblequipmentstate VALUES ((select max(EQUIPMENTSTATESEQ.nextval) + 1 from tblequipmentstate), '10일뒤 사용가능');
INSERT INTO tblequipmentcategory VALUES ((select max(tblequipmentcategory.categoryseq) + 1 from tblequipmentcategory), '추가카테고리');
INSERT INTO tblequipment VALUES ((select max(equipmentseq) + 1 from tblequipment), '기자재명', roomseq, (select max(tblequipmentcategory.categoryseq) from tblequipmentcategory), (select max(EQUIPMENTSTATESEQ.nextval) from tblequipmentstate),importdate);


