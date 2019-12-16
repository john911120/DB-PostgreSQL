-- 테이블 행의 개수를 계산한다. --
Select COUNT(*)
From Goods;

-- NULL을 제외한 행의 수를 계산한다. --
SELECT Count(buy_price)
From Goods;

/*
	null을 포함한 열을 인수로 하는 경우, count(*)와 count(열명)의 결과는 상이하다.
	실습을위해 예제 테이블을 생성한다.
*/
Create Table NullTbl
(col_1 INTEGER);

INSERT INTO NullTbl VALUES (NULL);
INSERT INTO NullTbl VALUES (NULL);
INSERT INTO NullTbl VALUES (NULL);

select count(*), count(col_1)
from NullTbl;

-- 합계 구하기 --
select sum(sell_price), sum(buy_price)
from Goods;

-- 평균값 구하기 --
select avg(sell_price), avg(buy_price)
from Goods;

-- 최소값 최대값 구하기  --
select max(sell_price), max(buy_price), min(sell_price), min(buy_price), max(register_date), min(register_date)
from Goods;

-- 중복값 제외하기 distinct --
select Count(distinct goods_classify)
from Goods;

-- 행 수를 센 후에 중복값을 제외한다. --
SELECT DISTINCT COUNT(goods_classify)
From Goods;

-- distinct 유무에 따른 동작의 차이 [sum 함수] --
select sum(sell_price), sum(Distinct buy_price)
From Goods;