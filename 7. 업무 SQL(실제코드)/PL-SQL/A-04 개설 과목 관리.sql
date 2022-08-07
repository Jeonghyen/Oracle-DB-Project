
-- A.04			
-- 개설 과목 관리


-- procAddOpenSubj	
CREATE OR REPLACE PROCEDURE procAddOpenSubj(
	popenproc tblopeningprocedure.OPENINGPROCEDURESEQ%TYPE,
	psubjectstart varchar2,
	psubjectend varchar2,
	psubject tblpossiblesubject.SUBJECTSEQ%TYPE,
	pteacher tblpossiblesubject.TEACHERSEQ%TYPE
)
IS 
	vpossisubjseq NUMBER;
BEGIN 
	INSERT INTO TBLPOSSIBLESUBJECT VALUES(TBLPOSSIBLESUBJECTSEQ.nextVal, pteacher, psubject);
	SELECT max(POSSIBLESUBJECTSEQ)into vpossisubjseq FROM TBLPOSSIBLESUBJECT;
	INSERT INTO TBLSUBJECTSCHEDULE VALUES(SEQSUBSCHEDULE.nextVal, to_Date(psubjectstart,'YYYY-MM-DD'), to_Date(psubjectend,'YYYY-MM-DD'), popenproc , vpossisubjseq);

	dbms_output.put_line('------------------');
	dbms_output.put_line('등록이 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	procAddOpenSubj(21,'2022-05-20','2022-06-20',34,22);
END;

	
-- procDelOpenSubj
CREATE OR REPLACE PROCEDURE procDelOpenSubj(
	psubjsch tblsubjectschedule.SUBJECTSCHEDULESEQ%TYPE
)
IS 
	vpossseq NUMBER;
BEGIN
	SELECT POSSIBLESUBJECTSEQ INTO vpossseq FROM TBLSUBJECTSCHEDULE WHERE SUBJECTSCHEDULESEQ = psubjsch;
	DELETE FROM TBLSUBJECTSCHEDULE WHERE SUBJECTSCHEDULESEQ = psubjsch;
	DELETE FROM TBLPOSSIBLESUBJECT WHERE POSSIBLESUBJECTSEQ = vpossseq;
	dbms_output.put_line('------------------');
	dbms_output.put_line('삭제가 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	procDelOpenSubj(64);
END;


-- procUpdateOpenSubj
CREATE OR REPLACE PROCEDURE procUpdateOpenSubj(
	psubjschseq tblsubjectschedule.SUBJECTSCHEDULESEQ%TYPE,
	psubjectstart varchar2,
	psubjectend varchar2,
	popenproc tblsubjectschedule.OPENINGPROCEDURESEQ%TYPE,
	pposssubject tblsubjectschedule.POSSIBLESUBJECTSEQ%TYPE,
	pteacher tblpossiblesubject.TEACHERSEQ%TYPE,
	psubject tblpossiblesubject.SUBJECTSEQ%TYPE,
	ppossseq tblpossiblesubject.POSSIBLESUBJECTSEQ%TYPE
)
IS 
BEGIN 
	UPDATE TBLSUBJECTSCHEDULE 
	SET SUBJECTSTART = to_date(psubjectstart,'YYYY-MM-DD'),
		SUBJECTEND = to_date(psubjectend,'YYYY-MM-DD'),
		OPENINGPROCEDURESEQ = popenproc,
		POSSIBLESUBJECTSEQ = pposssubject
	WHERE SUBJECTSCHEDULESEQ = psubjschseq;

	UPDATE TBLPOSSIBLESUBJECT
	SET TEACHERSEQ = pteacher,
		SUBJECTSEQ = pposssubject
	WHERE POSSIBLESUBJECTSEQ = ppossseq;

	dbms_output.put_line('------------------');
	dbms_output.put_line('수정이 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	procUpdateOpenSubj(64,'2022-05-21','2022-06-21',16,11,5,26,65);
END;

	
	