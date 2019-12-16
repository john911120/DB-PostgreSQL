-- SQL 고급 처리 --
-- 윈도우 함수 --
-- Rank함수 --
SELECT goods_name, goods_classify, sell_price,
Rank ( ) Over (PARTITION BY goods_classify ORDER by sell_price) AS ranking
From Goods;

/*
	PARTITION : 순위를 정할 대상 범위를 설정한다.
	Order by : 어떤 일을 어떤 순서로 정할 것인가를 지정한다.
	PARTITION BY를 통해서 구분된 부분 집합을 윈도우라고 한다.
*/

-- PARTITION BY를 지정하지 않아도 된다. --
SELECT goods_name, goods_classify, sell_price,
Rank ( ) Over (ORDER by sell_price) AS ranking
From Goods;

-- rank, dense_rank, row_number 결과 비교하기 --
SELECT goods_name, goods_classify, sell_price,
	Rank ( ) Over (ORDER by sell_price) AS ranking,
	Dense_rank () Over (order by sell_price) AS dense_ranking,
	row_number () over (order by sell_price) AS row_num
From Goods;

-- sum, avg함수를 윈도우 함수로 사용 (집약함수) --
select goods_id, goods_name, sell_price,
	sum(sell_price) over (order by goods_id) as current_sum
From Goods;

select goods_id, goods_name, sell_price,
	avg(sell_price) over (order by goods_id) as current_avg
From Goods;

-- 집계 대상 레코드를 직전 3행 으로 --
select goods_id, goods_name, sell_price,
	avg(sell_price) over (order by goods_id rows 2 preceding ) as moving_avg
	From Goods;
	
-- 현재 레코드 전후 행을 집계대상에 포함시키기 --
select goods_id, goods_name, sell_price,
	avg(sell_price) over(order by goods_id rows between 1 preceding and 1 following) AS moving_avg
	From goods;
	
-- 2 가지 order by --
select goods_name, goods_classify, sell_price,
	RANK() OVER (ORDER BY sell_price) AS ranking
	From goods
	ORDER BY ranking;
	
	-- group by 으로는 합계행 구할 수 없다. --
	select goods_classify, sum(sell_price)
	from Goods
	Group by goods_classify;
	
-- 합계 행과 집약 결과를 별도로 구해서 union all으로 병합한다. --
select '합계' as goods_classify, sum(sell_price)
From Goods
UNION ALL
select goods_classify, sum(sell_price)
From Goods
Group by goods_classify;

-- roll up 으로 합계와 소계를 한번에 구하는 방법 --
select goods_classify, sum(sell_price) AS sum_price
FROM Goods
Group by ROLLUP(goods_classify);

-- group by에 등록일 추가하기 (roll up 유무) --
select goods_classify, register_date, sum(sell_price) AS sum_price
From Goods
GROUP BY goods_classify, register_date;

select goods_classify, register_date, sum(sell_price) AS sum_price
From Goods
GROUP BY ROLLUP (goods_classify, register_date);

-- grouping 함수를 활용해서 가짜 null값을 구하라 --
select Grouping(goods_classify) AS goods_classify,
	Grouping(register_date) AS register_date, sum(sell_price) AS sum_price
	From Goods
	GROUP BY ROLLUP(goods_classify, register_date);
	
	-- 초집합행 키 값에 적당한 문자열 넣기 --
	select case when grouping(goods_classify) = 1
		then '상품분류 합계'
		else goods_classify end as goods_classify,
		case when grouping(register_date) = 1
		then '등록일 합계'
		else cast(register_date as varchar(16)) end as register_date,
		sum(sell_price) as sum_price
		From Goods
		group by rollup(goods_classify, register_date);
		
-- cube데이터로 블록 만들기 --
select case when grouping(goods_classify) = 1
		then '상품분류 합계'
		else goods_classify end as goods_classify,
		case when grouping(register_date) = 1
		then '등록일 합계'
		else cast(register_date as varchar(16)) end as register_date,
		sum(sell_price) as sum_price
		From Goods
		group by CUBE(goods_classify, register_date);
		
-- GROUPING SETS으로 부분적인 조합 취득하기 --
select case when grouping(goods_classify) = 1
		then '상품분류 합계'
		else goods_classify end as goods_classify,
		case when grouping(register_date) = 1
		then '등록일 합계'
		else cast(register_date as varchar(16)) end as register_date,
		sum(sell_price) as sum_price
		From Goods
		group by GROUPING SETS(goods_classify, register_date);