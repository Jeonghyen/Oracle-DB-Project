

-- A.03
-- 개설 과정 관리


-- 개설 과정 관리
-- 출력 (과정명, 과정시작, 끝, 강의실명, 개설 과목 등록 여부, 교육생 등록인원)
SELECT 
	distinct pl.PROCEDURENAME AS "과정명", 
	op.PROCEDURESTART AS "시작일", 
	op.PROCEDUREEND AS "종료일", 
	r.ROOMNAME AS "강의실명", 
	count(e.STUDENTSEQ) AS "등록인원"
FROM TBLOPENINGPROCEDURE op	-- 개설 과정
	INNER JOIN TBLPROCEDURELIST pl	-- 과정명
		ON op.PROCEDURELIST = pl.PROCEDURELISTSEQ
			INNER JOIN TBLPROCEDURESUBJECT ps	-- 개설 과목
				ON pl.PROCEDURELISTSEQ = ps.PROCEDURELISTSEQ
					INNER JOIN TBLSUBJECT s	-- 과목명
						ON ps.SUBJECTSEQ = s.SUBJECTSEQ 
							INNER JOIN TBLROOM r	-- 강의실
								ON op.ROOMSEQ = r.ROOMSEQ
									INNER JOIN TBLENROLMENT e	-- 수강신청
										ON op.OPENINGPROCEDURESEQ = e.OPENINGPROCEDURESEQ
						GROUP BY op.OPENINGPROCEDURESEQ , pl.PROCEDURENAME , op.PROCEDURESTART , op.PROCEDUREEND , r.ROOMNAME , e.STUDENTSEQ
						ORDER BY pl.PROCEDURENAME;
					

-- 특정 개설 과정 선택 시 개설 과정에는 등록된 개설 과목 정보(과목명, 과목기간(시작 년월일, 끝년월일), 교재명, 교사명) 및
SELECT 
	distinct s.SUBJECTNAME AS "과목명", 
	ss.SUBJECTSTART AS "과목시작", 
	ss.SUBJECTEND AS "과목끝", 
	b.BOOKNAME AS "교재명", 
	mi.NAME AS "교사명"
FROM TBLOPENINGPROCEDURE op	-- 개설 과정
	INNER JOIN TBLPROCEDURELIST pl	-- 과정명
		ON op.PROCEDURELIST = pl.PROCEDURELISTSEQ
			INNER JOIN TBLPROCEDURESUBJECT ps	-- 개설 과목
				ON pl.PROCEDURELISTSEQ = ps.PROCEDURELISTSEQ
					INNER JOIN TBLSUBJECT s	-- 과목명
						ON ps.SUBJECTSEQ = s.SUBJECTSEQ 
							INNER JOIN TBLROOM r	-- 강의실
								ON op.ROOMSEQ = r.ROOMSEQ
									INNER JOIN TBLENROLMENT e	-- 수강신청
										ON op.OPENINGPROCEDURESEQ = e.OPENINGPROCEDURESEQ
											INNER JOIN TBLSUBJECTSCHEDULE ss	-- 과목 스케줄
												ON op.OPENINGPROCEDURESEQ = ss.OPENINGPROCEDURESEQ 
													INNER JOIN TBLBOOKLIST bl	-- 교재 리스트
														ON s.SUBJECTSEQ = bl.SUBJECTSEQ
															INNER JOIN TBLBOOK b	-- 교재명
																ON bl.BOOKSEQ = b.BOOKSEQ
																	INNER JOIN TBLPOSSIBLESUBJECT pss	-- 가능 과목
																		ON ss.POSSIBLESUBJECTSEQ = pss.POSSIBLESUBJECTSEQ
																			INNER JOIN TBLTEACHER t	-- 교사
																				ON pss.TEACHERSEQ = t.TEACHERSEQ
																					INNER JOIN TBLMEMBERINFO mi	-- 멤버 인포
																						ON t.MEMBERINFOSEQ = mi.MEMBERINFOSEQ
																WHERE op.OPENINGPROCEDURESEQ = '11'
                                                                order by ss.SUBJECTSTART;
												

-- 등록된 교육생 정보(교육생 이름, 주민번호 뒷자리, 등록일, 수료 및 중도 탈락)
SELECT 
	mi.NAME AS "교육생 이름" , 
	SUBSTR(s.SSN, -7) AS "주민번호 뒷자리" , 
	TO_CHAR(s.REGDATE, 'YYYY/MM/DD') AS "등록일" , 
	es.ENROLMENTSTATENAME AS "수료여부"
FROM TBLENROLMENT e
	INNER JOIN TBLSTUDENT s
		ON e.STUDENTSEQ = s.STUDENTSEQ
			INNER JOIN TBLMEMBERINFO mi
				ON s.MEMBERINFOSEQ = mi.MEMBERINFOSEQ
					INNER JOIN TBLENROLMENTSTATE es
						ON e.ENROLMENTSTATESEQ = es.ENROLMENTSTATESEQ;
						
		
-- 입력
INSERT INTO tblopeningprocedure 
	VALUES (SEQOPENINGPROCEDURE.nextVal, 강의실번호, to_date(시작일,'YYYY-MM-DD'), to_date(종료일,'YYYY-MM-DD'), 정원, 과정번호);
	
	
-- 수정
UPDATE TBLOPENINGPROCEDURE 
	SET ROOMSEQ = 강의실번호,
		PROCEDURESTART = to_Date(시작일,'YYYY-MM-DD'),
		PROCEDUREEND = to_Date(종료일,'YYYY-MM-DD'),
		STUDENTSUM = 정원,
		PROCEDURELIST = 과정정보
	WHERE OPENINGPROCEDURESEQ = 개설과정번호;
	
	
-- 삭제
DELETE FROM TBLOPENINGPROCEDURE WHERE OPENINGPROCEDURESEQ = 개설과정번호;
					
