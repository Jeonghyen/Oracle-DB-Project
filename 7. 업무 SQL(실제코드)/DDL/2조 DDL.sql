-- 1차

-- 멤버정보 테이블
create table tblMemberInfo(
    memberInfoSeq number not null,
    name varchar2(20) not null,
    id varchar2(15) not null,
    pw varchar2(15) not null
);

alter table tblMemberInfo drop column pw;

alter table tblMemberInfo
    add CONSTRAINT tblMemberInfo_memberSeq_pk primary key(memberInfoSeq);

alter table tblMemberInfo
    add constraint tblMemberInfo_id_uq unique (id);

-- 출판사 테이블
CREATE TABLE tblPublisher(	
	publisherSeq NUMBER PRIMARY KEY,
	publisherName VARCHAR2(50) NOT NULL,
	CONSTRAINT uk_publisherName UNIQUE (publisherName)
);

-- 과목 테이블
CREATE TABLE tblSubject (
	subjectSeq NUMBER PRIMARY KEY,
	subjectName VARCHAR2(50) NOT NULL
);

-- 과정 목록 테이블
CREATE TABLE tblProcedureList(
	procedureListSeq NUMBER PRIMARY KEY,
	procedureName VARCHAR2(90) NOT NULL,
	CONSTRAINT uk_procedureName UNIQUE (procedureName)
);

-- 커뮤니티 카테고리
create table tblCommuCategory (

    categorySeq number not null primary key,
    categoryName number not null
    
);

ALTER TABLE tblCommuCategory MODIFY(categoryName varchar2(30));


--tblType 유형
create table tblType(

typeSeq number,
typeName varchar(30) not null 

);

alter table tblType
    add constraint tblType_typeSeq_pk primary key(typeSeq);
    
alter table tblType
    add constraint tblType_typeName unique(typeName);

alter table tblType 
    add constraint tblType_typeName_ck 
        check ( typeName in( '실기', '필기'));

-- 기자재 상태
create table tblEquipmentState (
    equipmentStateSeq   number not null primary key,
    stateName           varchar2(30) unique not null 
          
);
alter table tblEquipmentState add constraint tblEquipmentState_stateName_ck check (stateName in ('가능', '수리중', '불가능'));

-- 기자재 카테고리
create table tblEquipmentCategory (
    categorySeq         number not null primary key,
    categoryName        varchar2(100) unique not null

);

-- 강의실
create table tblRoom (
    roomSeq             number not null primary key,
    roomName            varchar2(15) not null,
    roomSum             number not null,

    constraint tblRoom_roomName_uq unique(roomName),
    constraint tblRoom_roomSum_ck check(roomSum <= 30)
          
);

-- 수강신청 상태
create table tblEnrolmentState (
    enrolmentStateSeq number not null,
    enrolmentStateName varchar2(30) not null );

alter table tblEnrolmentState
	add constraint tblEnrolmentState_pk primary key(enrolmentStateSeq);

alter table tblEnrolmentState
	add constraint tblEnrolmentStateName_unique unique(enrolmentStateName);

-- 수료상태
create table tblCompleteState (
    completeStateSeq number not null,
    completeState varchar2(30) not null );

alter table tblCompleteState
	add constraint tblCompleteState_pk primary key(completeStateSeq);

alter table tblCompleteState
	add constraint completeState_unique unique(completeState);

-- 근태상태
create table tblAttendanceState (
    attendanceStateSeq number not null,
    attendanceStateName varchar2(30) not null );

alter table tblAttendanceState
	add constraint tblAttendanceState_pk primary key(attendanceStateSeq);

alter table tblAttendanceState
	add constraint attendanceStateName_unique unique(attendanceStateName);



-- 2차

-- 교재 테이블
CREATE TABLE tblBook(
	bookSeq NUMBER PRIMARY KEY,
	bookName VARCHAR2(50) NOT NULL,
	publisherSeq NUMBER NOT NULL,
	CONSTRAINT uk_bookName UNIQUE (bookName),
	CONSTRAINT fk_publisherSeq FOREIGN KEY(publisherSeq) REFERENCES tblPublisher (publisherSeq)
);

-- 과정별 과목 테이블
CREATE TABLE tblProcedureSubject(
	procedureSubjectSeq NUMBER PRIMARY KEY,
	subjectSeq NUMBER NOT NULL,
	procedureListSeq NUMBER NOT NULL,
	CONSTRAINT fk_PsubjectSeq FOREIGN KEY(subjectSeq) REFERENCES tblSubject (subjectSeq),
	CONSTRAINT fk_PprocedureListSeq FOREIGN KEY(procedureListSeq) REFERENCES tblProcedureList (procedureListSeq)
);

-- 개설과정
create table tblOpeningProcedure (
   openingProcedureSeq number not null primary key, -- 개설과정 번호(PK)
   roomSeq number not null references tblRoom(roomSeq),-- 강의실 번호(FK)
   procedureList number not null references tblprocedureList(procedureListSeq),-- 과정목록 번호(FK)
  procedureStart date not null,-- 과정 시작 날짜
   procedureEnd date not null,-- 과정 종료 날짜

   studentSum number not null-- 교육생 인원
);

alter table tblopeningProcedure drop column procedureList;
alter table tblopeningProcedure add procedureSubjectSeq number not null;
alter table tblopeningProcedure
    add constraint procedureSubjectSeq_fk foreign key(procedureSubjectSeq) references tblProcedureSubject(procedureSubjectSeq);

alter table tblopeningProcedure drop column procedureSubjectSeq;
alter table tblopeningProcedure add procedureList number not null;
alter table tblopeningProcedure 
    add constraint procedureList_fk foreign key(procedureList) references tblprocedureList(procedureListSeq);
commit;

desc tblopeningProcedure;

-- 기자재 조회
create table tblEquipment (
    equipmentSeq        number not null primary key,
    equipmentName       varchar2(50) not null,
    roomSeq             number not null references tblRoom(roomSeq),
    categorySeq         number not null references tblEquipmentCategory(categorySeq),
    equipmentStateSeq   number not null references tblEquipmentState(equipmentStateSeq),
    importDate          date default sysdate not null

);

-- 3차
-- 교재 리스트 테이블
CREATE TABLE tblBookList (
	bookListSeq NUMBER PRIMARY KEY,
	bookSeq NUMBER NOT NULL,
	subjectSeq NUMBER NOT NULL,
	CONSTRAINT fk_subjectSeq FOREIGN KEY(subjectSeq) REFERENCES tblSubject(subjectSeq),
	CONSTRAINT fk_bookSeq FOREIGN KEY(bookSeq) REFERENCES tblBook (bookSeq)
);

-- 멤버 테이블
create table tblMember (

    memberSeq number not null primary key,
    openingProcedureSeq number not null REFERENCES tblOpeningProcedure(openingProcedureSeq),
    name VARCHAR2(15) not null,
    ID VARCHAR2(10) not null,
    PW VARCHAR2(15) not null,

    constraint tblMember_ID_uq unique(ID)
    
);
desc tblMember;
-- 컬럼삭제하기
alter table tblMember drop column openingProcedureSeq;
alter table tblMember drop column subjectScheduleSeq;

-- 컬럼 등록하기
alter table tblMember add memberInfoSeq number not null;
alter table tblMember add subjectScheduleSeq number not null;
alter table tblMember add enrolmentSeq number not null;

--제약 사항 등록하기
alter table tblMember
    add constraint tblMember_memberInfoSeq_fk foreign key(memberInfoSeq) references tblMemberInfo(memberInfoSeq);

alter table tblMember
    add constraint tblMember_subjectScheduleSeq_fk foreign key(subjectScheduleSeq) references tblSubjectSchedule(subjectScheduleSeq);

alter table tblMember
    add constraint tblMember_enrolmentSeq_fk foreign key(enrolmentSeq) references tblEnrolment(enrolmentSeq);

-- 제약 사항 수정하기
alter table tblMember modify subjectScheduleSeq null;
alter table tblMember modify enrolmentSeq null;
desc tblMember;
commit;

-- 컬럼 삭제하기
alter table tblMember drop column name;
alter table tblMember drop column ID;
alter table tblMember drop column PW;
alter table tblMember drop column memberInfoSeq;
-- 컬럼 삽입하기
alter table tblMember add memberInfoSeq number not null;
alter table tblMember
    add constraint tblMember_memberInfoSeq_fk foreign key (memberInfoSeq) references tblMemberInfo(memberInfoSeq);

alter table tblMember add subjectScheduleSeq number not null;
alter table tblMember 
    add constraint tblMember_subjectScheduleSeq_fk foreign key (subjectScheduleSeq) references tblSubjectSchedule(subjectScheduleSeq);

-- 4차
-- 관리자 테이블
create table tblAdmin (

    adminSeq number not null primary key,
    memberSeq number not null REFERENCES tblMember(memberSeq)
    
);

alter table tblAdmin add pw varchar2(15) not null;

alter table tblAdmin drop column memberSeq;
alter table tblAdmin add memberInfoSeq number not null;
alter table tblAdmin
    add constraint tblAdmin_memberInfoSeq_fk foreign key(memberInfoSeq) references tblMemberInfo(memberInfoSeq);


-- 커뮤니티 관리 및 조회 테이블
create table tblComunity (

    comunitySeq number not null primary key,
    memberSeq number not null REFERENCES tblMember(memberSeq),
    categorySeq number not null REFERENCES tblCommuCategory(categorySeq),
    writedate date default sysdate not null,
    contents VARCHAR2(300) not null,
    answer VARCHAR2(1) not null,
    commentSum NUMBER not null
    
);

-- 컬럼 수정
alter table tblComunity modify answer null;

alter table tblComunity add constraint tblComunity_answer_ck check (answer in ('Y', 'N'));

alter table tblComunity add subjectScheduleSeq number;
alter table tblComunity
    add constraint tblComunity_subjectScheduleSeq_fk foreign key(subjectScheduleSeq) reference tblsubjectSchedule(subjectScheduleSeq);

--tblTeacher 교사
create table tblTeacher (

    teacherSeq number not null,
    memeberSeq number not null,
    ssn varchar2(14) not null,
    tel varchar2(13) not null
);

alter table tblTeacher drop column memeberSeq;
alter table tblTeacher add memberInfoSeq number not null;
alter table tblTeacher
    add constraint tblTeacher_memberInfoSeq_fk foreign key(memberInfoSeq) references tblMemberInfo(memberInfoSeq); 

alter table tblTeacher
    add constraint tblTeacer_teacherSeq_pk primary key(teacherSeq);
 
alter table tblTeacher
    add constraint tblTeacher_memberSeq_fk 
        foreign key (memeberSeq) references tblMember(memberSeq);
        

 alter table tblTeacher
    add constraint tblTeacher_ssn_uq unique(ssn);
 
 alter table tblTeacher
    add constraint tblTeacher_ssn_ck
        check( ssn like '______-_______');
 
 
--12~13자리 
 alter table tblTeacher
    add constraint tblTeacher_tel_ck1
        check (tel like '___-____-____' or tel like '___-___-____');

-- 학생
create table tblStudent (
    studentSeq number not null,
    memberSeq number not null,
    ssn varchar2(14) not null,
    tel varchar2(13) not null,
    regDate date not null,
    employment varchar2(1)  not null);

alter table tblStudent drop column memberSeq;
alter table tblStudent add memberInfoSeq number not null;
alter table tblStudent
    add constraint tblStudent_memberInfoSeq_fk foreign key(memberInfoSeq) references tblMemberInfo(memberInfoSeq); 


alter table tblStudent
	add constraint tblStudent_studentSeq_pk primary key(studentSeq);

alter table tblStudent
    add constraint tblStudent_memberSeq_fk foreign key(memberSeq) references tblMember(memberSeq);

--
alter table tblStudent
    add constraint tblEStudent_employment_ck check (employment in ( 'Y', 'N'));


-- 5차
-- 가능 과목 테이블
create table tblPossibleSubject (
   possibleSubjectSeq number not null primary key, --가능 과목 번호(PK)
   teacherSeq number not null references tblTeacher(teacherSeq),--교사번호(FK)
   subjectSeq number not null references tblSubject(subjectSeq)--과목번호(FK)

);

-- 댓글 테이블
create table tblComment (

    commentSeq number not null primary key,
    comunitySeq number not null REFERENCES tblComunity(comunitySeq),
    memberSeq number not null REFERENCES tblMember(memberSeq),
    commentContents VARCHAR2(300) not null
    
);

-- 수강신청
create table tblEnrolment (
    enrolmentSeq number not null,
    openingProcedureSeq number not null,
    completeStateSeq number null,
    completeDate date null,
    enrolmentStateSeq number not null, 
    studentSeq number not null );


alter table tblEnrolment
	add constraint tblEnrolment_enrolmentSeq_pk primary key(enrolmentSeq);

alter table tblEnrolment
    add constraint openingProcedureSeq_fk foreign key(openingProcedureSeq) references tblOpeningProcedure(openingProcedureSeq);

--
alter table tblEnrolment
    add constraint completeStateSeq_fk foreign key(completeStateSeq) references tblCompleteState(completeStateSeq);

alter table tblEnrolment
    add constraint enrolmentStateSeq_fk foreign key(enrolmentStateSeq) references tblEnrolmentState(enrolmentStateSeq);

alter table tblEnrolment
    add constraint tblEnrolment_StudentSeq_fk foreign key(studentSeq) references tblStudent(studentSeq);


-- 6차
-- 과목 스케줄 조회
create table tblSubjectSchedule (
   subjectScheduleSeq number not null primary key, -- 과목 스케줄 번호(PK)
   subjectStart date not null,-- 과목 시작 날짜
   subjectEnd date not null,-- 과목 종료 날짜
  openingProcedureSeq number not null references tblopeningProcedure(openingProcedureSeq),-- 개설과정 번호(FK)
   possibleSubjectSeq number not null references tblpossibleSubject(possibleSubjectSeq)-- 가능 과목 번호(FK)

);

-- 과정평가
create table tblProcedureRate (
   procedureRate number not null primary key, -- 과정 평가 번호(PK)
   procedureDate date not null,-- 평가 날짜
   rateScore number null,-- 평점
  rateContents VARCHAR2(300) null,-- 평가 내용
   enrolmentSeq number not null references tblenrolment(enrolmentSeq),-- 수강신청 번호(FK)
 openingProcedureSeq number not null references tblopeningProcedure(openingProcedureSeq)-- 개설과정 번호(FK)
);

create table tblAttendance (
   attendanceSeq number not null primary key, -- 출결 번호(PK)
   enrolmentSeq number not null references tblEnrolment(enrolmentSeq),-- 수강신청 번호(FK)
   inTime VARCHAR2(30) null,-- 출근 시각
   outTime VARCHAR2(30) null,-- 퇴근 시각
   attendanceStateSeq number null references tblAttendanceState(attendanceStateSeq),-- 근태사항 번호(FK)
  attendancedate date not null -- 날짜
);

-- 7차
-- 시험
create table tblTest(

    testSeq number,
    subjectScheduleSeq number not null,
    testDate date not null,
    typeSeq number not null

);

alter table tblTest 
    add constraint tblTest_testSeq_pk primary key(testSeq);

alter table tblTest
    add constraint tblTest_subjectScheduleSeq_fk 
        foreign key (subjectScheduleSeq) references tblSubjectSchedule(subjectScheduleSeq);
        

        
alter table tblTest
    add constraint tblTest_typeSeq_fk 
        foreign key (typeSeq) references tblType(typeSeq);  
        
-- 8차

--tblQuestion
create table tblQuestion(

    questionSeq number not null,
    question VARCHAR2(300),
    testSeq  number not null

);

alter table tblQuestion 
    add constraint tblQusetion_questionSeq_pk 
        primary key(questionSeq);
        
alter table tblQuestion
    add constraint tblQuestion_testSeq_fk 
        foreign key (testSeq) references tblType(typeSeq);

-- tblPoint        
create table tblPoint (

    pointSeq number not null,
    testSeq number not null,
    writtenPoint number not null,
    practicalPoint number not null,
    attendancePoint number not null
    
);

alter table tblPoint 
    add constraint tblPoint_pointSeq_pk primary key(pointSeq);
    
alter table tblPoint
    add constraint tblPoint_testSeq_fk 
        foreign key (testSeq) references tblTest(testSeq);

alter table tblPoint drop column testSeq;
alter table tblPoint add subjectScheduleSeq number not null;
alter table tblPont
    add constraint tblPoint_subjectScheduleSeq_fk foreign key(subjectScheduleSeq) references tblSubjectSchedule(subjectScheduleSeq);

desc tblPoint;

--필기, 실기, 출석 비율 합 100 되어야함
alter table tblPoint 
    add constraint tblPoint_pointCount_ck
        check( writtenPoint + practicalPoint + attendancePoint = 100);
        
--출석 점수 최소 20점
alter table tblPoint 
    add constraint tblPoint_attendancePoint_ck
        check(attendancePoint >= 20);

-- 성적(수강신청 / 시험 테이블 생성 후 생성 가능)
create table tblScore (
    scoreSeq            number not null primary key,
    enrolmentSeq        number not null references tblEnrolment(enrolmentSeq),
    testSeq             number not null references tblTest(testSeq),
    practicalTestScore  number null,
    writtenTestScore    number null,
    attendanceScore     number null,
    scoreSum            number null,

    constraint tblScore_practicalTestScore_ck check (practicalTestScore <= 40),
    constraint tblScore_writtenTestScore_ck check (writtenTestScore <= 40),
    constraint tblScore_attendanceScore_ck check (attendanceScore <= 20),
    constraint tblScore_scoreSum_ck check (scoreSum <= 100)

);

-- 컬럼 삭제
alter table tblScore drop column enrolmentSeq;
alter table tblScore drop column testSeq;
alter table tblScore drop column practicalTestScore;
alter table tblScore drop column writtenTestScore;
alter table tblScore drop column attendanceScore;

-- 컬럼 삽입
alter table tblScore add writtenScoreSeq number null;
alter table tblScore add practicalScoreSeq number null;
alter table tblScore add attendanceScoreSeq number null;
alter table tblScore add pointSeq number null;

desc tblScore;

-- 제약사항 추가
alter table tblScore
    add constraint tblScore_writtenScoreSeq_fk foreign key(writtenScoreSeq) references tblWrittenScore(writtenScoreSeq);

alter table tblScore
    add constraint tblScore_practicalScoreSeq_fk foreign key(practicalScoreSeq) references tblPracticalScore(practicalScoreSeq);

alter table tblScore
    add constraint tblScore_attendanceScoreSeq_fk foreign key(attendanceScoreSeq) references tblAttendanceScore(attendanceScoreSeq);

alter table tblScore
    add constraint tblScore_pointSeq_fk foreign key(pointSeq) references tblPoint(pointSeq);

-- 필기점수 테이블
create table tblWrittenScore(
    writtenScoreSeq number not null,
    testSeq number not null,
    enrolmentSeq number not null,
    writtenScore number not null
);

alter table tblWrittenScore 
    add constraint tblWrittenScore_pk primary key (writtenScoreSeq);

alter table tblWrittenScore
    add constraint tblWrittenSocre_testSeq_fk foreign key(testSeq) references tblTest(testSeq);

alter table tblWrittenScore
    add constraint tblWrittenScore_enrolmentSeq_fk foreign key(enrolmentSeq) references tblEnrolment(enrolmentSeq);
    
-- 실기점수 테이블
create table tblPracticalScore(
    practicalScoreSeq number not null,
    testSeq number not null,
    enrolmentSeq number not null,
    practicalScore number not null
);

alter table tblPracticalScore
    add constraint tblPracticalScore_pk primary key (practicalScoreSeq);
    
alter table tblPracticalScore
    add constraint tblPracticalScore_testSeq_fk foreign key(testSeq) references tblTest(testSeq);
    
alter table tblPracticalScore
    add constraint tblPracticalScore_enrolmentSeq_fk foreign key(enrolmentSeq) references tblEnrolment(enrolmentSeq);

-- 출결 테이블
create table tblAttendanceScore(
    attendanceScoreSeq number not null,
    enrolmentSeq number not null,
    attendanceScore number not null
);

alter table tblAttendanceScore
    add constraint tblAttendanceScore_pk primary key (attendanceScoreSeq);

alter table tblAttendanceScore
    add constraint tblAttendanceScore_enrolmentSeq_fk foreign key(enrolmentSeq) references tblEnrolment(enrolmentSeq);
    
commit;

desc tblComunity;

select * from tblComunity;