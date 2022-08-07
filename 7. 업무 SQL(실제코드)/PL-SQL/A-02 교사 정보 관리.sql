
-- A.02
-- 교사 계정 관리


-- procAddTeacher
CREATE OR REPLACE PROCEDURE procAddTeacher(
	pname tblmemberinfo.NAME%TYPE,
	pid tblmemberinfo.ID%TYPE,
	pssn tblteacher.SSN%TYPE,
	ptel tblteacher.TEL%TYPE,
	psubnum tblsubject.SUBJECTSEQ%TYPE
)
IS
	vmembernum NUMBER; 
BEGIN 
	INSERT INTO TBLMEMBERINFO VALUES ((SELECT max(MEMBERINFOSEQ)+1 FROM TBLMEMBERINFO), pname, pid);
	SELECT MEMBERINFOSEQ into vmembernum FROM tblmemberinfo WHERE ID = pid; 
	INSERT INTO TBLTEACHER VALUES (seqTeacher.nextVal, pssn, ptel, vmembernum);
	INSERT INTO TBLPOSSIBLESUBJECT VALUES ((SELECT max(POSSIBLESUBJECTSEQ)+1 FROM TBLPOSSIBLESUBJECT), FNTEACHERSEQ(pid) , psubnum);
	
	dbms_output.put_line('------------------');
	dbms_output.put_line('등록이 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	PROCADDTEACHER('테스트','testid','901212-1012345','010-1234-1234',34);
END;

SELECT * FROM ALL_ERRORS WHERE name = 'PROCADDTEACHER';

SELECT * FROM TBLMEMBERINFO;
SELECT * FROM TBLTEACHER;
SELECT * FROM TBLPOSSIBLESUBJECT;


-- procDelTeacher
CREATE OR REPLACE PROCEDURE procDelTeacher(
	pid tblmemberinfo.ID%TYPE 
)	
IS 
	vseq NUMBER;
BEGIN
	vseq := fnteacherSeq(pid);
	DELETE FROM TBLPOSSIBLESUBJECT WHERE TEACHERSEQ = vseq;
	DELETE FROM TBLTEACHER WHERE TEACHERSEQ = vseq;
	DELETE FROM TBLMEMBERINFO WHERE ID = pid;

	dbms_output.put_line('------------------');
	dbms_output.put_line('삭제가 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	procDelTeacher('testid');
END;


-- procUpdateTeacher
CREATE OR REPLACE PROCEDURE procUpdateTeacher(
	-- 입력
	pname tblmemberinfo.NAME%TYPE,
	pid tblmemberinfo.ID%TYPE,
	pssn tblteacher.SSN%TYPE,
	ptel tblteacher.TEL%TYPE,
	psubnum tblsubject.SUBJECTSEQ%TYPE,
	-- 시퀀스
	pmemberinfoSeq tblmemberinfo.MEMBERINFOSEQ%TYPE,
	pteacherSeq tblteacher.TEACHERSEQ %TYPE
)
IS 
BEGIN 
	UPDATE TBLMEMBERINFO mi
	SET mi.NAME = pname,
		mi.ID = pid
	WHERE mi.MEMBERINFOSEQ = pmemberinfoSeq;

	UPDATE TBLTEACHER t
	SET t.SSN = pssn,
		t.TEL = ptel
	WHERE t.TEACHERSEQ = pteacherSeq;

	UPDATE TBLPOSSIBLESUBJECT pss
	SET pss.SUBJECTSEQ = psubnum
	WHERE pss.TEACHERSEQ = pteacherSeq;

	dbms_output.put_line('------------------');
	dbms_output.put_line('수정이 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	procUpdateTeacher('테스그','testiz','801212-1012345','010-7234-1234',34,111,22);
END;
