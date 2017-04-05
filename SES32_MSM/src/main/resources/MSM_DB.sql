
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
	id number NOT NULL,
	u_id varchar2(20) NOT NULL,
	t_id number NOT NULL,
	text varchar2(100) NOT NULL,
	start_date date NOT NULL,
	end_date date,
	c_target varchar2(30) NOT NULL,
	c_location varchar2(200),
	alarm_yn char(1) DEFAULT 'F' NOT NULL,
	alarm_val number,
	content varchar2(300),
	period_yn char(1) DEFAULT 'F',
	/*dhtmlx scheduler rep_type
	 * Examples of the rec_type data:
		"day_3___" - each three days
		"month _2___" - each two months
		"month_1_1_2_" - second Monday of each month
		"week_2___1,5" - Monday and Friday of each second week*/
	rec_type varchar2(15),
	PRIMARY KEY (id)
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
	u_emergences number,
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




/*테스트 가계부 등록 */
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval,'aaa','2017-04-24','out','고정지출','스포츠/레저','통장',300000,'골프채');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval,'aaa','2017-03-14','out','지출','주거/통신','통장',300000,'핸드폰비용');

/*테스트 상세검색 */
select * from MSM_ACC_BOOK where u_id = 'aaa' 
and a_date between '17/03/20' and '17/05/30'
and main_cate in('백화점/패션','주거/통신')

/* 스케쥴 테스트데이터 */
insert into msm_calendar (id, u_id, t_id, text, start_date, end_date, c_target, content)
values (seq_msm_calendar.nextval,'aaa',3,'Title1', sysdate-3, sysdate-1, '홍길동', 'title1 - memo1');

insert into msm_calendar (id, u_id, t_id, text, start_date, end_date, c_target, content)
values (seq_msm_calendar.nextval,'aaa',3,'Title2', sysdate-5, sysdate-2, '홍길동', 'title2 - memo1');

insert into msm_calendar (id, u_id, t_id, text, start_date, end_date, c_target, content)
values (seq_msm_calendar.nextval,'aaa',3,'Title3', sysdate-7, sysdate-5, '홍길동', 'title3 - memo1');

insert into msm_calendar (id, u_id, t_id, text, start_date, end_date, c_target, content)
values (seq_msm_calendar.nextval,'aaa',3,'Title4', sysdate-11, sysdate-8, '홍길동', 'title4 - memo1');

insert into msm_calendar (id, u_id, t_id, text, start_date, end_date, c_target, content)
values (seq_msm_calendar.nextval,'aaa',3,'Title5', sysdate-12, sysdate-9, '홍길동', 'title5 - memo1');
