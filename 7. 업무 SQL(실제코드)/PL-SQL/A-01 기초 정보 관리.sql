
-- A.01
-- 기초 정보 관리


-- procAddBaseInfo
CREATE OR REPLACE PROCEDURE procAddBaseInfo(
	pprocedureName tblprocedurelist.PROCEDURENAME%TYPE,
	psubjectName tblsubject.SUBJECTNAME%TYPE,
	proomname tblroom.ROOMNAME%TYPE,
	proomsum tblroom.ROOMSUM%TYPE,
	pbookname tblbook.BOOKNAME%TYPE,
	ppublishername tblpublisher.PUBLISHERNAME%TYPE 
)
IS 
	vpublisherseq NUMBER;
BEGIN
	INSERT INTO TBLPROCEDURELIST VALUES ((SELECT max(PROCEDURELISTSEQ)+1 FROM TBLPROCEDURELIST), pprocedureName);
	INSERT INTO TBLSUBJECT VALUES (seqSubject.nextVal, psubjectName);
	INSERT INTO TBLROOM VALUES ((SELECT max(ROOMSEQ)+1 FROM TBLROOM), proomname, proomsum);
	INSERT INTO TBLPUBLISHER VALUES ((SELECT max(PUBLISHERSEQ)+1 FROM TBLPUBLISHER), ppublishername);
	SELECT PUBLISHERSEQ INTO vpublisherseq FROM TBLPUBLISHER WHERE PUBLISHERNAME = ppublishername;
	INSERT INTO TBLBOOK VALUES ((SELECT max(BOOKSEQ)+1 FROM TBLBOOK), pbookname, vpublisherseq);
	dbms_output.put_line('------------------');
	dbms_output.put_line('등록이 완료 되었습니다.');
	dbms_output.put_line('------------------');
END procAddBaseInfo;

BEGIN
	PROCADDBASEINFO('테스트과정', '테스트과목', '9강의실', 25, '테스트교재', '테스트출판사');
END;


-- procDelBaseInfo
CREATE OR REPLACE PROCEDURE procDelBaseInfo(
	pprocedureName tblprocedurelist.PROCEDURENAME%TYPE,
	psubjectName tblsubject.SUBJECTNAME%TYPE,
	proomname tblroom.ROOMNAME%TYPE,
	proomsum tblroom.ROOMSUM%TYPE,
	pbookname tblbook.BOOKNAME%TYPE,
	ppublishername tblpublisher.PUBLISHERNAME%TYPE 
)
IS
BEGIN
	DELETE FROM TBLBOOK WHERE BOOKNAME = pbookname;
	DELETE FROM TBLPUBLISHER WHERE PUBLISHERNAME = ppublishername;
	DELETE FROM TBLROOM WHERE ROOMNAME = proomname;
	DELETE FROM TBLSUBJECT WHERE SUBJECTNAME = psubjectName;
	DELETE FROM TBLPROCEDURELIST WHERE PROCEDURENAME = pprocedureName;

	dbms_output.put_line('------------------');
	dbms_output.put_line('삭제가 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	PROCDELBASEINFO('테스트과정', '테스트과목', '9강의실', 25, '테스트교재', '테스트출판사');
END;

SELECT * FROM ALL_ERRORS WHERE name = 'PROCDELBASEINFO';


-- procUpdateBaseInfo
CREATE OR REPLACE PROCEDURE procUpdateBaseInfo(
	-- 입력값
	pprocedureName tblprocedurelist.PROCEDURENAME%TYPE,
	psubjectName tblsubject.SUBJECTNAME%TYPE,
	proomname tblroom.ROOMNAME%TYPE,
	proomsum tblroom.ROOMSUM%TYPE,
	pbookname tblbook.BOOKNAME%TYPE,
	ppublishername tblpublisher.PUBLISHERNAME%TYPE, 
	
	-- 시퀀스
	pprocedureSeq tblprocedurelist.PROCEDURELISTSEQ%TYPE,
	psubjectSeq tblsubject.SUBJECTSEQ%TYPE,
	proomSeq tblroom.ROOMSEQ%TYPE,
	pbookSeq tblbook.BOOKSEQ%TYPE,
	ppublisherSeq tblpublisher.PUBLISHERSEQ%TYPE 
)
IS 
BEGIN
	UPDATE TBLPUBLISHER p 
	SET p.PUBLISHERNAME = ppublishername
	WHERE p.PUBLISHERSEQ = ppublisherSeq;
	
	UPDATE TBLBOOK b 
	SET b.BOOKNAME =  pbookname
	WHERE b.BOOKSEQ = pbookSeq;

	UPDATE TBLROOM r
	SET r.ROOMNAME = proomname,
		r.ROOMSUM = proomsum
	WHERE r.ROOMSEQ = proomSeq;

	UPDATE TBLSUBJECT s
	SET s.SUBJECTNAME = psubjectName
	WHERE s.SUBJECTSEQ = psubjectSeq;

	UPDATE TBLPROCEDURELIST pl
	SET pl.PROCEDURENAME = pprocedureName
	WHERE pl.PROCEDURELISTSEQ = pprocedureSeq;

	dbms_output.put_line('------------------');
	dbms_output.put_line('수정이 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	procUpdateBaseInfo('테1스트과정', '테1스트과목', '91강의실', 27, '테1스트교재', '테1스트출판사',11,34,7,31,19);
END;