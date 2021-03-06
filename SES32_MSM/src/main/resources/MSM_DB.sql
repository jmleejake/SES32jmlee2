/* 테이블 초기화 및 테스트데이터 입력!! */

/* Drop Tables */

DROP TABLE MSM_TARGET_ACC_BOOK CASCADE CONSTRAINTS;
DROP TABLE MSM_ACC_BOOK CASCADE CONSTRAINTS;
DROP TABLE MSM_CALENDAR CASCADE CONSTRAINTS;
DROP TABLE MSM_TARGET CASCADE CONSTRAINTS;
DROP TABLE MSM_USER CASCADE CONSTRAINTS;

/* Drop Sequences */

DROP SEQUENCE SEQ_MSM_ACC_BOOK;
DROP SEQUENCE SEQ_MSM_CALENDAR;
DROP SEQUENCE SEQ_MSM_TARGET;
DROP SEQUENCE SEQ_MSM_TARGET_ACC;

/* Create Sequences */

CREATE SEQUENCE SEQ_MSM_ACC_BOOK;
CREATE SEQUENCE SEQ_MSM_CALENDAR;
CREATE SEQUENCE SEQ_MSM_TARGET;
CREATE SEQUENCE SEQ_MSM_TARGET_ACC;

/* Create Tables */

CREATE TABLE MSM_USER
(
	u_id varchar2(20) NOT NULL,
	u_pwd varchar2(20) NOT NULL,
	u_name varchar2(20) NOT NULL,
	u_email varchar2(40) NOT NULL,
	u_phone varchar2(30),
	u_birth varchar2(50),
	u_address varchar2(70),
	u_emergences number DEFAULT 0, -- ** 회원가입 시 초기 설정 및 이후 누적 잔여액수
	PRIMARY KEY (u_id)
);


CREATE TABLE MSM_ACC_BOOK
(
	a_id number NOT NULL,
	u_id varchar2(20) references MSM_USER on delete cascade ,
	a_date date,
	a_type varchar2(20) , -- **수입: IN / 지출: OUT / 비상: BIS
	main_cate varchar2(20) ,
	sub_cate varchar2(20),
	payment varchar2(15) ,
	price number ,
	a_memo varchar2(300),
	PRIMARY KEY (a_id)
);


CREATE TABLE MSM_CALENDAR
(
	id number NOT NULL,
	u_id varchar2(20)  references MSM_USER on delete cascade ,
	t_id number,
	text varchar2(100) NOT NULL,
	start_date date NOT NULL,
	end_date date,
	c_target varchar2(30),
	c_location varchar2(200),
	alarm_yn char(1) DEFAULT 'F' NOT NULL,
	alarm_val number,
	content varchar2(2000),
	repeat_type varchar2(20),
	repeat_end_date date,
	is_dbdata char(1),
	color varchar2(15),
	PRIMARY KEY (id)
);


CREATE TABLE MSM_TARGET
(
	t_id number NOT NULL,
	u_id varchar2(20)  references MSM_USER on delete cascade ,
	t_name varchar2(40) NOT NULL,
	t_date date NOT NULL,
	t_birth varchar2(20),
	t_group varchar2(20),
	PRIMARY KEY (t_id)
);


CREATE TABLE MSM_TARGET_ACC_BOOK
(
	ta_id number NOT NULL,
	t_id number,
	--t_id number  references MSM_TARGET on delete cascade ,
	ta_date date,
	ta_price number,
	ta_type char(3),
	ta_memo varchar2(300),
	PRIMARY KEY (ta_id)
);

/* 테스트 계정 */
insert into MSM_USER values ('aaa','aaa','이재민','jmlee825@naver.com','010-1234-5678','1986-08-25','서울 성북구', 0);
insert into MSM_USER values ('bbb','bbb','비지네스만','jmlee825@naver.com','010-1234-5678','1975-04-31','서울 강남구', 1000);
