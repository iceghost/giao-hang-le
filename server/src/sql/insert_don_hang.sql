DELETE FROM GIAO_HANG_LE.DON_HANG;
DELETE FROM GIAO_HANG_LE.DI_QUA;
DBCC CHECKIDENT ('GIAO_HANG_LE.DON_HANG', RESEED, -1);
INSERT INTO GIAO_HANG_LE.DON_HANG(ma_khach_hang, trong_luong, can_giao_di, dia_chi_di, dia_chi_den)  VALUES  (1, 1.2, 1, '497 Hoa Hao, Phuong 07, Quan 10, Thanh pho Ho Chi Minh', '03 Nguyen Gia Thieu, Phuong 12, Quan 3, Thanh pho Ho Chi Minh');
INSERT INTO GIAO_HANG_LE.DI_QUA VALUES  (0, 38, 1);
INSERT INTO GIAO_HANG_LE.DON_HANG(ma_khach_hang, trong_luong, can_giao_di, dia_chi_di, dia_chi_den) VALUES  (1, 3.8, 1, '497 Hoa Hao, Phuong 07, Quan 10, Thanh pho Ho Chi Minh', '39A Luy Ban Bich, Khu pho An Lac, Thi tran Phuoc Hai, Huyen Dat Do, Tinh Ba Ria Vung Tau');
INSERT INTO GIAO_HANG_LE.DI_QUA VALUES  (1, 41, 1), (1, 97, 2), (1, 98, 3);
INSERT INTO GIAO_HANG_LE.DON_HANG(ma_khach_hang, trong_luong, can_giao_di, dia_chi_di, dia_chi_den) VALUES  (6, 8.7, 0, '97 Lanh Binh Thai, Thi tran Can Giuoc, Huyen Can Giuoc, Long An', '347 Huynh Van Banh, Phuong 11, Quan Phu Nhuan, Thanh pho Ho Chi Minh');
INSERT INTO GIAO_HANG_LE.DI_QUA VALUES  (2, 18, 1), (2, 16, 2), (2, 58, 3), (2, 149, 4);
INSERT INTO GIAO_HANG_LE.DON_HANG(ma_khach_hang, trong_luong, can_giao_di, dia_chi_di, dia_chi_den) VALUES  (3, 0.6, 1, 'Ky tuc xa khu A, Phuong Linh Trung, Thanh pho Thu Duc, Thanh pho Ho Chi Minh', '34 Phan Van Tri, Quan Go Vap, Thanh pho Ho Chi Minh');
INSERT INTO GIAO_HANG_LE.DI_QUA VALUES  (3, 143, 1);
INSERT INTO GIAO_HANG_LE.DON_HANG(ma_khach_hang, trong_luong, can_giao_di, dia_chi_di, dia_chi_den) VALUES  (5, 5.3, 0, '473 Nguyen An Ninh, Phuong 9, Thanh pho Vung Tau, Tinh Ba Ria Vung Tau', '20 Huynh Tinh Cua, Quan 3, Thanh pho Ho Chi Minh');
INSERT INTO GIAO_HANG_LE.DI_QUA VALUES  (4, 1, 1), (4, 3, 2), (4, 2, 3), (4, 79, 4), (4, 160, 5);
INSERT INTO GIAO_HANG_LE.DON_HANG(ma_khach_hang, trong_luong, can_giao_di, dia_chi_di, dia_chi_den) VALUES  (8, 9.5, 1, '193 Nguyen Tri Phuong, Thanh pho Di An, Tinh Binh Duong', '52B Nguyen Van Troi, Phuong 15, Quan Phu Nhuan, Thanh pho Ho Chi Minh');
INSERT INTO GIAO_HANG_LE.DI_QUA VALUES  (5, 4, 1), (5, 79, 2), (5, 160, 3);

SELECT * FROM GIAO_HANG_LE.DON_HANG;