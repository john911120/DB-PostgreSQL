/*
	7장 연습문제
*/

-- 1. 다음 select문의 결과를 확인하시오. --
select *
From Goods
UNION
select *
From Goods
Intersect
Select*
From Goods
Order by goods_id;

-- 테이블에 아무런 변화가 없다. --

-- 2. 외부 결합 결과에서는 점포id, 점포명이 null으로 출력되었다. null을 '불명확'으로 문자열로 바꿔보자 --
select Coalesce(TS.store_id, '불명확') AS store_id,
		Coalesce(TS.store_name, '불명확') AS store_name,
		S.goods_id,
		S.goods_name,
		S.sell_price
	From StoreGoods TS Right Outer Join Goods S
	On TS.goods_id = S.goods_id
	Order by store_id;
	
/*
	Coalesce는 자주 사용하는 함수로 외부 결합 결과에 존재하는 null을 변환하고 싶은 경우에 필요하니
	기억해두는 것이 좋다.
*/