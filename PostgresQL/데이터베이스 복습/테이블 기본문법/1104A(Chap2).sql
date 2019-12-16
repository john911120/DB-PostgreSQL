-- 데이터베이스 기본 구조를 가져온다. --
CREATE TABLE Goods
	(goods_id	CHAR(4)	NOT NULL,
	 goods_name	VARCHAR(100) NOT NULL,
	 goods_classify	VARCHAR(32) NOT NULL,
	 sell_price	INTEGER,
	 buy_price	INTEGER,
	 register_date DATE,
	 PRIMARY KEY	(goods_id));
	 
-- 데이터베이스의 내부를 구성하는 요소 --	 
BEGIN TRANSACTION;

INSERT INTO Goods VALUES('0001', 'T-Shirt', '의류', 1000, 500, '2010-02-11');
INSERT INTO Goods VALUES('0002', 'Punching', '사무용품', 500, 250, '2010-02-06');
INSERT INTO Goods VALUES('0003', 'Y-Shirt', '의류', 4000, 2800, '2010-02-11');
INSERT INTO Goods VALUES('0004', 'Knife', '주방용품', 3000, 2800, '2010-02-06');
INSERT INTO Goods VALUES('0005', 'SteamPot', '주방용품', 6800, 5000, '2010-02-07');
INSERT INTO Goods VALUES('0006', 'Fork', '주방용품', 500, NULL, '2010-02-07');
INSERT INTO Goods VALUES('0007', '도마', '주방용품', 880, 800, '2010-02-07');
INSERT INTO Goods VALUES('0008', 'BALLPEN', '사무용품', 100, NULL, '2010-02-11');

COMMIT;

-- Goods 테이블에서 4개의 열을 선택해서 출력하기 --

Select goods_id, goods_name, buy_price, sell_price
from Goods;

-- Goods 테이블의 모든 열을 출력한다. --
select *
from Goods;

-- 산술 연산자 --
Select goods_name, sell_price,
	sell_price * 2 AS "sell_price_x2"
FROM Goods;

-- null에는 주의가 필요하다 --
/* 
	null을 포함한 계산은 무조건 NULL이 되는 것이다.
	null을 0으로 나누는 경우는 예외적으로 에러가 아닌 null이 된다.
*/

-- from구가 select문에 반드시 필요한 것은 아니다. --
-- 단, select구만 사용해서 계산이 가능하다. --
SELECT (100 + 900) * 7 AS calculation;

-- 비교 연산자 -- 
SELECT goods_name, goods_classify
	FROM Goods
WHERE sell_price = 1000;

/*
	= 기호처럼 양변에 기술할 열이나 값을 비교하는 기호를 비교 연산자라고 한다.
	WHERE구에는 비교 연산자를 사용해서 다양한 조건식을 사용할 수 있다,
*/
-- 같지 않다는 부정 조건을 나타내는 비교연산자를 <>을 사용하면 된다. --
SELECT goods_name, goods_classify
	FROM Goods
WHERE sell_price <> 500;

-- 비교 연산자는 문자, 숫자, 날짜 등의 거의 모든 데이터형의 열과 값을 비교 가능하다. --
SELECT goods_name, goods_classify, sell_price
	FROM Goods
WHERE sell_price >= 1000;
/*
	부등호를 사용할 때는 반드시 앞, 등호가 뒤에 온다.
	=>,=<, ><라는 부등호는 사용하면 안된다. 에러난다.
	그리고 WHERE구 조건식에도 계산식을 사용할 수 있다.
*/
SELECT goods_name, goods_classify, buy_price
	FROM Goods
WHERE sell_price - buy_price >= 500;
