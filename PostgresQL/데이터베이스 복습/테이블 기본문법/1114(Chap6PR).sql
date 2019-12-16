/*
	6장 연습문제
*/
select * from Goods;

-- 1. 다음 sql문을 작성하고 결과를 확인하시오 --
select goods_name, buy_price
from Goods
Where buy_price NOT IN (200);

select goods_name, buy_price
from Goods
Where buy_price NOT IN (200, 250, 500, NULL);
-- not in 인수에 null을 포함되는 경우에는 어떠한 행도 출력되지 않는다.(sql에서 가장 위험한 동작이다.) --

-- 2. Goods가 들어있는 테이블에 있는 상품을 판매단가(sell_price)에 따라 다음과 같이 분류하고 결과를 확인하시오. --
/*
	1. 저가상품 : 판매단가 250원 이하
	2. 중가상품 : 판매단가 250원 이상 500원 이하
	3. 고가상품 : 판매단가 500원 이상	
*/

select sum(case when sell_price <= 250
		   Then 1 else 0 end) as low_price,
	   sum(case when sell_price between 250 and 500
		   Then 1 else 0 end) as mid_price,
	   sum(case when sell_price >= 500
		   Then 1 else 0 end) as high_price
		   From Goods;