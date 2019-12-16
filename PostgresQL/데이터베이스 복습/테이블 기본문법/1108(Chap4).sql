-- Goods 테이블에서 삭제된 테이블의 개수를 확인한다.(5개가 남아야한다.) --
select * from Goods;

-- update 예제 --
-- Goods 테이블의 등록일을 변경하기 --
UPDATE Goods 
SET register_date = '2010-02-28';

-- 변경된 데이터를 확인하기 --
select * from Goods ORDER BY goods_id;

-- 조건을 지정한 update (탐색형 update) --
UPDATE Goods
SET sell_price = sell_price * 10
WHERE goods_classify = '주방용품';

UPDATE Goods
SET sell_price = sell_price * 5
WHERE goods_classify = '사무용품';
-- 데이터 수정 확인하기 --
select * from Goods ORDER BY goods_id;

-- null 으로 갱신하기 --
UPDATE Goods
SET register_date = NULL
WHERE goods_id = '0008';
-- 변경 내용 확인하기 --
select * from Goods ORDER BY goods_id;

/*
-- 복수 열의 데이터를 갱신하는 방법 (코드량 많음) --
UPDATE Goods
Set sell_price = sell_price * 10
Where goods_classify = '의류';

UPDATE Goods
Set buy_price = buy_price / 2
Where goods_classify = '주방용품';


*/
-- 열과 쉼표로 구분하여서 나열한다. Case1 --
UPDATE Goods
SET sell_price = sell_price * 10,
	buy_price = buy_price /2
WHERE goods_classify = '주방용품';

-- 열을 괄호로 감싸서 리스트로표현하기 Case2 --
UPDATE Goods
SET (sell_price, buy_price) = (sell_price * 10, buy_price / 2)
Where goods_classify = '주방용품';

-- 변경내용 확인하기 --
SELECT * FROM Goods ORDER BY goods_id;

-- 주방용품 판매가격 변경 --
UPDATE Goods
Set sell_price = sell_price / 100
WHERE goods_classify = '주방용품';

-- 취급 상품 갱신 트랜잭션 --
-- 포크 판매단가를 내린다. (-1000) --
-- 볼펜 판매단가를 올린다. (+400) --
update Goods
SET sell_price = sell_price - 1000
WHERE goods_name = 'Fork';

UPDATE Goods
SET sell_price  = sell_price + 400
WHERE goods_name = 'BALLPEN';

-- 변경된 데이터 확인하기 --
select *
from Goods;

-- 트랜잭션 만들기 --
BEGIN TRANSACTION;

update Goods
SET sell_price = sell_price + 2000
WHERE goods_name = 'T-Shirt';

UPDATE Goods
SET sell_price  = sell_price + 1500
WHERE goods_name = 'Punching';


ROLLBACK;
-- commit; --

-- 저장된 데이터 확인하기 --
select * from Goods;