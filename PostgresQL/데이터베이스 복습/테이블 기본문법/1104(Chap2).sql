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

-- 열에 별명을 넣어보자 --
-- 한글 별명을 넣으려면 ""를 사용해야한다. --
Select goods_id AS "상품id", 
		goods_name AS "상품name", 
		buy_price AS "매입 단가"
from Goods;

-- 상수 출력하기 --
SELECT '상품' AS munja, 38 AS num, '2009-02-24' AS nalja, goods_id,
		goods_name
FROM Goods;

-- 결과에서 중복 행을 제거하기 --
SELECT DISTINCT goods_classify
FROM Goods;

SELECT DISTINCT goods_classify, register_date
FROM Goods;

-- goods_classify 열이 '의류'인 행을 선택하는 select문 --
SELECT goods_name, goods_classify
FROM Goods
WHERE goods_classify = '의류';

-- 검색 조건에 사용한 열을 출력하지 않아도 상관 없다. --
SELECT goods_name
FROM Goods
WHERE goods_classify = '의류';

-- 구의 작성 순서를 맘대로 변경하면 에러가 발생한다. --
SELECT goods_name, goods_classify
WHERE goods_classify = '의류'
FROM Goods;