-- 7장 집합 연산 --
-- 7장 실습을 위한 테이블 예제 --
/* Goods 테이블 확인 및 데이터 추가 
select * from Goods;
insert into Goods Values ('0003', 'Y-shirt', '의류', 4500, 2500, NULL);
insert into Goods Values ('0004', '스테인레스 수저', '주방용품', 5500, 3500, NULL);
insert into Goods Values ('0005', 'WIFI 공유기', '사무용품', 35000, 15000, NULL);
*/

select * from Goods2;
-- Goods2 예제 테이블 만들기 --
Create Table Goods2
( goods_id	CHAR(4)	NOT NULL,
  goods_name varchar(100) NOT NULL,
  goods_classify varchar(32) NOT NULL,
  sell_price	INTEGER,
  buy_price		INTEGER,
  register_date	DATE,
 Primary Key (goods_id));
 
  select * from Goods;
 -- Goods2 테이블에 데이터 넣기 --
 begin transaction;
 
insert into Goods2 Values ('0001', 'T-Shirt', '의류', 3000, 500, '2010-02-28');
insert into Goods2 Values ('0002', 'Punching', '사무용품', 4000, 250, '2010-02-28');
insert into Goods2 Values ('0003', 'Y-shirt', '의류', 4500, 2500, NULL);
insert into Goods2 Values ('0009', '벙어리장갑', '의류', 800, 500, NULL);
insert into Goods2 Values ('0010', '주전자', '주방용품', 2000, 1700, '2009-09-30');

rollback;
commit;

-- 데이터가 바르게 들어갔는지 확인한다. --
select * from Goods2;

-- 테이블 덧셈하기 --
select goods_id, goods_name
From Goods
where goods_classify = '주방용품'
Union
select goods_id, goods_name
From Goods2
where goods_classify = '주방용품'
order by goods_id;
/*
	집합 연산 주의사항
	1. 연산 대상이 되는 레코드 열의 수가 같아야한다.
	2. 덧셈 대상이 되는 레코드 열이 같은 데이터형이어야한다.
	3. select문은 어떤 것이든 지정이가능하다 . 그런데 order by구는 마지막에 하나만 가능하다.
*/


-- 중복행을 포함하는 all 연산자 --
select goods_id, goods_name
from Goods
UNION all
Select goods_id, goods_name
From Goods2;

-- 공통 부분 선택 intersect --
select goods_id, goods_name
from Goods
intersect
Select goods_id, goods_name
From Goods2
order by goods_id;


-- 레코드 뺄샘 except --
select goods_id, goods_name
from Goods
except
Select goods_id, goods_name
From Goods2
order by goods_id;

-- Goods2 레코드에서 Goods 레코드 빼기 --
select goods_id, goods_name
from Goods2
except
Select goods_id, goods_name
From Goods
order by goods_id;

-- join --
-- 2가지의 테이블을 내부 결합하기 (Inner Join) --
select TS.store_id, TS.store_name, TS.goods_id, S.goods_name, S.sell_price -- 결합을 사용하는경우 select구의열은  모두 테이블 별명, 열명 형식으로 기술한다. --
From StoreGoods AS TS INNER JOIN Goods AS S -- 내부 결합 from구에 복수의 테이블을 적는다. --
ON TS.goods_id = S.goods_id; -- 내부결합은 on이 필수, from, where구 사이에 기술해야한다. --

-- 내부 결함과 where구 조합 --
select TS.store_id, TS.store_name, TS.goods_id, S.goods_name, S.sell_price 
From StoreGoods AS TS INNER JOIN Goods AS S 
ON TS.goods_id = S.goods_id
where TS.store_id = '000A';

-- outer join --
select TS.store_id, TS.store_name, S.goods_id, S.goods_name, S.sell_price 
From StoreGoods AS TS Right OUTER JOIN Goods AS S 
ON TS.goods_id = S.goods_id;

select TS.store_id, TS.store_name, S.goods_id, S.goods_name, S.sell_price 
From Goods AS S Left OUTER JOIN StoreGoods AS TS 
ON TS.goods_id = S.goods_id;
/*
	외부 결합 포인트 = 한쪽 테이블 정보가 모두 출력한다.
	어느 쪽의 테이블을 마스터로 할것인가?
	외부 결합에서 마스터 테이블 지정은 left, right으로 사용한다. 그런데 어느쪽을 사용해도 결과는 같다.
*/

-- 3개 이상 테이블 결합하기 --
-- stockgoods 테이블, 데이터 등록 (실습을위한 테이블) --
drop table StockGoods;
Create Table StockGoods
(storage_id	CHAR(4)	Not NULL,
 goods_id	CHAR(4) NOT NULL,
 stock_num	INTEGER NOT NULL,
 PRIMARY KEY (storage_id, goods_id));
 
 begin transaction;
 
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S001', '0001', 0);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S001', '0002', 120);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S001', '0003', 200);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S001', '0004', 3);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S001', '0005', 0);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S001', '0006', 99);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S001', '0007', 999);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S001', '0008', 200);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S002', '0001', 10);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S002', '0002', 25);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S002', '0003', 34);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S002', '0004', 19);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S002', '0005', 99);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S002', '0006', 0);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S002', '0007', 0);
 insert into StockGoods(storage_id, goods_id, stock_num) VALUES ('S002', '0008', 18);
 
 COMMIT;
 
 -- 데이터 확인하기 --
  select * from StockGoods;
  
  -- 3개의 테이블을 내부 결합하기 --
  SELECT TS.store_id, TS.store_name, TS.goods_id, S.goods_name, S.sell_price,
  ZS.stock_num
  	From StoreGoods AS TS INNER JOIN Goods AS S
	ON TS.goods_id = S.goods_id
		INNER JOIN StockGoods AS ZS
			ON TS.goods_id = ZS.goods_id
		WHERE ZS.storage_id = 'S001';
		
 -- 크로스 결합 (현업에서 사용하지 않는 이유는 활용도가 낮고 결과 행이 많아서 연산에 시간과 장비가 많이 소모된다.) --
 select TS.store_id, TS.store_name, TS.goods_id, S.goods_name
 From StoreGoods AS TS CROSS JOIN Goods AS S;
 
 -- 옛날 구문을 사용한 내부 결합 --
 SELECT TS.store_id, TS.store_name, TS.goods_id, S.goods_name, S.sell_price
 From StoreGoods TS, Goods S
 Where TS.goods_id = S.goods_id
 AND TS.store_id = '000A';
 /*
  	결합의 옛 작성법이나 개별 구문은 사용하지 않는 것이 좋다. 하지만 해독 방법은 알아야한다.
 */
 
 
 -- 관계 나눗셈을 위한 예제 테이블 2개, 데이터 작성(Skills / EmpSkills) --
 
 CREATE TABLE skills
 (skill VARCHAR(32),
 PRIMARY KEY(skill));
 
  CREATE TABLE EmpSkills
 (emp VARCHAR(32),
  skill VARCHAR(32),
 PRIMARY KEY(emp, skill));
 
 Begin Transaction;
 
 insert into Skills VALUES ('Oracle');
 insert into Skills VALUES ('UNIX');
 insert into Skills VALUES ('Java');
 
 insert into EmpSkills VALUES ('사원1', 'Oracle');
 insert into EmpSkills VALUES ('사원1', 'UNIX');
 insert into EmpSkills VALUES ('사원1', 'Java');
 insert into EmpSkills VALUES ('사원1', 'C#');
 insert into EmpSkills VALUES ('사원2', 'Oracle');
 insert into EmpSkills VALUES ('사원2', 'UNIX');
 insert into EmpSkills VALUES ('사원2', 'Java');
 insert into EmpSkills VALUES ('사원3', 'UNIX');
 insert into EmpSkills VALUES ('사원3', 'Oracle');
 insert into EmpSkills VALUES ('사원3', 'PHP');
 insert into EmpSkills VALUES ('사원3', 'Perl');
 insert into EmpSkills VALUES ('사원3', 'C++');
 insert into EmpSkills VALUES ('사원4', 'Perl');
 insert into EmpSkills VALUES ('사원5', 'Oracle');
 
 select * from EmpSkills;
 select * from Skills;
 
 ROLLBACK;
 COMMIT;
 
 -- 3가지 분야의 스킬을 모두 가지고 있는 사원을 선택한다. --
 select DISTINCT emp
 From EmpSkills ES1
 Where not Exists
 	(select skill
	From Skills
	Except
	Select skill
	From EmpSkills ES2
	Where ES1.emp = ES2.emp);
 