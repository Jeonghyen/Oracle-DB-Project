CREATE OR REPLACE PROCEDURE procAddStudent(
	pid tblmemberinfo.id%TYPE,
    pname tblmemberinfo.name%TYPE,
    pssn tblstudent.ssn%TYPE,
	ptel tblstudent.tel%TYPE,
	pregdate tblstudent.regdate%TYPE,
	pemployment tblstudent.employment%TYPE,
    pmemberinfoseq tblstudent.memberinfoseq%TYPE
)
IS 
	vstudentseq NUMBER;
BEGIN
    INSERT INTO tblmemberinfo VALUES ((select max(tblmemberinfo.memberinfoseq) + 1 from tblmemberinfo), pname, pid);
    INSERT INTO tblstudent VALUES ((select max(tblstudent.studentseq) + 1 from tblstudent), pssn, ptel, pregdate, pemployment, pmemberinfoseq);
	SELECT max(MEMBERINFOSEQ) INTO vstudentseq FROM TBLMEMBERINFO WHERE memberinfoseq = vstudentseq;

    dbms_output.put_line('------------------');
	dbms_output.put_line('등록이 완료 되었습니다.');
	dbms_output.put_line('------------------');
END procAddStudent;

BEGIN
	PROCADDSTUDENT('이준니', 'dfjkaemsllld','990811-2212344', '010-8071-2384', '2022-05-09', 'N', 102);
END;



