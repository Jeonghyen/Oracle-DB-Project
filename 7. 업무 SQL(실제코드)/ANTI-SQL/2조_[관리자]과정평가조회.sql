-- 과정 평가 조회 (개설과정명/학생명/평점/평가내용을 확인할 수 있다.)
create or replace view vwProcedureRateCheck
as
select
    p.procedurerate as "과정평가번호",
    pl.procedurename as "개설과정명" ,
    mi.name as "학생명",
    p.ratescore as "평점",
    p.ratecontents as "과정 평가 내용",
    p.proceduredate as "작성날짜"
from tblProcedureRate p
    inner join tblOpeningProcedure o
        on p.openingprocedureseq = o.openingprocedureseq
            inner join tblProcedureList pl
                on o.procedurelist = pl.procedurelistseq
                    inner join tblenrolment e
                        on e.enrolmentseq = p.enrolmentseq
                            inner join tblstudent s
                                on s.studentseq = e.studentseq
                                    inner join tblmemberinfo mi
                                        on mi.memberinfoseq = s.memberinfoseq
                                            order by p.procedurerate;

--------------------------------------------------------------------------------
select * from vwProcedureRateCheck;
--------------------------------------------------------------------------------
