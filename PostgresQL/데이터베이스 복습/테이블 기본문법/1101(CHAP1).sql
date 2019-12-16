CREATE DATABASE shop;

CREATE TABLE Goods
	(goods_id	CHAR(4)	NOT NULL,
	 goods_name	VARCHAR(100) NOT NULL,
	 goods_classify	VARCHAR(32) NOT NULL,
	 sell_price	INTEGER,
	 buy_price	INTEGER,
	 register_date DATE,
	 PRIMARY KEY	(goods_id));
-- 테이블을 삭제하려면 drop table을 사용하면 된다. --
/*
   drop문을 사용하게되면 테이블을 복구 할 수 없다는 것을 유념하기바란다 .
   drop문을 사용하기전에 꼼꼼한 확인은 필수
*/

-- 데이터의 열을 추가하려면 alter table을 사용하면 된다. --
/* 오라클에서는 ADD COLUMN을 붙여야하며 그 외의 데이터베이스 프로그램에서는
column을 붙이지 않는다.
*/

-- 길이가 100인 가변 문자열을 저장하는 good_name_eng열을 추가시킨다 . --
ALTER TABLE Goods ADD COLUMN goods_name_eng VARCHAR(100);

-- 테이블의 열을 삭제하려면 ALTER TABLE을 사용하면 된다. --
-- 열을 추가하는 ALTER TABLE과같이 열을 삭제할 때도 COLUMN을 붙여줘야한다. --
-- DROP 관련된 쿼리는 매번강조하지만 복구가되지  않는다. 그래서 작업할때는 신중해야한다. --
ALTER TABLE Goods DROP COLUMN goods_name_eng;
