-- view select문만 저장하면 ok --
SELECT goods_classify, SUM(sell_price), SUM(buy_price)
From Goods
Group BY goods_classify;

-- View 만드는 방법 --
CREATE View GoodsSum(goods_classify, cnt_goods)
AS
Select goods_classify, COUNT(*)
From Goods
Group By goods_classify;

-- 만들어진 View 확인하기 --
SELECT goods_classify, cnt_goods
From GoodsSum;

-- View위에 View를 겹치기 --
CREATE View GoodsSumJim(goods_classify, cnt_goods)
AS
Select goods_classify, cnt_goods
From GoodsSum
Where goods_classify = '사무용품';

--작성 확인 --
Select goods_classify, cnt_goods
From GoodsSumJim;

/*
	이중 view를 만드는 것은 구문상 문제는 없지만 가능하면 사용을 자제하는 것을 권장한다.
	그 이유는 dbms에서는 view를 겹쳐서 사용하게되면 성능이 떨어지게 되기 때문이고 View가 익숙하지 않은 
	경우라면 1단 view를 사용하는 것을 권장한다.
*/

-- View 정의에는 ORDER by구는 사용 불가 --
-- 타 dbms에서는 인정하고 있지 않지만 postgresQL에서만 order by구를 사용할 수 있다. --

-- View 갱신 할수 있는 경우 --
CREATE View GoodsJim(goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
AS
Select *
From Goods
Where goods_classify = '사무용품';

-- VIEW에 행을 추가하기 --
INSERT INTO GoodsJim VALUES ('0009', '도장인주','사무용품', 2000, 10, '2010-03-15');

SELECT * FROM GoodsJim;
SELECT * FROM Goods;

-- VIEW 삭제하기 -- 
/*
	PostgreSQL에서는 다단 뷰의 작성 기반이 되는 View를 제거하려면 의존하는 View가 존재하면 에러가 발생한다.
	의존하는 View를 제거하는 cascade를 사용해서 제거해줘야한다.
*/
DROP VIEW GoodsSum CASCADE;

Delete from Goods Where goods_id = '0009';

-- 서브 쿼리 연습을 위한 예제 --
Select goods_classify, cnt_goods
FROM (SELECT goods_classify, COUNT(*) AS cnt_goods
	  From Goods
	  Group By Goods_classify) AS GoodsSum;
/*
	서브쿼리는 항상 안쪽 부터 먼저 실행된다.
	사칙 연산 방법을 생각하면 된다.()가 중복이라면 가장 안쪽 부터 먼저 실행하고 나서 바깥쪽 괄호 다음 괄호 밖을 실행한다.
	
*/
-- From 구안의 select 문[sub query]이 실행이된다. --
-- 앞의 결과를 가지고 바깥 쪽 select문을 실행시킨다. --

-- subquery 내포 계층 수를 늘려보기 --
SELECT goods_classify, cnt_goods
	FROM(SELECT *
		FROM(SELECT goods_classify, COUNT(*) AS cnt_goods
			FROM Goods
			GROUP BY goods_classify) AS GoodsSum
		WHERE cnt_goods = 2) AS GoodsSum2;
		
-- scalar subquery --
/* 
	반환 값이 단일 값이 되는 서브쿼리를 말한다.
	반드시 1행 1열만을 반환값으로 반환한다.
	Where 구에 스칼라 서브쿼리를 사용한다.
*/
/*
-- where구의 집약 함수는 사용할 수 없다. --
SELECT goods_id, goods_name, sell_price
	From Goods
	Where sell_price > AVG(sell_price)
*/	
-- 평균 판매단가를 구하는 스칼라 서브쿼리 --
SELECT AVG(sell_price)
FROM Goods;

-- 판매단가가 모든 상품의 평균단가보다 높은 상품을 선택한다 --
SELECT goods_id, goods_name, sell_price
From Goods
Where sell_price > (SELECT AVG (sell_price)From Goods);

-- 스칼라 서브쿼리 사용가능한 곳 --
-- SELECT 구에 스칼라 서브쿼리 사용하기 --
select goods_id, goods_name, sell_price, sell_price,
	(SELECT AVG(sell_price)From Goods) AS avg_price
From Goods;

-- having구에 스칼라 서브쿼리 사용하기 --
SELECT goods_classify, AVG(sell_price)
	From Goods
	Group By goods_classify
HAVING AVG(sell_price) > (SELECT AVG(sell_price)From Goods);

-- scalar subquery 주의사항 --
-- select문에 사용이 불가한 경우는 select문은 서브쿼리가 복수행을 반환하기 때문에 실행이 안된다.' --

-- 상관 서브쿼리 --
-- 상품분류별로 평균단가를 구하기 --
SELECT AVG(sell_price)
From Goods
GROUP By goods_classify;

-- 상관 서브쿼리를 사용해서 상품분류별로 평균 판매단가 비교하기 --
SELECT goods_classify, goods_name, sell_price
	From Goods AS S1
Where sell_price > (select avg(sell_price)
				   From Goods AS S2
				   Where S1.goods_classify = S2.goods_classify
				   Group By goods_classify);
				   
-- 