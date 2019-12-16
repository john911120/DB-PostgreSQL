/*
	4장 실습을 위한 GoodsIns,GoodsCopy, GoodsClassify 라는 테이블을 만든다.
*/

CREATE TABLE GoodsIns
	(goods_id	CHAR(4)	NOT NULL,
	 goods_name	VARCHAR(100) NOT NULL,
	 goods_classify	VARCHAR(32) NOT NULL,
	 sell_price	INTEGER	DEFAULT 0,
	 buy_price	INTEGER,
	 register_date DATE,
	 PRIMARY KEY	(goods_id));
	 
CREATE TABLE GoodsCopy
	(goods_id	CHAR(4)	NOT NULL,
	 goods_name	VARCHAR(100) NOT NULL,
	 goods_classify	VARCHAR(32) NOT NULL,
	 sell_price	INTEGER,
	 buy_price	INTEGER,
	 register_date DATE,
	 PRIMARY KEY	(goods_id));
	 
-- GoodsIns테이블에 들어갈 데이터를 추가한다. --
INSERT INTO GoodsIns (goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
values('0001', 'T-Shirt', '의류', 1000, 500, '2010-02-21');

-- 여러 행에 넣을 데이터를 추가하기 --
INSERT INTO GoodsIns Values('0002', 'Punching', '사무용품', 500, 250, '2010-02-20'),
('0003', 'Y-Shirt', '의류', 4000, 2800, '2010-02-21'),
('0004', 'Knife', '주방용품', 3000, 2800, '2010-02-20'),
('0005', 'SteamPot', '주방용품', 6800, 5000, '2010-02-21');

-- 테이블에 데이터가 올바르게 들어갔는지 여부를 확인한다. --
select *
from GoodsIns;

-- 열 리스트 생략하기 --
INSERT INTO GoodsIns VALUES('0006', '도마', '주방용품', 900, 800, '2010-02-21');

-- null을 넣는다. --
INSERT INTO GoodsIns VALUES('0007', 'Fork', '주방용품', 700, NULL, '2010-02-20');

-- 삽입된 행을 확인하는 방법 --
Select * from GoodsIns Where goods_id = '0003';

-- 암묵적으로 기본값 삽입이 가능하다 --
INSERT INTO GoodsIns (goods_id, goods_name, goods_classify, buy_price, register_date) Values ('0008', 'SharpPencil', '사무용품', 1000, '2010-02-21');

-- 기본값이 설정이 되어있지 않는 경우 --
INSERT INTO GoodsIns (goods_id, goods_name, goods_classify, sell_price, register_date) Values ('0009', 'Eraser', '사무용품', 500, '2010-02-20');


-- 새로 만든 GoodsCopy에 기존 테이블에 저장 되어있는 데이터를 복사해보자 --
insert into GoodsCopy(goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
select goods_id, goods_name, goods_classify, sell_price, buy_price, register_date
from Goods;

-- GoodsCopy 테이블에 복사된 데이터의 수를 확인한다. --
select *
from GoodsCopy;

-- select 문 적용 범위 --
/* 
	GoodsClassify 테이블을 만들어서 적용 범위를 확인하자.
*/
CREATE TABLE GoodsClassify
	(goods_classify	VARCHAR(32) NOT NULL,
	 sum_sell_price	INTEGER,
	 sum_buy_price	INTEGER,
	 PRIMARY KEY	(goods_classify));
	 
-- 다른 테이블에서 데이터를 집약하여서 삽입하는 구문을 만들기 --
Insert into GoodsClassify (goods_classify, sum_sell_price, sum_buy_price)
Select goods_classify, sum(sell_price), sum(buy_price)
From Goods
Group by goods_classify;

-- GoodsClassify 데이터를 확인하자 --
select *
from GoodsClassify;

-- 삭제 대상을 제한하는 delete문 --
delete from Goods
Where sell_price >= 3000;

-- Goods 테이블에서 삭제된 테이블의 개수를 확인한다.(5개가 남아야한다.) --
select * from Goods;
