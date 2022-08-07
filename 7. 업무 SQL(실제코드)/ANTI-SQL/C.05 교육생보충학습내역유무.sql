--C.05 교육생보충학습내역유무.sql
create or replace procedure procAddstudyst(

pid varchar2

)
is
vresult number;
vname varchar2(30);
begin


select count(*) into vresult from vwaddstudyst where "학생번호" = fnstudentseq(pid) ;
select "학생명"into vname from vwaddstudyst where "학생번호" = fnstudentseq(pid) ;


if vresult <> 0 then
dbms_output.put_line(vname || ' 님의 보충학습 내역이 있습니다.');
else
dbms_output.put_line(vname || '님의 보충학습 내역이 없습니다.');
end if;
end;

--실행
begin
 procaddstudyst('dkdghvrhd');
end;