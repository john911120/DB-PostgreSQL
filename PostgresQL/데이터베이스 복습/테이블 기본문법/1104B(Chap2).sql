-- NOT 연산자 --
-- 판매단가가 1000원 이상 선택하기 --
SELECT goods_name, goods_classify, sell_price
	From Goods
WHERE sell_price >= 1000;

-- 판매단가가 1000원 이상 선택하기 (NOT 연산자+) --
-- 1000원 미만인 상품 선택 --
/*
	WHERE구에서 지정한 조건은 WHERE구에서 지정한 검색 조건과 동일하다.
	조건을 부정하는 것이 NOT 연산자이지만 무리해서 부정을 사용할 필요는 없다.
*/
SELECT goods_name, goods_classify, sell_price
	From Goods
WHERE NOT sell_price >= 1000;

SELECT goods_name, goods_classify, sell_price
	From Goods
WHERE sell_price < 1000;

/*
	AND 양쪽 검색 조건이 모두 성립하였을 때 전체 검색 조건이 성립된다.
	OR 양쪽 검색 조건 중 어느 하나라도 만족해도 전체 검색 조건이 성립된다.
	복수의 검색 조건을 조합 할때는 두 연산자를 사용을 해도 좋다. 그리고 벤다이그램을 활용하면 더욱 더 편리하다.
*/
SELECT goods_name, sell_price
	From Goods
WHERE goods_classify = '주방용품'
	AND sell_price >= 3000;
	
SELECT goods_name, sell_price
	From Goods
WHERE goods_classify = '주방용품'
	OR sell_price >= 3000;
	
/*
	괄호를 활용하면 더 편리해진다.
	AND는 OR보다 강하고 OR 우선순위를 높이려면 괄호를 사용한다.
*/
select *
from Goods;

SELECT goods_name, goods_classify, register_date
	From Goods
WHERE goods_classify = '사무용품'
	AND( register_date = '2010-02-06'
	OR register_date = '2010-02-07');