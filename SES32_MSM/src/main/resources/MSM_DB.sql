
/* Drop Tables */

DROP TABLE MSM_ACC_BOOK CASCADE CONSTRAINTS;
DROP TABLE MSM_CALENDAR CASCADE CONSTRAINTS;
DROP TABLE MSM_TARGET CASCADE CONSTRAINTS;
DROP TABLE MSM_TARGET_ACC_BOOK CASCADE CONSTRAINTS;
DROP TABLE MSM_USER CASCADE CONSTRAINTS;
DROP TABLE MSM_VOICE_VAL CASCADE CONSTRAINTS;
DROP TABLE MSM_SUP_ACC CASCADE CONSTRAINTS;



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
	a_type varchar2(20) , -- **수입: IN / 지출: OUT
	main_cate varchar2(20) ,
	sub_cate varchar2(20),
	payment varchar2(15) ,
	price number ,
	a_memo varchar2(100),
	PRIMARY KEY (a_id)
);

-- 경조사 등 비상 추가 지출에 대한 저축 통장 및 연간 지출 통장 개설
CREATE TABLE MSM_SUP_ACC
(
	u_id varchar2(20) NOT NULL,
	s_acc number DEFAULT 0, -- 저축 통장
	a_acc number DEFAULT 0, -- 연간 지출
	e_acc number DEFAULT 0, -- 비상금 별도 관리
	p_acc number DEFAULT 0  -- 순수 잔여금액 누적 관리
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
	u_emergences number DEFAULT 0, -- ** 회원가입 시 초기 또는 도중 변경 비상금 내역
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

 ALTER TABLE MSM_SUP_ACC
 	ADD FOREIGN KEY (u_id)
 	REFERENCES MSM_USER(u_id)
;

/* Comments */

COMMENT ON COLUMN MSM_ACC_BOOK.a_type IS '**수입: IN 지출: OUT';
COMMENT ON COLUMN MSM_CALENDAR.period_val IS '** 매주: W 매월: M 매년: Y';


/* 테스트 계정 */
insert into MSM_USER values ('adolftaehee','johan1456*','김태희','adolftaehee2016@gmail.com','010-1111-1111','1990-10-21','오사카부 교토시', 0);

/* 회원 통장 내역( 저축 통장, 연간 이벤트 대비 지출 통장, 비상금 누적 ) */
insert into MSM_SUP_ACC values('adolftaehee', 0, 0, 0, 0);

/*테스트 가계부 등록 */
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-01', 'in', '고정수입', '월급', '통장', 2000000, '월급');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-01', 'out', '고정지출', '주거비', '통장', 310000, '월세');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-01', 'out', '고정지출', '주거비', '통장', 70000, '光熱水道');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-01', 'out', '고정지출', '통화비', '통장', 70000, '핸드폰');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-03', 'out', '변동지출', '식비', '현금', 15000, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-05', 'out', '변동지출', '식비', '현금', 2000, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-11', 'out', '변동지출', '식비', '현금', 5000, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-17', 'out', '변동지출', '식비', '현금', 5300, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-22', 'out', '변동지출', '식비', '현금', 6000, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-30', 'out', '변동지출', '외식비', '현금', 75600, '마노셰프');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-30', 'out', '변동지출', '외식비', '현금', 150000, '고든램지');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-30', 'out', '변동지출', '유흥비', '현금', 54000, '노래방');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-13', 'out', '변동지출', '교통비', '교통카드', 25000, '버스 및 지하철');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-16', 'out', '변동지출', '생활용품', '현금', 7000, '문구류');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-17', 'out', '변동지출', '미용', '현금', 12000, '이발');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-03-20', 'out', '변동지출', '영화', '현금', 20000, '메가박스');

insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-01', 'in', '고정수입', '월급', '통장', 2000000, '월급');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-01', 'out', '고정지출', '주거비', '통장', 300000, '월세');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-01', 'out', '고정지출', '주거비', '통장', 68000, '光熱水道');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-01', 'out', '고정지출', '통화비', '통장', 68900, '핸드폰');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-03', 'out', '변동지출', '식비', '현금', 17000, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-05', 'out', '변동지출', '식비', '현금', 5000, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-07', 'out', '변동지출', '식비', '현금', 7400, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-11', 'out', '변동지출', '식비', '현금', 6320, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-12', 'out', '변동지출', '식비', '현금', 5300, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-12', 'out', '변동지출', '식비', '현금', 6320, '식자재');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-13', 'out', '변동지출', '외식비', '현금', 200000, '라센느');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-02', 'out', '변동지출', '교통비', '교통카드', 25000, '버스 및 지하철');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-12', 'out', '변동지출', '생활용품', '현금', 6500, '문구류');
insert into MSM_ACC_BOOK values(SEQ_MSM_ACC_BOOK.nextval, 'adolftaehee', '2017-04-12', 'out', '변동지출', '의료비', '현금', 6800, '감기 진찰');

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
