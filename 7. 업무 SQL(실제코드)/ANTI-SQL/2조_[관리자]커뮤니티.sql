-- [관리자] 커뮤니티 조회 기능
create or replace view vwAdminComuView
as
select 
     c.comunityseq as "글번호",
     op.openingProcedureSeq "개설과정번호",
     pl.procedurename as "과정명",     
     case
        when c.categoryseq = 1 then '공지사항'
        when c.categoryseq = 2 then '질문'
        when c.categoryseq = 3 then '잡담'
    end as "카테고리",
    i.name as "작성자",
    c.writedate as "작성날짜",
    c.contents as "내용",
    c.answer as "답변여부",
    (select count(*) from tblcomment group by comunityseq having comunityseq = c.comunityseq) as "댓글수"
from tblcomunity c 
    inner join tblmember m 
        on c.memberseq = m.memberseq
            inner join tblmemberinfo i
                on m.memberinfoseq = i.memberinfoseq
                    inner join tblEnrolment e
                        on e.enrolmentSeq = m.enrolmentSeq
                            left join tblOpeningProcedure op
                                on op.openingprocedureseq = e.openingprocedureseq
                                    inner join tblProcedureList pl
                                        on pl.procedurelistseq = op.procedureList
order by c.comunityseq;

--------------------------------------------------------------------------------
select * from vwAdminComuView where "개설과정번호" = 15;
select * from vwAdminComuView where "카테고리" = '질문';
select * from vwAdminComuView where "답변여부" = 'N';
select * from vwAdminComuView;
--------------------------------------------------------------------------------


-- [관리자] 댓글 조회
create or replace view vwAdminCommView
as
select 
    c.comunityseq as "글번호",
    mi.name as "작성자", 
    c.commentcontents as "댓글내용",
    c.commentseq as "댓글번호"
from tblcomment c 
    inner join tblmember m 
        on c.memberseq = m.memberseq 
            inner join tblmemberinfo mi 
                on m.memberinfoseq = mi.memberinfoseq
                    order by c.comunityseq;


--------------------------------------------------------------------------------
select * from vwAdminCommView;
--------------------------------------------------------------------------------


-- [관리자] 커뮤니티 글 작성
create or replace procedure procAdminComuAdd(
    pid in varchar2,
    ppw in varchar2,
    pcatename in varchar2,
    pcontents in varchar2,
    psubjecseq in number
)
is
    vseq number;
    vlogin number;
    vsubjectcount number;
begin

    select count(*) into vlogin from tblmember m inner join tblmemberinfo mi on m.memberinfoseq = mi.memberinfoseq inner join tblAdmin a on a.memberinfoseq = mi.memberinfoseq where mi.id = pid and a.pw = ppw;
    select count(*) into vsubjectcount from tblsubjectschedule where subjectScheduleSeq = psubjecseq;
    
insert into tblcomunity 
values ((select max(comunityseq) + 1 from tblcomunity), 
        (select m.memberseq
            from tblmember m 
                inner join tblmemberinfo mi 
                    on m.memberinfoseq = mi.memberinfoseq 
                        inner join tblAdmin a
                            on a.memberinfoseq = mi.memberinfoseq
                                where mi.id = pid and a.pw = ppw),
        (select categoryseq from tblcommucategory where categoryname = pcatename), 
        sysdate, 
        pcontents, null, 0, psubjecseq);
        
        select categoryseq into vseq from tblcommucategory where categoryname = pcatename;
        
        if vseq = 2 then
            update tblcomunity set answer = 'N' where comunityseq = (select max(comunityseq) from tblcomunity);
        end if;
exception
    when others then
        if 
            pcatename not in ('공지사항', '질문', '잡담') then
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('카테고리 입력이 잘못되었습니다.');
            dbms_output.put_line('---------------------------------------------------');
        elsif
            length(pcontents) > 100 then
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('내용이 100자를 초과하였습니다.');
            dbms_output.put_line('---------------------------------------------------');
        elsif
            vlogin = 0 then
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('잘못 로그인하였습니다.');
            dbms_output.put_line('---------------------------------------------------');
        elsif 
            vsubjectcount = 0 then
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('존재하지 않는 과목 스케줄 번호입니다.');
            dbms_output.put_line('---------------------------------------------------');
        end if;        
end;
/

--------------------------------------------------------------------------------
begin
    procAdminComuAdd('dpgussafd', 'java1234', '공지사항', '공지사항입니다.', 45);
end;
/
--------------------------------------------------------------------------------
-- 관리자
-- ID = dpgussafd
-- PW = java1234




-- [관리자] 커뮤니티 글 삭제(커뮤니티 글 삭제 시 댓글도 같이 삭제)
create or replace procedure procAdminComuDel(
    pseq in number
)
is
begin
    
    delete from tblcomment where comunityseq = pseq;
    delete from tblcomunity where comunityseq = pseq;
    dbms_output.put_line('---------------------------------------------------');
    dbms_output.put_line('삭제 완료');
    dbms_output.put_line('---------------------------------------------------');
exception
    when others then
    dbms_output.put_line('---------------------------------------------------');
        dbms_output.put_line('존재하지 않는 커뮤니티 번호입니다.');
    dbms_output.put_line('---------------------------------------------------');    
end;
/

--------------------------------------------------------------------------------
begin
    procAdminComuDel(21);
end;
/
--------------------------------------------------------------------------------




-- [관리자] 커뮤니티 글 수정
create or replace procedure procAdminComuChange(
    pcatename varchar2,
    pcontents varchar2,
    pcomuseq number
)
is
    vseq number;
    vcseq number;
begin

    select categoryseq into vseq from tblcomunity where comunityseq = pcomuseq;

    select categoryseq into vcseq from tblcommucategory where categoryname = pcatename;
    
    update tblcomunity a set 
        a.writedate = sysdate, 
        a.categoryseq = (select categoryseq from tblcommucategory where categoryname = pcatename), 
        a.contents = pcontents
        where a.comunityseq = pcomuseq;
        
    if vseq = 2 then
         update tblcomunity set answer = 'N' where comunityseq = pcomuseq;
    else
        update tblcomunity set answer = NULL where comunityseq = pcomuseq;
    end if;   
    
exception
    when others then
        if 
            pcatename not in ('공지사항', '질문', '잡담') then
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('카테고리 입력이 잘못되었습니다.');
            dbms_output.put_line('---------------------------------------------------');
        elsif
            length(pcontents) > 100 then
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('내용이 100자를 초과하였습니다.');
            dbms_output.put_line('---------------------------------------------------');
        else
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('존재하지 않는 커뮤니티 번호입니다.');
            dbms_output.put_line('---------------------------------------------------');
        end if;
end;
/


-------------------------------------------------------------------------------
begin
    procAdminComuChange('공지사항', '내용수정', 19);
end;
/
-------------------------------------------------------------------------------



-- [관리자] 댓글 작성

create or replace procedure procAdminCommentAdd(
    pid in varchar2,
    ppw in varchar2,
    pseq in number,
    pcontents in varchar2
)
is
    vseq number;
    vlogin number;
begin

    select count(*) into vlogin from tblmember m inner join tblmemberinfo mi on m.memberinfoseq = mi.memberinfoseq inner join tblAdmin a on a.memberinfoseq = mi.memberinfoseq where mi.id = pid and a.pw = ppw;
    select categoryseq into vseq from tblcomunity where comunityseq = pseq;

    insert into tblcomment (commentseq, memberseq, comunityseq, commentcontents)
    values ((select max(commentseq) + 1 from tblcomment),  
            (select m.memberseq
            from tblmember m 
                inner join tblmemberinfo mi 
                    on m.memberinfoseq = mi.memberinfoseq 
                        inner join tblAdmin a
                            on a.memberinfoseq = mi.memberinfoseq
                                where mi.id = pid and a.pw = ppw),
            pseq, pcontents); 
    if
        vseq = 2 then
            update tblcomunity set answer = 'Y' where comunityseq = pseq;
        dbms_output.put_line('질문에 대한 답변을 하였습니다.');    
    else
        null;
    end if;
    
exception
    when others then
        if 
            vlogin = 0 then
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('잘못 로그인하였습니다.');
            dbms_output.put_line('---------------------------------------------------');
        elsif
            length(pcontents) > 100 then
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('내용이 100자를 초과하였습니다.');
            dbms_output.put_line('---------------------------------------------------');
        else
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('존재하지 않는 커뮤니티 번호입니다.');
            dbms_output.put_line('---------------------------------------------------');
        end if;        
end;
/


----------------------------------------------------------------------------------------
begin
    procAdminCommentAdd('dpgussafd', 'java1234', 18, '질문에 대한 답변은 이거입니다.');
end;
/
----------------------------------------------------------------------------------------



-- [관리자] 댓글 삭제
create or replace procedure procAdminCommentDel(
    pseq number
)
is
begin
    delete from tblcomment where commentseq = pseq;
exception
    when others then
        dbms_output.put_line('---------------------------------------------------');
        dbms_output.put_line('존재하지 않는 댓글 번호입니다.');
        dbms_output.put_line('---------------------------------------------------');
end;
/

--------------------------------------------------------------------------------
begin
    procAdminCommentDel(42);
end;
/
--------------------------------------------------------------------------------



-- [관리자] 댓글 수정
create or replace procedure procAdminCommentChange(
    pseq number,
    pcomment varchar2
)
is
begin
    update tblcomment set commentcontents = pcomment where commentseq = pseq;
exception
    when others then
        if
            length(pcomment) > 100 then
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('내용이 100자를 초과하였습니다.');
            dbms_output.put_line('---------------------------------------------------');
        else    
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('존재하지 않는 댓글 번호입니다.');
            dbms_output.put_line('---------------------------------------------------');
        end if;
end;
/


--------------------------------------------------------------------------------
begin
    procAdminCommentChange(30, '댓글수정');
end;
/
--------------------------------------------------------------------------------







        
