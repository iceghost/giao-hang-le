DELETE FROM GIAO_HANG_LE.ROI_KHO;
DELETE FROM GIAO_HANG_LE.DEN_KHO;
DELETE FROM GIAO_HANG_LE.DONG_GOI;
DELETE FROM GIAO_HANG_LE.GIAO_DEN;
DELETE FROM GIAO_HANG_LE.GIAO_DI;
DELETE FROM GIAO_HANG_LE.GIAO_DEN_KHO;

INSERT INTO GIAO_HANG_LE.GIAO_DI(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (0, 16, 1, '');
INSERT INTO GIAO_HANG_LE.GIAO_DI(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (1, 16, 0, 'Nguoi gui chua chuan bi hang');
INSERT INTO GIAO_HANG_LE.GIAO_DI(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (3, 20, 1, '');
INSERT INTO GIAO_HANG_LE.GIAO_DI(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (5, 21, 1, '');
INSERT INTO GIAO_HANG_LE.GIAO_DI(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (1, 16, 1, '');

INSERT INTO GIAO_HANG_LE.GIAO_DEN_KHO(ma_don_hang, ma_tai_xe, ma_kiem_kho) VALUES (0, 16, 1);
INSERT INTO GIAO_HANG_LE.GIAO_DEN_KHO(ma_don_hang, ma_tai_xe, ma_kiem_kho) VALUES (1, 16, 0);
INSERT INTO GIAO_HANG_LE.GIAO_DEN_KHO(ma_don_hang, ma_tai_xe, ma_kiem_kho) VALUES (3, 20, 4);
INSERT INTO GIAO_HANG_LE.GIAO_DEN_KHO(ma_don_hang, ma_tai_xe, ma_kiem_kho) VALUES (5, 21, 8);

INSERT INTO GIAO_HANG_LE.THUNG_HANG VALUES
(38), (41), (97), (98), (18), (16), (58), (149), (143), (1), (3), (2), (76), (160), (4);

INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (0, 0, 0);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (0, 22, 0);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (0, 22, 1);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (1, 1, 1);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (1, 22, 1);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (1, 22, 3);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (1, 2, 3);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (2, 23, 3);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (2, 23, 5);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (1, 3, 5);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (3, 24, 5);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (3, 24, 7);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (2, 4, 10);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (4, 25, 10);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (4, 25, 11);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (2, 5, 11);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (5, 26, 11);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (5, 26, 12);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (2, 6, 12);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (6, 27, 12);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (6, 27, 14);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (2, 7, 13);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (7, 28, 13);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (7, 28, 9);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (3, 8, 4);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (8, 23, 4);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (8, 23, 9);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (4, 9, 6);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (9, 29, 6);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (9, 29, 7);
WAITFOR DELAY '00:00:00.01';



INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (4, 10, 7);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (10, 29, 7);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (10, 29, 5);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (4, 11, 5);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (11, 30, 5);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (11, 30, 4);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (4, 12, 4);
INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (5, 12, 4);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (12, 23, 4);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (12, 23, 13);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (4, 13, 15);
INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (5, 13, 15);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (13, 28, 15);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (13, 28, 2);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (5, 14, 8);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.ROI_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (14, 31, 8);
WAITFOR DELAY '00:00:00.01';
INSERT INTO GIAO_HANG_LE.DEN_KHO(ma_thung, ma_tai_xe, ma_kiem_kho)  VALUES (14, 31, 3);
WAITFOR DELAY '00:00:00.01';


INSERT INTO GIAO_HANG_LE.GIAO_DEN(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (0, 17, 1, '');
INSERT INTO GIAO_HANG_LE.GIAO_DEN(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (1, 18, 1, '');
INSERT INTO GIAO_HANG_LE.GIAO_DEN(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (2, 19, 1, '');
INSERT INTO GIAO_HANG_LE.GIAO_DEN(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (3, 19, 1, '');
INSERT INTO GIAO_HANG_LE.GIAO_DEN(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (4, 17, 0, 'Khong lien lac duoc');
INSERT INTO GIAO_HANG_LE.GIAO_DEN(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (5, 19, 1, '');
INSERT INTO GIAO_HANG_LE.GIAO_DEN(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (4, 17, 0, 'Hen 10h ngay mai');
INSERT INTO GIAO_HANG_LE.GIAO_DEN(ma_don_hang, ma_tai_xe, thanh_cong, ly_do) VALUES (4, 19, 1, '');