/*
	술어 실습을 위한 예제 테이블을 생성한다.
*/
create Table SampleLike
( strcol	Varchar(6)	NOT NULL,
  PRIMARY KEY(strcol));
  
  -- data 등록 --
  BEGIN TRANSACTION;
  
  INSERT INTO SampleLike (strcol) VALUES ('abcddd');
  INSERT INTO SampleLike (strcol) VALUES ('dddabc');
  INSERT INTO SampleLike (strcol) VALUES ('abcdd');
  INSERT INTO SampleLike (strcol) VALUES ('ddabc');
  INSERT INTO SampleLike (strcol) VALUES ('abcdc');
  INSERT INTO SampleLike (strcol) VALUES ('aaaaa');
  
  commit;
  
  -- 데이터 등록 여부 확인하기 --
  select * from SampleLike;
  
  -- like를 사용한 전방 일치 검색하기 --
  select * From SampleLike Where strcol Like 'ddd%';
  
  -- 중간 일치 검색 --
  select * From SampleLike Where strcol Like '%ddd%';
  
  -- 후방 일치 검색 --
  select * from SampleLike Where strcol Like '%ddd';
  
  -- like _를 사용한 후방 일치 --
  select *
  From SampleLike
  Where strcol Like 'abc__';
  
  -- abc + 임의의 3문자' 검색 --
  select *
  From SampleLike
  Where strcol Like 'abc___';
  
  -- between 범위검색 --
  select goods_name, sell_price
  From Goods
  Where sell_price Between 100 AND 5000;
  
  -- 판매단가가 1000 ~ 5000원 인 상품을 검색한다. --
  select goods_name, sell_price
  From Goods
  Where sell_price > 1000
  AND sell_price < 5000;
  
  -- is Null is Not Null null or not null  판정하기 --
  Select goods_name, buy_price
  From Goods
  Where buy_price IS NULL;
  
  
  -- 매입 단가가 null이 아닌 행을 선택하기 --
  Select goods_name, buy_price
  From Goods
  Where buy_price IS not NULL;
    
  -- in 술어를 or으로 간략하게 --
  Select goods_name, buy_price
  From Goods
  Where buy_price = 250
  OR buy_price = 400
  OR buy_price = 500;
  
  -- in으로 복수의 매입단가를 지정해서 검색하기 --
  select goods_name, buy_price
  From Goods
  Where buy_price In(250, 400, 500);
  
  -- 부정의 결과를 출력하려면 not in을 사용한다. --
  select goods_name, buy_price
  From Goods
  Where buy_price not In(250, 400, 500);
  
  -- in 술어의 인수로 SubQuery를 지정하기 --
  /* 실습을 위해 예제 테이블을 만든다. 
  	 Table_name = StoreGoods
  */
  
  Drop Table StoreGoods;
  
  Create Table StoreGoods
  (store_id Char(4)  Not NULL,
   store_name Char(200) Not NULL,
   goods_id	Char(4) 	NOT NULL,
   num	Integer	Not Null,
   Primary Key (store_id, goods_id));
   
   -- data 등록 --
  BEGIN TRANSACTION;
  
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000A','서울','0001', 30);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000A','서울','0002', 50);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000A','서울','0003', 15);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000B','대전','0002', 30);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000B','대전','0003', 120);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000B','대전','0004', 20);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000B','대전','0006', 10);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000B','대전','0007', 40);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000C','부산','0003', 20);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000C','부산','0004', 50);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000C','부산','0006', 90);
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000C','부산','0007', 70);  
  INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000D','대구','0001', 100);
   
  commit;
  
  -- 데이터가 올바로 적용되었는가를 확인하자 --
  select * From StoreGoods;
  
  -- 부산점에 있는 특정 상품의 판매단가를 구하기 1안 --
  select goods_name, sell_price
  From Goods
  Where goods_id IN(select goods_id 
					From StoreGoods 
					Where store_id = '000C');
					
   -- 부산점에 있는 특정 상품의 판매단가를 구하기 2안 --
   select goods_name, sell_price
   From Goods
   Where goods_id IN('0003','0004','0006','0007');
   
   -- not in과 서브쿼리 --
  select goods_name, sell_price
  From Goods
  Where goods_id not IN(select goods_id 
					From StoreGoods 
					Where store_id = '000A');
					
   select goods_name, sell_price
   From Goods
   Where goods_id not IN('0001','0002','0003');
   
   -- Exist 술어 --
   -- Exist를 사용해서 부산점에 있는 상품의 판매단가 구하기 --
   select goods_name, sell_price
   From Goods AS S
   Where EXISTS (Select *
				From StoreGoods AS TS
				Where TS.store_id = '000C'
				And TS.goods_id = S.goods_id); 
				
	-- Exists 인수 --
	/*(Select *
				From StoreGoods AS TS
				Where TS.store_id = '000C'
				And TS.goods_id = S.goods_id); 			 
		*/		
   -- subquery안의 select --
   select goods_name, sell_price
   From Goods AS S
   Where EXISTS (Select 1
				From StoreGoods AS TS
				Where TS.store_id = '000C'
				And TS.goods_id = S.goods_id); 
				
	-- not in - not exists으로 변경하기 --
	-- not exists를 사용해서 서울점에 있는 상품 이외 상품의 판매단가를 구하기 --
   select goods_name, sell_price
   From Goods AS S
   Where NOT EXISTS (Select *
				From StoreGoods AS TS
				Where TS.store_id = '000A' 
				And TS.goods_id = S.goods_id); 
				
 -- case식 --
 select goods_name,
 	CASE When goods_classify = '의류'
		Then 'A:' || goods_classify
		When goods_classify = '사무용품'
		Then 'B:' || goods_classify
		When goods_classify = '주방용품'
		Then 'C:' || goods_classify
		ELSE NULL
	END AS abc_goods_classify
From Goods;

-- 일반적인 group by 구를사용해서는 행렬 변환을 할수 없다. --
select goods_classify, SUM(sell_price) AS sum_tanka
From Goods
Group by goods_classify;

-- case식 활용한 행렬 변환 --
select SUM(CASE WHEN goods_classify = '의류'
		  THEN sell_price ELSE 0 END) AS sum_price_cloth,
		SUM(CASE WHEN goods_classify = '주방용품'
		  THEN sell_price ELSE 0 END) AS sum_price_kitchen,
		 SUM(CASE WHEN goods_classify = '사무용품'
		  THEN sell_price ELSE 0 END) AS sum_price_office
From Goods;