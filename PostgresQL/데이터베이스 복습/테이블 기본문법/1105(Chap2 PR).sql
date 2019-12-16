/*
	2장 연습문제
*/

-- 1. Goods테이블에서 register_date이 2010년 2월 6일이후 인 상품을 선택하시오  --
-- 출력열은 goods_name, register_date으로  --
Select goods_name, register_date 
From Goods
Where register_date = '2010-02-06';

-- 2. Goods 테이블에서 Select문 3문장을 실행하면 결과가 어떻게 나오는지 확인하시오.  --
SELECT *
FROM Goods
WHERE buy_price = NULL;

SELECT *
FROM Goods
WHERE buy_price <> NULL;

SELECT *
FROM Goods
WHERE buy_price > NULL;

-- 2.문제의 답은 결과물은 출력 되지 않는다. --

-- 3. Goods테이블에서 판매단가가 매입단가보다 500원 높은 상품을 선택하는 select문을 작성했다. 같은 결과가 나올수 있는 방법이 2가지가 있는데 --
-- 2가지의 방법으로 작성하시오. --

Select goods_name, sell_price, buy_price
From Goods
Where sell_price - buy_price >= 500;

Select goods_name, sell_price, buy_price
From Goods
Where sell_price - 500 >= buy_price ;

/* 
4. Good테이블에서 판매단가를 10%를 빼도 이익이 100보다 높은 주방용품과 사무용품을 선택한다.
출력 열은 goods_name, goods_classify, 판매단가를 10%뺀 이익의 경우에 profit이라는 별명을 붙인다. */
Select goods_name, goods_classify,
	sell_price * 0.9 - buy_price AS Profit
From Goods
Where sell_price * 0.9 - buy_price > 100 
And (goods_classify = '사무용품'
	OR goods_classify = '주방용품');