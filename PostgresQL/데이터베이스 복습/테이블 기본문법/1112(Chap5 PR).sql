/*
	5장 복잡한 질의 연습문제
*/
 select *  from Goods;

-- 1. 다음과 같은 3가지의 조건을 만족하는 뷰를 만든다음, select문을 실행 시키시오 --
/*
	1. 원 테이블은 Goods를 사용한다.
	2. 판매단가가 1000원 이상
	3. 판매등록일이 2010년 2월 28일
	4. 포함하는 열은 상품명, 실행단가, 등록일
*/
Create View ViewExer5_1
AS
Select goods_name, sell_price, register_date
From Goods
Where sell_price >= 1000
AND register_date = '2010-02-28';

select * From ViewExer5_1;

-- 2. ViewExer5_1뷰에 데이터 등록하기 --
-- 에러 처리가 발생한다. --
INSERT INTO ViewExer5_1 VALUES('주방칼','5000','2010-03-02');

-- 갱신하는 방법 --
INSERT INTO Goods (goods_name, sell_price, register_date)
VALUES(NULL, '주방칼', NULL, 5000, NULL, '2010-03-02');

-- 3. sell_price_all 열은 상품 전체 평균 판매 단가를 계산한 열을 추가해서 결과를 출력 하시오 --
select goods_id,
	   goods_name,
	   goods_classify,
	   sell_price,
	   (SELECT AVG(sell_price) From Goods) AS sell_price_all
	   From Goods;

-- 4. AvgPriceByClassify라는 테이블을 가진 뷰를 생성하는 sql문을 작성하고 조건은 1번 문제와 같다. --
Create View AvgPriceByClassify
AS
Select goods_id, goods_name, goods_classify, sell_price, 
(Select AVG(sell_price) From Goods S2 
 Where S1.goods_classify = S2.goods_classify
 Group by S1.goods_classify) AS avg_sell_price
From Goods S1;

select * From AvgPriceByClassify;