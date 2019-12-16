-- 1장 연습문제 --
/*
	1. 열을 가진 Adress_book테이블을 만드시오. 단, register_no열의 주 키 제약은 열 정의와는
	별도로 설정해야한다.
*/
Create Table Adress_book(register_no INTEGER NOT NULL,
						name VARCHAR(128) NOT NULL,
						address VARCHAR(256) NOT NULL,
						tel_no CHAR(10),
						mail_address CHAR(20),
						PRIMARY KEY(register_no));
						
/*
	2. Adress_book테이블에서 post_code열을 추가하는것을 잊었다. 추가하시요
*/
Alter table Adress_book ADD COLUMN post_code CHAR(8) NOT NULL;

-- 3. Adress_book테이블을 삭제하시오. --
Drop table Adress_book;

-- 4. Adress_book테이블을 다시 생성하시오.--
-- 테이블 생성은 불가하다. --