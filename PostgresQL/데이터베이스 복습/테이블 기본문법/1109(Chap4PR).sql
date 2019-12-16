/*
	4장 연습문제
*/

SELECT *
FROM GoodsProfit;
--1. create table으로 생성한 빈 테이블 Goods에 대해 다음 sql문을 실행해서 데이터를 등록해서 데이터를 등록하고 데이터를 접속하면? --
BEGIN TRANSACTION;
INSERT INTO Goods VALUES('0003', '30cm플라스틱자','사무용품',2500, 500,'2010-03-02');
INSERT INTO Goods VALUES('0004', '스테인리스보울','주방용품',3500, 800,'2010-03-02');
INSERT INTO Goods VALUES('0005', '넥타이','의류',3000, 750,NULL);
ROLLBACK;

-- 2. 5행이 선택된 Goods 테이블이 있는데 이대로 복사해서 10행으로 만들려고 하고 insert를 실행했다. 그 결과는? --
Insert into Goods SELECT * FROM Goods;
-- 키 제약에 위반되었기 때문에 에러가 발생하고 어떤 행도 선택이 되지 않는다. --

-- 상품 차익을 위한 테이블 --
Create Table GoodsProfit
(goods_id CHAR(4) NOT NULL,
 goods_name Varchar(100) NOT NULL,
 sell_price Integer,
 buy_price Integer,
 profit	Integer,
Primary Key(goods_id));
-- 3. 이 테이블에 Goods 테이블로부터 차익을 계산해서 다음과 같은 데이터를 등록하는 쿼리문을 작성한다. 차익은 판매단가 - 매입단가 --
-- 으로 계산하고 결과를 확인하시오 --
Insert into GoodsProfit(goods_id, goods_name, sell_price, buy_price, profit)
SELECT goods_id, goods_name, sell_price, buy_price, sell_price - buy_price From Goods;
select * from GoodsProfit;


-- 4. GoodsProfit테이블의 변경할 내용이 있다. 다음 조건을 충족하시오. --
/*
	1. T-shirt 판매단가를 500원 내린다.
	2. 1번을 반영해서 차익을 재계산한다. 
*/
UPDATE GoodsProfit
set sell_price = 2500
where goods_id = '0001';

Update GoodsProfit
SET profit = sell_price - buy_price
where goods_id = '0001';