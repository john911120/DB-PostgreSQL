-- 다양한 함수 --
-- 산술함수 --
DDL 테이블 만들기
-- 예제를 위한 테이블 작성 --
Create Table SampleMath
(m NUMERIC (10,3),
 n INTEGER,
 p INTEGER);
 
 -- 테이블에 데이터 넣기 --
 BEGIN TRANSACTION;
 
 INSERT INTO SampleMath (m, n, p) VALUES(100, 0, NULL);
 INSERT INTO SampleMath (m, n, p) VALUES(-100, 0, NULL);
 INSERT INTO SampleMath (m, n, p) VALUES(NULL, NULL, NULL);
 INSERT INTO SampleMath (m, n, p) VALUES(NULL, 7, 3);
 INSERT INTO SampleMath (m, n, p) VALUES(NULL, 4, 2); 
 INSERT INTO SampleMath (m, n, p) VALUES(NULL, 4, NULL);
 INSERT INTO SampleMath (m, n, p) VALUES(8, NULL, 3);
 INSERT INTO SampleMath (m, n, p) VALUES(4.71, 1, NULL);
 INSERT INTO SampleMath (m, n, p) VALUES(5.123, 2, NULL); 
 INSERT INTO SampleMath (m, n, p) VALUES(NULL, 1, NULL);
 INSERT INTO SampleMath (m, n, p) VALUES(7.41, NULL, NULL); 
 COMMIT;
 
 -- 데이터가 맞게 들어갔는지 여부를 확인하기 --
 select * from SampleMath;
 
 -- 절대값 --
 select m, ABS(m) AS abs_col From SampleMath;
 
 -- 나머지 값 --
 select n, p, MOD(n, p) AS mod_col From SampleMath;
 
 -- 반올림 값 --
 select m, n, Round(m, n) AS round_col From SampleMath;
 
 -- 문자열 함수 --
 -- 실습을 위한 테이블 작성 --
 Create Table SampleStr
(str1 VARCHAR(40),
 str2 VARCHAR(40),
 str3 VARCHAR(40));
 
 -- 테이블에 데이터 넣기 --
 BEGIN TRANSACTION;
 
 INSERT INTO SampleStr (str1, str2, str3) VALUES('ㄱㄴㄷ', 'ㄹㅁ', NULL);
 INSERT INTO SampleStr (str1, str2, str3) VALUES('abc', 'def', NULL);
 INSERT INTO SampleStr (str1, str2, str3) VALUES('시', '명이', '입니다.');
 INSERT INTO SampleStr (str1, str2, str3) VALUES('cat', NULL, NULL);
 INSERT INTO SampleStr (str1, str2, str3) VALUES(NULL, '시명이', NULL);
 INSERT INTO SampleStr (str1, str2, str3) VALUES('!@#', NULL, NULL);
 INSERT INTO SampleStr (str1, str2, str3) VALUES('ABC', NULL, NULL);
 INSERT INTO SampleStr (str1, str2, str3) VALUES('dEF', NULL, NULL);
 INSERT INTO SampleStr (str1, str2, str3) VALUES('abㄱㄴㄷ', 'abc', 'ABC');
 INSERT INTO SampleStr (str1, str2, str3) VALUES('abcdefghij', 'def', 'DEF');
 INSERT INTO SampleStr (str1, str2, str3) VALUES('AIU', 'I', 'U');
 COMMIT;
 
 -- 데이터가 맞게 들어갔는지 여부를 확인하기 --
 select * from SampleStr;
 
 -- 문자열 연결하기 (2개) --
 select str1, str2,
 str1 || str2 AS str_concat
 From SampleStr;
 
 -- 문자열 연결하기 (3개) --
 select str1, str2, str3,
 str1 || str2 || str3 AS str_concat
 From SampleStr
 Where str1 = '시';
 
 -- 문자열길이 구하기 --
 SELECT str1,
 	LENGTH(str1) AS len_str
	From SampleStr;
	
 -- 알파벳소문자화하기 --
 Select str1,
  LOWER(str1) AS low_str
  From SampleStr
 where str1 IN ('ABC', 'dEF', 'AIU', '심');
 
 -- 문자열 치환하기 --
 SELECT str1, str2, str3,
 	Replace(str1, str2, str3) AS rep_str
 From SampleStr;
 
 -- 문자열 잘라내기 --
 SELECT str1,
 SUBSTRING(str1 From 3 For 2) AS sub_str
 From SampleStr;
 
 -- 대문자 --
 SELECT str1,
 Upper(str1) AS up_str
 From SampleStr
 WHERE str1 IN ('ABC','dEF','abcdefghij','심');
 
 -- 날짜함  --
 -- 현재 날짜 --
 select Current_date;
 -- 현재 일시 --
 select current_TIMESTAMP;
 -- 날짜 요소 추출하기 --
 SELECT CURRENT_TIMESTAMP,
 	EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS year,
	EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS month,
	EXTRACT(DAY FROM CURRENT_TIMESTAMP) as day,
	EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AS hour,
	EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS minute,
	EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;
	
-- 변환 함수 --
-- CAST 형 변환 (문자형 - 숫자형) --
SELECT CAST('0001' AS INTEGER) AS int_col;
SELECT CAST('2010-03-04' AS DATE) AS date_col;
-- coalesce null 값으로 변환하기 --
select coalesce(null, 1) AS col_1,
		coalesce(null, 'test', NULL) AS col_2,
		coalesce(null, NULL, '2010-04-01')AS col_3;

-- SampleStr 테이블 열을 사용한샘플  --
Select Coalesce(str2, 'NULL값')
From SampleStr;