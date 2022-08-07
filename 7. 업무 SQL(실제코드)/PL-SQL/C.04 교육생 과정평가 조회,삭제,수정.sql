--C.04 교육생 과정평가 조회,삭제,수정.sql

--자신이 쓴 평가 삭제
delete from tblprocedurerate where procedurerate = fngetenrol('xklhqjwzvv');

--자신이 쓴 평가 수정
update tblprocedurerate set proceduredate =(sysdate), ratescore = 5, ratecontents = ('내용') 
where enrolmentseq = fngetenrol('xklhqjwzvv'); 


--자신이 쓴 평가 조회

select proceduredate, ratescore, ratecontents from tblprocedurerate where enrolmentseq = fngetenrol('dkdghvrhd');
