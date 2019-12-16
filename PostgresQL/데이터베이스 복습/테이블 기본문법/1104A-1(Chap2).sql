/*
	문자열에 부등호를 사용 할 때 주의사항
	1. 정수2와 문자열'2'와는 엄연히 다른 값이다.
*/
-- 부등호 사용할 때 쓰이는 예제 테이블 만들기 --
CREATE TABLE chars(chr CHAR(3) NOT NULL, PRIMARY KEY(chr));
-- DML 데이터 등록하기 --
BEGIN TRANSACTION;

INSERT INTO chars VALUES('1');
INSERT INTO chars VALUES('2');
INSERT INTO chars VALUES('3');
INSERT INTO chars VALUES('10');
INSERT INTO chars VALUES('11');
INSERT INTO chars VALUES('222');

COMMIT;

-- 2보다 큰 데이터를 선택하는 SELECT문 --
-- 문자열형의 순서는 사전식을 원칙으로 한다. 숫자의 대소 관계와 혼동 해서는 안된다. --
SELECT chr
FROM chars
WHERE chr > '2';

-- NULL에 비교연산자는 사용할 수 없다. --
-- 매입단가가 2800원인 행을 선택하기 --
SELECT goods_name, buy_price
	FROM Goods
WHERE buy_price = 2800;

-- 매입단가가 2800원이 아닌 행을 선택하기 --
SELECT goods_name, buy_price
	FROM Goods
WHERE buy_price <> 2800;

-- 잘못된 SELECT문 1행도 선택 안된다. --
SELECT goods_name, buy_price
	FROM Goods
WHERE buy_price = NULL;

-- NULL인 행을 선택하기 --
SELECT goods_name, buy_price
	FROM Goods
WHERE buy_price IS NULL;

-- NULL이 아닌 행을 선택하기 --
SELECT goods_name, buy_price
	FROM Goods
WHERE buy_price IS NOT NULL;