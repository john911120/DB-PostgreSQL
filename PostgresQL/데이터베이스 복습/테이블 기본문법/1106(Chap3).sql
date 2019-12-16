Select *
From Goods;

-- having 구 --
Select goods_classify, Count(*)
From Goods
Group BY goods_classify
Having Count(*) = 2;

-- having구 없이 선택한 결과 --
Select goods_classify, Count(*)
From Goods
Group BY goods_classify;

-- having구 없이 평균값을 선택한 경우 --
Select goods_classify, AVG(sell_price)
From Goods
Group BY goods_classify;

-- having구에 조건을 설정하고 선택한 경우 --
Select goods_classify, AVG(sell_price)
From Goods
Group BY goods_classify
Having AVG(sell_price) >= 2500;

/*
-- 에러가 발생하는 having구 사용하지 마시오 --
Select goods_classify, Count(*)
From Goods
Group BY goods_classify
Having goods_name = '볼펜';
-- goods_name이라는 열은 어디에도 존재하지 않는다. --
-- 테이블에 없는 열을 지정하는 것은 SQL에서는 불가능한 이야기 --
*/

-- 조건을 HAVING구에 작성한 경우 --
Select goods_classify, Count(*)
From Goods
WHERE goods_classify = '의류'
Group BY goods_classify;

-- ORDER BY 상품ID, 상품명, 판매단가, 매입단가를 표시하는 SELECT -- 
SELECT goods_id, goods_name, sell_price, buy_price
From Goods;

-- 판매단가가 낮은 순으로 나열한다.(오름차순) --
SELECT goods_id, goods_name, sell_price, buy_price
FROM Goods
ORDER BY sell_price;

-- 판매단가가 높은 순으로 나열한다. (내림차순) --
SELECT goods_id, goods_name, sell_price, buy_price
FROM Goods
ORDER BY sell_price DESC;

-- 복수의 소트 키를 지정한다. 판매단가와 상품ID를 오름차순으로 --
SELECT goods_id, goods_name, sell_price, buy_price
FROM Goods
ORDER BY sell_price, goods_id;

-- 매입단가를 오름차순으로 정렬한다. --
SELECT goods_id, goods_name, sell_price, buy_price
FROM Goods
ORDER BY buy_price;

-- 소트 키에 표시용 별명을 선택한다. --
SELECT goods_id AS id, goods_name, sell_price AS ht, buy_price
FROM Goods
ORDER BY ht, id;

-- order by구에 사용가능한 열 --
-- select 구에 포함되지 않는 열이라도 order by구에 지정가능하다. --
SELECT goods_name, sell_price, buy_price
FROM Goods
ORDER BY goods_id;

-- 집약 함수도 order by구에 이용이 가능하다. --
Select goods_classify, COUNT(*)
FROM Goods
GROUP BY goods_classify
ORDER BY COUNT(*);