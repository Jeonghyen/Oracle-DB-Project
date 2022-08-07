
-- A.03
-- 개설 과정 관리

-- procAddOpenProcManage
CREATE OR REPLACE PROCEDURE procAddOpenProcManage(
	pprocseq tblopeningprocedure.PROCEDURELIST%TYPE,
	pstartdate varchar2,
	penddate varchar2,
	proom tblopeningprocedure.ROOMSEQ%TYPE,
	pstudentsum tblopeningprocedure.STUDENTSUM%TYPE
)
IS
BEGIN 
	INSERT INTO tblopeningprocedure 
	VALUES (SEQOPENINGPROCEDURE.nextVal, proom, to_date(pstartdate,'YYYY-MM-DD'), to_date(penddate,'YYYY-MM-DD'), pstudentsum, pprocseq);

	dbms_output.put_line('------------------');
	dbms_output.put_line('등록이 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	procAddOpenProcManage(10,'2022-05-20','2022-06-20',7,25);
END;


-- procDelOpenProcManage
CREATE OR REPLACE PROCEDURE procDelOpenProcManage(
	pseq tblopeningprocedure.OPENINGPROCEDURESEQ%TYPE
)
IS 
BEGIN 
	DELETE FROM TBLOPENINGPROCEDURE WHERE OPENINGPROCEDURESEQ = pseq;
	
	dbms_output.put_line('------------------');
	dbms_output.put_line('삭제가 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	procDelOpenProcManage(21);
END;


-- procUpdateProcManage
CREATE OR REPLACE PROCEDURE procUpdateProcManage(
	pprocseq tblopeningprocedure.PROCEDURELIST%TYPE,
	pstartdate varchar2,
	penddate varchar2,
	proom tblopeningprocedure.ROOMSEQ%TYPE,
	pstudentsum tblopeningprocedure.STUDENTSUM%TYPE,
	pseq tblopeningprocedure.OPENINGPROCEDURESEQ%TYPE
    )
IS 
BEGIN 
	UPDATE TBLOPENINGPROCEDURE 
	SET ROOMSEQ = proom,
		PROCEDURESTART = to_Date(pstartdate,'YYYY-MM-DD'),
		PROCEDUREEND = to_Date(penddate,'YYYY-MM-DD'),
		STUDENTSUM = pstudentsum,
		PROCEDURELIST = pprocseq
	WHERE OPENINGPROCEDURESEQ = pseq;

	dbms_output.put_line('------------------');
	dbms_output.put_line('수정이 완료 되었습니다.');
	dbms_output.put_line('------------------');
END;

BEGIN
	procUpdateProcManage(9,'2022-05-21','2022-06-21',6,26,21);
END;






