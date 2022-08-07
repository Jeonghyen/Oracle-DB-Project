--C.05교유생보충학습조회.sql

select "학생명","과정명", "과목명", "필기점수", "실기점수", "출결점수", "총점","강의실" from vwaddstudyst where "학생번호" = fnstudentseq('dkdghvrhd');