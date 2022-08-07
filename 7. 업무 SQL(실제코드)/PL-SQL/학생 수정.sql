CREATE OR REPLACE PROCEDURE procUpdateStudent(
    pid tblmemberinfo.id%TYPE,
    pname tblmemberinfo.name%TYPE,
    ptel tblstudent.tel%TYPE,
    pssn tblstudent.ssn%TYPE,
    
    pmemberinfoseq tblmemberinfo.memberinfoseq%TYPE,
    pstudentseq tblstudent.studentseq%TYPE
)
IS
BEGIN
    UPDATE tblmemberinfo m
    SET m.id = pid
    WHERE m.memberinfoseq = pmemberinfoseq;
    
    UPDATE tblmemberinfo m
    SET m.name = pname
    WHERE m.memberinfoseq = pmemberinfoseq;
    
    UPDATE tblstudent s
    SET s.tel = ptel
    WHERE s.studentseq = pstudentseq;
    
    UPDATE tblstudent s
    SET s.ssn = pssn
    WHERE s.studentseq = pstudentseq;
    
    dbms_output.put_line('------------------');
	dbms_output.put_line('수정이 완료 되었습니다.');
	dbms_output.put_line('------------------');

END;
BEGIN
    PROCUPDATESTUDENT('xklhqjwzv', '장창호', '010-8839-1724', '990104-1010209', 31, 21);
END;
