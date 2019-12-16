/*
	8장 연습문제
*/
-- 1. 다음 select문을 실행해서 결과를 확인하시오 --
select goods_id, goods_name, sell_price,
	MAX(sell_price) Over (order by goods_id) AS current_max_price
	From Goods;
	
-- 2. Goods 테이블을 활용해서 등록일 오름차순으로 정렬한 경우의 각 날짜별 판매단가의 합을 구한다. --
-- 단, 등록일이 null인 레코드가 가장 처음에 오게한다.(다른 모든 날짜보다 오래된 데이터가 되게한다.) --
-- A type --
select register_date, goods_name, sell_price,
	Sum(sell_price) Over (order by register_date NULLS FIRST) AS current_sum_price
From Goods;

-- B type --
select register_date, goods_name, sell_price,
	sum(sell_price) over(order by coalesce (register_date, Cast('0001-01-01' as DATE)))AS current_sum_price
	From Goods;