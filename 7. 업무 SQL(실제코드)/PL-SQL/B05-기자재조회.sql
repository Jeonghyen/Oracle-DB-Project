
-- 함수만들기 > 기자재상태를 입력하면 번호를 반환
create or replace function fnequipmentstate(
    pstate in varchar
) return number
is
    vseq number;
begin
    select equipmentstateseq into vseq from tblequipmentstate where statename = pstate;
    return vseq;
end fnequipmentstate;

-- 사용가능 여부 수정하기 > 기자재번호와 기자재 상태명을 입력하면 update 되게한다.
create or replace procedure procequipmentstate(
    pequipseq in number,
    pstate in varchar2
)
is
begin
    update tblequipment set equipmentstateseq = fnequipmentstate(pstate) where equipmentseq =pequipseq ;
end procequipmentstate;

create or replace view vwequipment
as
select 
    eqc.categoryname as "카테고리",
    eq.equipmentname as "기자재",
    eqs.statename as "사용가능여부",
    r.roomname as "사용위치",
    eq.importdate as "반입날짜"
from tblequipment eq
    inner join tblRoom r
       on r.roomseq = eq.roomseq
        inner join tblequipmentcategory eqc
            on eq.categoryseq = eqc.categoryseq
                inner join tblequipmentstate eqs
                    on eqs.equipmentstateseq = eq.equipmentstateseq;