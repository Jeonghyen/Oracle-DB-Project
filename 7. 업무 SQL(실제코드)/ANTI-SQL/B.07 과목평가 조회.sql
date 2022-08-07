--B.07 과목평가 조회 
create  view vwTerate
      as      
select
t.teacherseq as"교사번호",
 pl.procedurename as "개설과정명",
pr.ratescore as "평점",
pr.ratecontents as "평가내용"
         from tblProcedureRate pr
         inner join tblOpeningProcedure op
         on pr.openingprocedureseq=op.openingprocedureseq
         inner join tblProcedureList pl
         on pl.procedurelistseq=op.procedurelist 
         inner join tblsubjectschedule sch
         on sch.openingprocedureseq = op.openingprocedureseq
        inner join tblpossiblesubject ps
        on ps.possiblesubjectseq = sch.possiblesubjectseq
        inner join tblteacher t
        on ps.teacherseq = t.teacherseq
        inner join tblmemberinfo mi
        on mi.memberinfoseq = t.memberinfoseq;
             
             drop view vwTerate;
             
select*from  vwTerate where "교사번호"= fnteacherSeq('rhnjkwgajkl');           
select*from  vwTerate where "교사번호"= fnteacherSeq('rjgvhxjdjd');    


