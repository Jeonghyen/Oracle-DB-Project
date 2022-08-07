--C.03 교육생 커뮤니티 조회


--자신이 속한 커뮤니티 글 출력
/*
카테고리(질문/잡담)/제목/작성자명/작성날짜/내용/답변여부/댓글수를 출력할 수 있어야 한다.
*/
select "글번호", "카테고리명","작성자명","글내용", "답변여부","댓글수", "과정명" from vwcomunity
 where "과정과목번호" = (select subjectscheduleseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = 'dkdghvrhd')) ;


select * from tblattendancestate;

--카테고리별로 출력


select "글번호", "카테고리명","작성자명","글내용", "답변여부","댓글수","과정명" from vwcomunity
 where "과정과목번호" = (select subjectscheduleseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = 'dkdghvrhd')) and "카테고리번호" =2;

--


--자기가 작성한 글 출력

select "글번호", "카테고리명","작성자명","글내용", "답변여부","댓글수","과정명" from vwcomunity
 where "과정과목번호" = (select subjectscheduleseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = 'dkdghvrhd')) 
and "멤버번호" = ( select memberseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = 'dkdghvrhd'));



--댓글출력
select 
comunityseq as 글번호, 
(select name from tblmemberinfo where memberinfoseq =
(select memberinfoseq from tblmember where memberseq = c.memberseq)) as 작성자명,
commentcontents as 글내용 from tblcomment  c where  comunityseq = 13;


--댓글 수정
update tblcomment set commentcontents = ('수정내용') 
where memberseq = 
(select  memberseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = 'dkdghvrhd')) and commentseq = 33;


--댓글 삭제 > 글번호 선택
delete tblcomment where memberseq = (select  memberseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = 'dkdghvrhd')) and commentseq = 33;



--글 수정
update tblcomunity set writedate = sysdate, contents = ('수정내용') 
    where memberseq = 
(select memberseq from tblmember where memberinfoseq 
= (select memberinfoseq from tblmemberinfo where id = 'dkdghvrhd')) and comunityseq = 21;