
/* Drop Tables */

DROP TABLE MSM_ACC_BOOK CASCADE CONSTRAINTS;
DROP TABLE MSM_CALENDAR CASCADE CONSTRAINTS;
DROP TABLE MSM_TARGET CASCADE CONSTRAINTS;
DROP TABLE MSM_TARGET_ACC_BOOK CASCADE CONSTRAINTS;
DROP TABLE MSM_USER CASCADE CONSTRAINTS;
DROP TABLE MSM_VOICE_VAL CASCADE CONSTRAINTS;



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

CREATE TABLE MSM_ACC_BOOK
(
	a_id number NOT NULL,
	u_id varchar2(20) NOT NULL,
	a_date date,
	-- **수입: IN 지출: OUT, 비상금: BIS
	a_type char(3) ,
	main_cate varchar2(20) ,
	sub_cate varchar2(20),
	payment varchar2(15) ,
	price number ,
	a_memo varchar2(100),
	PRIMARY KEY (a_id)
);


CREATE TABLE MSM_CALENDAR
(
	c_id number NOT NULL,
	u_id varchar2(20) NOT NULL,
	t_id number NOT NULL,
	c_title varchar2(100) NOT NULL,
	c_start_time date NOT NULL,
	c_end_time date,
	c_target varchar2(30) NOT NULL,
	c_location varchar2(200),
	alarm_yn char(1) DEFAULT 'F' NOT NULL,
	alarm_var number,
	c_memo varchar2(300),
	period_yn char(1) DEFAULT 'F',
	-- ** 매주: W 매월: M 매년: Y
	period_val char(1),
	PRIMARY KEY (c_id)
);


CREATE TABLE MSM_TARGET
(
	t_id number NOT NULL,
	t_name varchar2(40) NOT NULL,
	t_date date NOT NULL,
	t_birth varchar2(20),
	t_group varchar2(20),
	PRIMARY KEY (t_id)
);


CREATE TABLE MSM_TARGET_ACC_BOOK
(
	ta_id number NOT NULL,
	ta_date date,
	ta_price number,
	ta_type char(3),
	ta_memo varchar2(100),
	t_id number,
	PRIMARY KEY (ta_id)
);


CREATE TABLE MSM_USER
(
	u_id varchar2(20) NOT NULL,
	u_pwd varchar2(20) NOT NULL,
	u_name varchar2(20) NOT NULL,
	u_email varchar2(40) NOT NULL,
	u_phone varchar2(30),
	u_birth varchar2(50),
	u_address varchar2(70),
	PRIMARY KEY (u_id)
);


CREATE TABLE MSM_VOICE_VAL
(
	keyword varchar2(20),
	val varchar2(20)
);



/* Create Foreign Keys */

ALTER TABLE MSM_ACC_BOOK
	ADD FOREIGN KEY (u_id)
	REFERENCES MSM_USER (u_id)
;


ALTER TABLE MSM_CALENDAR
	ADD FOREIGN KEY (u_id)
	REFERENCES MSM_USER (u_id)
;



/* Comments */

COMMENT ON COLUMN MSM_ACC_BOOK.a_type IS '**수입: IN 지출: OUT, 비상금: BIS';
COMMENT ON COLUMN MSM_CALENDAR.period_val IS '** 매주: W 매월: M 매년: Y';




	/* 테스트 계정 */
insert into MSM_USER values ('aaa','aaa','aaa','aaa@aaa.com','010-1111-1111','1990-10-21','aaa');
CREATE TABLE MSM_ACC_BOOK
(
	a_id number NOT NULL,
	u_id varchar2(20) NOT NULL,
	a_date date,
	-- **수입: IN 지출: OUT, 비상금: BIS
	a_type char(3) ,
	main_cate varchar2(20) ,
	sub_cate varchar2(20),
	payment varchar2(15) ,
	price number ,
	a_memo varchar2(100),
	PRIMARY KEY (a_id)
);


/*테스트 가계부 등록 */

insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval,'aaa','2017-05-24','out','스포츠/레저','aaa','통장',300000,'골프채');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval,'aaa','2017-05-14','out','주거/통신','aaa','통장',300000,'핸드폰비용');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval,'aaa','2017-02-12','out','주거/통신','aaa','통장',3000000,'월세');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval,'aaa','2017-04-13','out','백화점/패션','aaa','통장',50000000,'명품');

/*테스트 상세검색 */
select * from MSM_ACC_BOOK where u_id = 'aaa' 
and a_date between '17/03/20' and '17/05/30'
and main_cate in('백화점/패션','주거/통신')
