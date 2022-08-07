--c.02 교육생 출결정보 입력

create or replace procedure procAttendance(
pid varchar2,
pintime varchar2,
pouttime varchar2
)
is

begin

if to_char(sysdate, 'd') not in ('1','7') then  --주말 아닌 날짜 일 때
if to_date(pintime,'hh24:mi') > to_date('09:10','hh24:mi') then --출근시각이 9:10보다 후일 때 
if
to_date(pouttime,'hh24:mi') < to_date('17:40','hh24:mi') then --출근시각이 9:10보다 후이고 퇴근이 17:40앞일 때 지각조퇴
dbms_output.put_line('지각조퇴');
insert into tblAttendance values (SEQATTENDANCE10.nextval, fngetenrol('dkdghvrhd'), pintime, pouttime,3, sysdate);
else
dbms_output.put_line('지각');  
insert into tblAttendance values (SEQATTENDANCE10.nextval, fngetenrol('dkdghvrhd'), pintime, pouttime,2, sysdate);  --지각
end if;

elsif to_date(pintime,'hh24:mi') < to_date('09:10','hh24:mi') then --출근시각이 9:10보다 앞일 때
if to_date(pouttime,'hh24:mi') < to_date('17:40','hh24:mi') then  ---출근시각이 9:10보다 앞이고 퇴근시각이 17:40 앞일 때 조퇴
dbms_output.put_line('조퇴');
insert into tblAttendance values (SEQATTENDANCE10.nextval, fngetenrol('dkdghvrhd'), pintime, pouttime ,3, sysdate);
else
dbms_output.put_line('정상');  
insert into tblAttendance values (SEQATTENDANCE10.nextval, fngetenrol('dkdghvrhd'), pintime, pouttime,1, sysdate);  --정상
end if;
end if;

else
dbms_output.put_line('주말에는 출결 불가합니다.');
end if;

end;


--실행
begin
procattendance('dkdghvrhd','09:15','17:50');
end;



--출결입력 (외출,병가,기타)
select * from tblattendancestate;


create or replace procedure procattendancelse(

pid varchar2,
pintime varchar2,
pouttime varchar2,
pstate number
)
is
begin

if to_char(sysdate, 'd') not in ('1','7') then
if pstate in(4,5,6) then
insert into tblAttendance values (SEQATTENDANCE10.nextval, fngetenrol('dkdghvrhd'), pintime, pouttime,pstate, sysdate);
else
dbms_output.put_line('출결상태번호를 ( 4.외출 5.병가 6.기타) 중에서 입력해주세요.');
end if;

else
dbms_output.put_line('주말에는 출결 불가합니다.');
end if;
end;

--실행
begin
procattendancelse('dkdghvrhd','09:00','14:50',6);
end;
