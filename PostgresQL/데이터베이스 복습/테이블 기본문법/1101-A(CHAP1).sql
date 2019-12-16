/*
	특정 데이터에 데이터를 등록 하기
	마지막에는 commit을 붙여줘야한다.
*/

BEGIN TRANSACTION;

INSERT INTO Goods VALUES('0001', 'T-Shirt', '의류', 1000, 500, '2010-02-11');
INSERT INTO Goods VALUES('0002', 'Punching', '사무용품', 500, 250, '2010-02-06');
INSERT INTO Goods VALUES('0003', 'Y-Shirt', '의류', 4000, 2800, '2010-02-11');
INSERT INTO Goods VALUES('0004', 'Knife', '주방용품', 3000, 2800, '2010-02-06');
INSERT INTO Goods VALUES('0005', 'SteamPot', '주방용품', 6800, 5000, '2010-02-07');
INSERT INTO Goods VALUES('0006', 'Fork', '주방용품', 500, NULL, '2010-02-07');
INSERT INTO Goods VALUES('0007', '도마', '주방용품', 880, 800, '2010-02-07');
INSERT INTO Goods VALUES('0008', 'BALLPEN', '사무용품', 100, NULL, '2010-02-11');

COMMIT;