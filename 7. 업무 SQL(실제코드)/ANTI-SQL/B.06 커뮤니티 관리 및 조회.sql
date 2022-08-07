--B.06 커뮤니티 관리 및 조회 
  
create view Tcomucomu
as
select distinct
        t.teacherseq as "교사번호",
            comunityseq as "커뮤니티글번호",
            op.openingProcedureSeq "개설과정번호",
            pl.procedurename as "과정명",     
            categoryname as "카테고리",
            contents as "게시글내용",
            name as "작성자명",
            writedate as "작성날짜",
            answer as "답변여부",
            (select count(*)from tblComment where comunityseq = co.comunityseq) "댓글수"
             from tblCommuCategory cm
             inner join tblComunity co
             on cm.categoryseq = co.categoryseq
             inner join tblmember m
             on co.memberseq = m.memberseq
              inner join tblMemberInfo mb
              on m.memberinfoseq=mb.memberinfoseq
                inner join tblEnrolment e
                        on e.enrolmentSeq = m.enrolmentSeq
                             inner join tblOpeningProcedure op
                                on op.openingprocedureseq = e.openingprocedureseq
                                     inner join tblProcedureList pl
                                        on pl.procedurelistseq = op.procedureList
                                         inner join tblSubjectschedule ss
                                        on ss.openingprocedureseq =op.openingprocedureseq
                                                inner join tblPossiblesubject po
                                                on ss.possiblesubjectseq=po.possiblesubjectseq
                                                inner join tblTeacher t
                                                on t.teacherseq=po.teacherseq
                                               order by co.comunityseq;
                                               select*from Tcomucomu;
                                               eufhfjsjwjl
        --해당교사가 가르치는 과정 게시물 모두 조회                           
            select*from Tcomucomu  where "교사번호"= fnteacherSeq('eufhfjsjwjl');
      --5번교사가 가르치는 과정 커뮤니티 카테고리별조회 (잡담/질문/공지사항)                             
                                                   
          select*from Tcomucomu where 카테고리='잡담' and "교사번호"= fnteacherSeq('eufhfjsjwjl');      
          select*from Tcomucomu where 카테고리='질문' and "교사번호"= fnteacherSeq('eufhfjsjwjl');    
         select*from Tcomucomu where 카테고리='공지사항' and "교사번호"= fnteacherSeq('eufhfjsjwjl');    
    --5번교사가 답변해야하는 글
       select*from Tcomucomu where 카테고리='질문' and 답변여부 ='N' and  "교사번호"= fnteacherSeq('eufhfjsjwjl');   
 
               
         --댓글조회
            create view vwCmselect
            as
             select  distinct co.comunityseq as "커뮤니티글번호",
                mb.name as "작성자",
                cm.commentcontents as "댓글"
             from tblCommuCategory cm
             inner join tblComunity co
             on cm.categoryseq = co.categoryseq
             inner join tblmember m
             on co.memberseq = m.memberseq
              inner join tblMemberInfo mb
              on m.memberinfoseq=mb.memberinfoseq
              inner join tblComment cm
               on cm.comunityseq=co.comunityseq;  
               
                 select*from Cmselect;
        select*from vwCmselect where "커뮤니티글번호"=7;

--뷰로 답변확인(N->Y)
create or replace view vwComuans  
as
select distinct 
                t.teacherseq as "교사번호",        
                co.comunityseq as "커뮤니티글번호",
                mb.name as "작성자",
                co.writedate as "작성날짜",
                cm.commentcontents as "댓글",
                co.answer as"답변여부"
             from tblCommuCategory cm
             inner join tblComunity co
             on cm.categoryseq = co.categoryseq
             inner join tblmember m
             on co.memberseq = m.memberseq
              inner join tblMemberInfo mb
              on m.memberinfoseq=mb.memberinfoseq
              inner join tblComment cm
              on cm.comunityseq=co.comunityseq
               inner join tblTeacher t
              on t.memberinfoseq=mb.memberinfoseq
                 inner join tblComment cm
            on  cm.comunityseq = co.comunityseq;
            
            select*from vwComuans;
               