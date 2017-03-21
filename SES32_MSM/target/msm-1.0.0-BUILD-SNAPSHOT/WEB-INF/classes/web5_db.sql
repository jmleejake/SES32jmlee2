DROP TABLE CUSTOMER;

CREATE TABLE CUSTOMER (
	CUSTID VARCHAR2(20) PRIMARY KEY,
	PASSWORD VARCHAR2(20) NOT NULL,
	NAME VARCHAR2(30) NOT NULL,
	EMAIL VARCHAR2(50),
	DIVISION VARCHAR2(20) CHECK (DIVISION = 'personal' or DIVISION = 'company') NOT NULL,
	IDNO VARCHAR2(20) UNIQUE,
	ADDRESS VARCHAR2(100)
);

insert into customer values ('aaa', 'aaa', '홍길동', 'aaa@gmail.com', 
'personal', '800101-1111111', '서울 강남구  삼성로 123');

DROP SEQUENCE SEQ_BOARD_WEB5;

CREATE SEQUENCE SEQ_BOARD_WEB5;

DROP TABLE BOARD_WEB5;

CREATE TABLE BOARD_WEB5 (
	BNO NUMBER PRIMARY KEY,
	CUSTID VARCHAR2(20) NOT NULL,
	TITLE VARCHAR2(100) NOT NULL,
	CONTENT VARCHAR2(3000) NOT NULL,
	READ_CNT NUMBER DEFAULT 0,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE,
	ORIGINAL_FILE VARCHAR2(200),
	SAVED_FILE VARCHAR2(100)
);

DROP SEQUENCE SEQ_REPLY_WEB5;

CREATE SEQUENCE SEQ_REPLY_WEB5;

DROP TABLE REPLY_WEB5

CREATE TABLE REPLY_WEB5 (
	REPNO NUMBER PRIMARY KEY,
	BNO NUMBER,
	CUSTID VARCHAR2(20) NOT NULL,
	TEXT VARCHAR2(500) NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE,
	CONSTRAINT REPLY_WEB5_FK FOREIGN KEY (BNO)
	REFERENCES BOARD_WEB5(BNO) ON DELETE CASCADE
)

-- 게시글 샘플데이터
insert into board_web5 (bno, custid, title, content)
values (seq_board_web5.nextval, 'aaa', '에이가 등록한 글', '글쓰기글쓰기글쓰기글쓰기글쓰기글쓰기');

insert into board_web5 (bno, custid, title, content)
values (seq_board_web5.nextval, 'aaa', '에이가 등록한 글2', '글쓰기22글쓰기글쓰22기글쓰22기글쓰기22글쓰기');

insert into board_web5 (bno, custid, title, content)
values (seq_board_web5.nextval, 'aaa', '에이가 등록한 글3', '글쓰기33글쓰기글33쓰기33글쓰33기글33쓰기글쓰기');

insert into board_web5 (bno, custid, title, content)
values (seq_board_web5.nextval, 'ccc', '씨가 등록한 글', '글쓰기글쓰기글쓰기글쓰기글쓰기글쓰기');

insert into board_web5 (bno, custid, title, content)
values (seq_board_web5.nextval, 'ccc', '씨가 등록한 글2', '글쓰기22글쓰기글쓰22기글쓰22기글쓰기22글쓰기');

insert into board_web5 (bno, custid, title, content)
values (seq_board_web5.nextval, 'ccc', '씨가 등록한 글3', '글쓰기33글쓰기글33쓰기33글쓰33기글33쓰기글쓰기');

insert into board_web5 (bno, custid, title, content)
values (seq_board_web5.nextval, 'bbb', '삐가 등록한 글', '글쓰기글쓰기글쓰기글쓰기글쓰기글쓰기');

insert into board_web5 (bno, custid, title, content)
values (seq_board_web5.nextval, 'bbb', '삐가 등록한 글2', '글쓰기22글쓰기글쓰22기글쓰22기글쓰기22글쓰기');

insert into board_web5 (bno, custid, title, content)
values (seq_board_web5.nextval, 'bbb', '삐가 등록한 글3', '글쓰기33글쓰기글33쓰기33글쓰33기글33쓰기글쓰기');

-- 댓글 샘플데이터
insert into reply_web5 (repno, bno, custid, text)
values (seq_reply_web5.nextval, 146, 'aaa', '댓댓글댓글댓글댓글글댓글');
insert into reply_web5 (repno, bno, custid, text)
values (seq_reply_web5.nextval, 146, 'bbb', '댓댓글댓글댓글댓글글댓글');

insert into reply_web5 (repno, bno, custid, text)
values (seq_reply_web5.nextval, 143, 'abc', '댓댓글댓글댓글댓글글댓글');
insert into reply_web5 (repno, bno, custid, text)
values (seq_reply_web5.nextval, 143, 'bbb', '댓댓글댓글댓글댓글글댓글');