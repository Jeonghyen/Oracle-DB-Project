--C.03 교육생 커뮤니티 작성, 글삭제.sql

--댓글작성 
create or replace procedure procAddCommentSt(

pid varchar2,
pcomuseq number,
pcomment varchar2
)is
 cursor vcursor 
is select "글번호" from vwcomunity where "과정과목번호" = (select subjectscheduleseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = pid));
vmemberseq number;
vcomuseq number;
vcount number := 0;
begin

select memberseq into vmemberseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = pid);

open vcursor;

loop
fetch vcursor into vcomuseq;
if vcomuseq = pcomuseq then
insert into tblcomment values (seqcomment.nextval, pcomuseq, vmemberseq, pcomment);
vcount := vcount + 1;
end if;
exit when vcursor%notfound;
end loop;

close vcursor;

if vcount <> 1 then
dbms_output.put_line('글 번호를 올바르게 입력하세요.');
end if;

end;

--실행
begin
procaddcommentst ('dkdghvrhd',11,'감사합니다.');
end;


--글 작성


create or replace procedure procWriteComuSt(
pid varchar2,
pcategory number,
pcontents varchar2
)
is
vmemberseq number;
vsheduleseq number;
begin
select subjectscheduleseq,memberseq into vsheduleseq,vmemberseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = 'dkdghvrhd');

if pcategory in (2,3) then
insert into tblcomunity values (seqcomu.nextval, vmemberseq, pcategory ,sysdate, pcontents ,null,0,vsheduleseq);
else
    dbms_output.put_line('카테고리 번호를 올바르게 입력하세요.(2.질문, 3.잡담)');
end if;
end;


--실행
begin
    procwritecomuSt('dkdghvrhd',2,'안녕하세요');
end;



--글 삭제


create or replace procedure procdelComu(
pid varchar2,
pcomuseq number
)
is
begin
delete from tblcomunity where memberseq = 
(select memberseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = pid)) and comunityseq = pcomuseq ;

delete from tblcomment where comunityseq = pcomuseq;
end;

begin
    procdelcomu('dkdghvrhd' , 21);
end;




