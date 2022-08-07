
-- A04				
-- 개설 과목 관리


-- 출력 (과정명, 과정시작끝, 강의실, 과목명, 과목시작끝, 교재명, 교사명)
SELECT
    distinct op.OPENINGPROCEDURESEQ,
     pl.PROCEDURENAME AS "과정명", 
	op.PROCEDURESTART AS "과정시작" , 
	op.PROCEDUREEND AS "과정끝" , 
	r.ROOMNAME AS "강의실" , 
	s.SUBJECTNAME AS "과목명" , 
	ss.SUBJECTSTART AS "과목시작" , 
	ss.SUBJECTEND AS "과목끝" , 
	b.BOOKNAME AS "교재명",
	mi.NAME AS "교사"
FROM TBLOPENINGPROCEDURE op
	INNER JOIN TBLPROCEDURELIST pl	-- 과정명
		ON op.PROCEDURELIST = pl.PROCEDURELISTSEQ
			INNER JOIN TBLPROCEDURESUBJECT ps
				ON pl.PROCEDURELISTSEQ = ps.PROCEDURELISTSEQ
					INNER JOIN TBLSUBJECT s	-- 과목명
						ON ps.SUBJECTSEQ = s.SUBJECTSEQ
							INNER JOIN TBLBOOKLIST bl	
								ON s.SUBJECTSEQ = bl.SUBJECTSEQ
									INNER JOIN TBLBOOK b
										ON bl.BOOKSEQ = b.BOOKSEQ
											INNER JOIN TBLROOM r
												ON op.ROOMSEQ = r.ROOMSEQ
													INNER JOIN TBLSUBJECTSCHEDULE ss
														ON op.OPENINGPROCEDURESEQ = ss.OPENINGPROCEDURESEQ
															INNER JOIN TBLPOSSIBLESUBJECT pss
																ON s.SUBJECTSEQ = pss.SUBJECTSEQ 
																	INNER JOIN TBLTEACHER t 
																		ON pss.TEACHERSEQ = t.TEACHERSEQ 
																			INNER JOIN TBLMEMBERINFO mi
																				ON t.MEMBERINFOSEQ = mi.MEMBERINFOSEQ
                                                                                WHERE op.OPENINGPROCEDURESEQ = 11
                                                                                order by ss.SUBJECTSTART;
																			
													
-- 입력
INSERT INTO TBLPOSSIBLESUBJECT VALUES(TBLPOSSIBLESUBJECTSEQ.nextVal, 교사번호, 과목번호);
INSERT INTO TBLSUBJECTSCHEDULE VALUES(SEQSUBSCHEDULE.nextVal, to_Date(과목시작일,'YYYY-MM-DD'), to_Date(과목종료일,'YYYY-MM-DD'), 개설과정번호 , 가능과목번호);


-- 수정
UPDATE TBLSUBJECTSCHEDULE 
	SET SUBJECTSTART = to_date(과목시작일,'YYYY-MM-DD'),
		SUBJECTEND = to_date(과목종료일,'YYYY-MM-DD'),
		OPENINGPROCEDURESEQ = 개설과정번호,
		POSSIBLESUBJECTSEQ = 가능과목번호
	WHERE SUBJECTSCHEDULESEQ = 과목스케줄번호;

	UPDATE TBLPOSSIBLESUBJECT
	SET TEACHERSEQ = 교사번호,
		SUBJECTSEQ = 가능과목번호
	WHERE POSSIBLESUBJECTSEQ = 가능과목번호;


-- 삭제
DELETE FROM TBLSUBJECTSCHEDULE WHERE SUBJECTSCHEDULESEQ = 과목스케줄번호;
DELETE FROM TBLPOSSIBLESUBJECT WHERE POSSIBLESUBJECTSEQ = 가능과목번호;


