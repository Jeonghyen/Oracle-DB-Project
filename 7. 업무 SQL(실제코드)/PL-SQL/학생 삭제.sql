CREATE OR REPLACE PROCEDURE procDelStudent(
    pid tblmemberinfo.id%TYPE,
    pssn tblstudent.ssn%TYPE
)
IS
BEGIN
    DELETE FROM tblmemberinfo WHERE id = pid;
    DELETE FROM tblstudent WHERE ssn = pssn;

    dbms_output.put_line('------------------');
	dbms_output.put_line('삭제가 완료 되었습니다.');
	dbms_output.put_line('------------------');

END;

BEGIN
    PROCDELSTUDENT('dfjkaemsllld', '990811-2212344');
END;

