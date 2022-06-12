CREATE SCHEMA GIAO_HANG_LE;
GO

CREATE TABLE GIAO_HANG_LE.TAI_KHOAN
(
    ten_dang_nhap VARCHAR(32) PRIMARY KEY,
    mat_khau VARCHAR(32) NOT NULL,
    diem_thuong INT NOT NULL DEFAULT 0
);


CREATE TABLE GIAO_HANG_LE.KHACH_HANG
(
    ma_khach_hang INT PRIMARY KEY IDENTITY(0,1),
    ten_dang_nhap VARCHAR(32) NOT NULL UNIQUE,
    ten_khach_hang VARCHAR(32) NOT NULL,
    dia_chi VARCHAR(128) NOT NULL,
    so_dien_thoai CHAR(10) NOT NULL UNIQUE,
    email VARCHAR(64) NOT NULL UNIQUE,

    FOREIGN KEY (ten_dang_nhap) REFERENCES GIAO_HANG_LE.TAI_KHOAN(ten_dang_nhap) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE GIAO_HANG_LE.DON_HANG
(
    ma_don_hang INT PRIMARY KEY IDENTITY(0,1),
    ma_khach_hang INT NOT NULL,
    trong_luong FLOAT NOT NULL,
    can_giao_di BIT NOT NULL,
    dia_chi_di VARCHAR(128) NOT NULL,
    dia_chi_den VARCHAR(128) NOT NULL,
    gia_tien INT NOT NULL DEFAULT 6000,
    thoi_gian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (ma_khach_hang) REFERENCES GIAO_HANG_LE.KHACH_HANG(ma_khach_hang) ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT check_giatien_donhang
		CHECK (gia_tien >= 0)
);


CREATE TABLE GIAO_HANG_LE.KHO_HANG
(
    ma_kho_hang INT PRIMARY KEY IDENTITY(0,1),
    ten_kho_hang VARCHAR(32) NOT NULL UNIQUE,
    dia_chi VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE GIAO_HANG_LE.CHANG
(
    ma_chang INT PRIMARY KEY IDENTITY(0,1),
    kho_bat_dau INT NOT NULL,
    kho_ket_thuc INT NOT NULL,
    phi_duoi_1kg INT NOT NULL,
    phi_duoi_10kg INT NOT NULL,
    phi_tren_10kg INT NOT NULL,

    FOREIGN KEY (kho_bat_dau) REFERENCES GIAO_HANG_LE.KHO_HANG(ma_kho_hang),
    FOREIGN KEY (kho_ket_thuc) REFERENCES GIAO_HANG_LE.KHO_HANG(ma_kho_hang),

    CONSTRAINT check_giatien_chan1
		CHECK (phi_duoi_1kg >= 0 AND phi_duoi_10kg >= 0 AND phi_tren_10kg >= 0)
);


CREATE TABLE GIAO_HANG_LE.DI_QUA
(
    ma_don_hang INT NOT  NULL,
    ma_chang INT NOT NULL,
    thu_tu INT NOT NULL DEFAULT 0,

    PRIMARY KEY (ma_don_hang, ma_chang),

    FOREIGN KEY (ma_don_hang) REFERENCES GIAO_HANG_LE.DON_HANG(ma_don_hang) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ma_chang) REFERENCES GIAO_HANG_LE.CHANG(ma_chang) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE GIAO_HANG_LE.THUNG_HANG
(
    ma_thung_hang INT PRIMARY KEY IDENTITY(0,1),
    ma_chang INT NOT NULL,

    FOREIGN KEY (ma_chang) REFERENCES GIAO_HANG_LE.CHANG(ma_chang) ON UPDATE CASCADE
);


CREATE TABLE GIAO_HANG_LE.NHAN_VIEN
(
    ma_nhan_vien INT PRIMARY KEY IDENTITY(0,1),
    ten_dang_nhap VARCHAR(32) NOT NULL UNIQUE,
    ten_nhan_vien VARCHAR(32) NOT NULL,
    dia_chi VARCHAR(128) NOT NULL,
    so_dien_thoai CHAR(10) NOT NULL UNIQUE,
    email VARCHAR(64) NOT NULL UNIQUE,

    FOREIGN KEY (ten_dang_nhap) REFERENCES GIAO_HANG_LE.TAI_KHOAN(ten_dang_nhap) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE GIAO_HANG_LE.KIEM_KHO
(
    ma_nhan_vien INT PRIMARY KEY,
    ma_so_kho INT,
    phong INT NOT NULL,

    FOREIGN KEY (ma_nhan_vien) REFERENCES GIAO_HANG_LE.NHAN_VIEN(ma_nhan_vien) ON UPDATE CASCADE,
    FOREIGN KEY (ma_so_kho) REFERENCES GIAO_HANG_LE.KHO_HANG(ma_kho_hang) ON UPDATE CASCADE
);


CREATE TABLE GIAO_HANG_LE.TAI_XE
(
    ma_tai_xe INT PRIMARY KEY,
    bien_so_xe VARCHAR(16) NOT NULL UNIQUE,

    FOREIGN KEY (ma_tai_xe) REFERENCES GIAO_HANG_LE.NHAN_VIEN(ma_nhan_vien)  ON UPDATE CASCADE
);

--Tai xe xe may 17 -> 19
-- Tai xe xe cho hang 20-33



CREATE TABLE GIAO_HANG_LE.ROI_KHO
(
    ma_thung INT PRIMARY KEY,
    thoi_gian_di DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ma_tai_xe INT NOT NULL,
    ma_kiem_kho INT NOT NULL,

    FOREIGN KEY (ma_kiem_kho) REFERENCES GIAO_HANG_LE.KIEM_KHO(ma_nhan_vien),
    FOREIGN KEY (ma_tai_xe) REFERENCES GIAO_HANG_LE.TAI_XE(ma_tai_xe) ON UPDATE CASCADE,
    FOREIGN KEY (ma_thung) REFERENCES GIAO_HANG_LE.THUNG_HANG(ma_thung_hang) ON UPDATE CASCADE
);


CREATE TABLE GIAO_HANG_LE.DEN_KHO
(
    ma_thung INT PRIMARY KEY,
    thoi_gian_den DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ma_tai_xe INT NOT NULL,
    ma_kiem_kho INT NOT NULL,

    FOREIGN KEY (ma_kiem_kho) REFERENCES GIAO_HANG_LE.KIEM_KHO(ma_nhan_vien),
    FOREIGN KEY (ma_tai_xe) REFERENCES GIAO_HANG_LE.TAI_XE(ma_tai_xe) ON UPDATE CASCADE,
    FOREIGN KEY (ma_thung) REFERENCES GIAO_HANG_LE.THUNG_HANG(ma_thung_hang) ON UPDATE CASCADE
);

CREATE TABLE GIAO_HANG_LE.DONG_GOI
(
    ma_don_hang INT NOT NULL,
    ma_thung_hang INT NOT NULL,
    ma_kiem_kho INT NOT NULL,
    thoi_gian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (ma_don_hang, ma_thung_hang),

    FOREIGN KEY (ma_don_hang) REFERENCES GIAO_HANG_LE.DON_HANG(ma_don_hang) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ma_thung_hang) REFERENCES GIAO_HANG_LE.THUNG_HANG(ma_thung_hang) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ma_kiem_kho) REFERENCES GIAO_HANG_LE.KIEM_KHO(ma_nhan_vien)
);


CREATE TABLE GIAO_HANG_LE.GIAO_DI
(
    ma_don_hang INT NOT NULL,
    thoi_gian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ma_tai_xe INT NOT NULL,
    thanh_cong BIT NOT NULL,
    ly_do VARCHAR(64),

    PRIMARY KEY (ma_don_hang, thoi_gian),

    FOREIGN KEY (ma_don_hang) REFERENCES GIAO_HANG_LE.DON_HANG(ma_don_hang) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ma_tai_xe) REFERENCES GIAO_HANG_LE.TAI_XE(ma_tai_xe)
);




CREATE TABLE GIAO_HANG_LE.GIAO_DEN
(
    ma_don_hang INT NOT NULL,
    thoi_gian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ma_tai_xe INT NOT NULL,
    thanh_cong BIT NOT NULL,
    ly_do VARCHAR(64),

    PRIMARY KEY (ma_don_hang, thoi_gian, ma_tai_xe),

    FOREIGN KEY (ma_don_hang) REFERENCES GIAO_HANG_LE.DON_HANG(ma_don_hang) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ma_tai_xe) REFERENCES GIAO_HANG_LE.TAI_XE(ma_tai_xe)
);



CREATE TABLE GIAO_HANG_LE.GIAO_DEN_KHO
(
    ma_don_hang INT NOT NULL,
    ma_tai_xe INT,
    ma_kiem_kho INT NOT NULL,
    thoi_gian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (ma_don_hang, ma_kiem_kho),

    FOREIGN KEY (ma_don_hang) REFERENCES GIAO_HANG_LE.DON_HANG(ma_don_hang) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ma_tai_xe) REFERENCES GIAO_HANG_LE.TAI_XE(ma_tai_xe),
    FOREIGN KEY (ma_kiem_kho) REFERENCES GIAO_HANG_LE.KIEM_KHO(ma_nhan_vien)
);


CREATE TABLE GIAO_HANG_LE.NGUOINHAN
(
    ma_don_hang INT PRIMARY KEY,
    ten_nguoi_nhan VARCHAR(32) NOT NULL,
    so_dien_thoai CHAR(10) NOT NULL,

    FOREIGN KEY (ma_don_hang) REFERENCES GIAO_HANG_LE.DON_HANG(ma_don_hang) ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TRIGGER Check_Khoiluong
ON GIAO_HANG_LE.DON_HANG
FOR  INSERT, UPDATE
AS
BEGIN
    DECLARE @kl FLOAT;
    SELECT @kl = trong_luong
    from INSERTED;
    IF (@kl > 10.0)
	BEGIN
        RAISERROR ('Khoi luong don hang khong duoc vuot qua 10kg', 16, 1);
        ROLLBACK;
    END;
END;

GO

CREATE OR ALTER TRIGGER Check_SoluongNV
ON GIAO_HANG_LE.KIEM_KHO
FOR  INSERT, UPDATE
AS
BEGIN
    DECLARE @sum1 INT;

    SELECT @sum1 = COUNT(GIAO_HANG_LE.KIEM_KHO.ma_nhan_vien)
    FROM INSERTED, GIAO_HANG_LE.KIEM_KHO
    WHERE INSERTED.ma_so_kho = GIAO_HANG_LE.KIEM_KHO.ma_so_kho AND INSERTED.phong = GIAO_HANG_LE.KIEM_KHO.phong
    GROUP BY GIAO_HANG_LE.KIEM_KHO.phong;

    IF (@sum1 > 10)
	BEGIN
        RAISERROR ('So nhan vien trong mot phong khong the lon hon 10', 16, 1);
        ROLLBACK;
    END;
END;

GO

CREATE OR ALTER TRIGGER Check_Solannhan
ON GIAO_HANG_LE.GIAO_DEN
FOR INSERT
AS
BEGIN
    DECLARE @sum2 INT;

    SELECT @sum2 = COUNT(*)
    FROM INSERTED, GIAO_HANG_LE.GIAO_DEN
    WHERE INSERTED.ma_don_hang = GIAO_HANG_LE.GIAO_DEN.ma_don_hang
    GROUP BY GIAO_HANG_LE.GIAO_DEN.ma_don_hang;

    IF (@sum2 > 5)
	BEGIN
        RAISERROR ('Khong the luu kho qua 5 lan', 16, 1);
        ROLLBACK;
    END;
END;

GO

CREATE OR ALTER TRIGGER Check_Solangui
ON GIAO_HANG_LE.GIAO_DI
FOR INSERT
AS
BEGIN
    DECLARE @sum3 INT;

    SELECT @sum3 = COUNT(*)
    FROM INSERTED, GIAO_HANG_LE.GIAO_DI
    WHERE INSERTED.ma_don_hang = GIAO_HANG_LE.GIAO_DI.ma_don_hang
    GROUP BY GIAO_HANG_LE.GIAO_DI.ma_don_hang;

    IF (@sum3 > 5)
	BEGIN
        RAISERROR ('Khong the lay hang tu nguoi gui, bi tu choi qua 5 lan!', 16, 1);
        ROLLBACK;
    END;
END;

GO

--1.2.1
CREATE PROCEDURE Them_Tai_Khoan
    @ten_dang_nhap VARCHAR(32),
    @mat_khau VARCHAR(32)
AS
BEGIN
    DECLARE @dp INT;

    SELECT @dp = COUNT(*)
    FROM GIAO_HANG_LE.TAI_KHOAN AS tk
    WHERE @ten_dang_nhap = tk.ten_dang_nhap;

    IF (@dp <> 0)
    BEGIN
        RAISERROR('Ten tai khoan da ton tai, vui long chon mot ten dang nhap khac!', 16, 1);
        RETURN;
    END;

    DECLARE @len INT;
    SELECT @len = LEN(@mat_khau);

    IF (@len < 6)
    BEGIN
        RAISERROR('Mat khau qua ngan, vui long chon mat khau dai hon!', 16, 1);
        RETURN;
    END;

    INSERT INTO GIAO_HANG_LE.TAI_KHOAN
    VALUES
        (@ten_dang_nhap, @mat_khau, 0);

END;

GO

CREATE PROCEDURE Thay_Doi_Mat_Khau
    @ten_tai_khoan VARCHAR(32),
    @mat_khau VARCHAR(32),
    @mat_khau_moi VARCHAR(32)
AS
BEGIN
    DECLARE @mk VARCHAR(32);

    SELECT @mk = tk.mat_khau
    FROM GIAO_HANG_LE.TAI_KHOAN as tk
    WHERE @ten_tai_khoan = tk.ten_dang_nhap;

    IF (@mk IS NULL)
    BEGIN
        RAISERROR('Tai khoan khong ton tai!', 16, 1);
        RETURN;
    END;

    IF (@mk <> @mat_khau)
    BEGIN
        RAISERROR('Mat khau cu khong dung!', 16, 1);
        RETURN;
    END;

    IF (LEN(@mat_khau_moi) < 6)
    BEGIN
        RAISERROR('Mat khau qua ngan, vui long chon mat khau dai hon!', 16, 1);
        RETURN;
    END;

    UPDATE GIAO_HANG_LE.TAI_KHOAN
    SET mat_khau = @mat_khau_moi
    WHERE ten_dang_nhap = @ten_tai_khoan;

END;

GO

CREATE PROCEDURE Xoa_Tai_Khoan
    @ten_tai_khoan VARCHAR(32),
    @mat_khau VARCHAR(32)
AS
BEGIN
    DECLARE @mk VARCHAR(32);

    SELECT @mk = tk.mat_khau
    FROM GIAO_HANG_LE.TAI_KHOAN as tk
    WHERE @ten_tai_khoan = tk.ten_dang_nhap;

    IF (@mk IS NULL)
    BEGIN
        RAISERROR('Tai khoan khong ton tai!', 16, 1);
        RETURN;
    END;

    IF (@mk <> @mat_khau)
    BEGIN
        RAISERROR('Mat khau khong dung!', 16, 1);
        RETURN;
    END;

    DELETE tk FROM GIAO_HANG_LE.TAI_KHOAN
    AS tk
    WHERE tk.ten_dang_nhap = @ten_tai_khoan;
END;

GO

CREATE FUNCTION GIAO_HANG_LE.Tong_Doanh_Thu(@thang INT, @nam INT)
RETURNS INT
AS
BEGIN
    DECLARE @income INT;
    SELECT @income = SUM(gia_tien)
    FROM GIAO_HANG_LE.DON_HANG
    WHERE @thang = MONTH(thoi_gian) AND @nam = YEAR(thoi_gian)
    RETURN @income;
END;

GO

SELECT * FROM GIAO_HANG_LE.TAI_KHOAN;
SELECT * FROM  GIAO_HANG_LE.DON_HANG;
SELECT * FROM  GIAO_HANG_LE.KHO_HANG;
SELECT * FROM  GIAO_HANG_LE.KHACH_HANG;
SELECT * FROM  GIAO_HANG_LE.CHANG;
SELECT * FROM  GIAO_HANG_LE.DI_QUA;
SELECT * FROM  GIAO_HANG_LE.THUNG_HANG;
SELECT * FROM  GIAO_HANG_LE.ROI_KHO;
SELECT * FROM  GIAO_HANG_LE.DEN_KHO;
SELECT * FROM  GIAO_HANG_LE.NHAN_VIEN;
SELECT * FROM  GIAO_HANG_LE.KIEM_KHO;
SELECT * FROM GIAO_HANG_LE.DONG_GOI;
SELECT * FROM GIAO_HANG_LE.TAI_XE;
SELECT * FROM  GIAO_HANG_LE.GIAO_DEN;
SELECT * FROM  GIAO_HANG_LE.GIAO_DI;
SELECT * FROM GIAO_HANG_LE.NGUOINHAN;
SELECT * FROM GIAO_HANG_LE.GIAO_DEN_KHO;
SELECT * FROM GIAO_HANG_LE.DEN_KHO AS A, GIAO_HANG_LE.ROI_KHO AS B WHERE A.ma_thung = B.ma_thung;
GO


CREATE FUNCTION GIAO_HANG_LE.Tien_Trinh_Don_Hang(
    @no INT
)
RETURNS @Chi_Tiet TABLE (
	thong_tin VARCHAR(128)
)
AS
BEGIN
    -- Input validation
    DECLARE @valid SMALLINT;
    SELECT @valid = COUNT(*)
    FROM GIAO_HANG_LE.DON_HANG AS dh
    WHERE dh.ma_don_hang = @no;

    IF (@valid = 0)
    BEGIN
		RETURN;
    END;

    IF (@valid <> 1)
    BEGIN
        RETURN;
    END;

    -- @valid = 1 => the order exists and is unique

    DECLARE @len INT;
    SELECT @len = 0;

    DECLARE @new_len INT;
    SET @new_len = 0;

    INSERT INTO @Chi_Tiet
    SELECT CAST(
        CASE WHEN thanh_cong = 1
            THEN 'Lay hang thanh cong luc ' + CONVERT(nvarchar(max), thoi_gian) + ' .'
            ELSE 'Lay hang that bai luc ' + CONVERT(nvarchar(max), thoi_gian) +  ' . Ly do: ' + ly_do
	    END AS VARCHAR(128)
    )
    FROM GIAO_HANG_LE.GIAO_DI
    WHERE ma_don_hang = @no;

    SELECT @new_len = COUNT(*) FROM @Chi_Tiet;
    IF (@len = @new_len)
    BEGIN
        INSERT INTO @Chi_Tiet VALUES (
            'Don hang dang duoc chuan bi.'
        )
        RETURN;
    END;

    SELECT @len = @new_len;

    DECLARE @di_chuyen TABLE(
        da_roi_kho INT,
        thoi_gian_di DATETIME,
        da_den_kho INT,
        thoi_gian_den DATETIME
    )

    INSERT INTO @di_chuyen
    SELECT
    CAST(
        CASE WHEN rk.ma_thung IS NOT NULL
            THEN c.kho_bat_dau
            ELSE -1
        END AS INT
    ) as da_roi_kho,
    CONVERT(DATETIME, rk.thoi_gian_di),
    CAST(
        CASE WHEN dk.ma_thung IS NOT NULL
            THEN c.kho_ket_thuc
            ELSE -1
        END AS INT
    ) as da_den_kho,
    CONVERT(DATETIME, dk.thoi_gian_den)
    FROM GIAO_HANG_LE.DONG_GOI as dg, GIAO_HANG_LE.CHANG as c, GIAO_HANG_LE.THUNG_HANG as th, GIAO_HANG_LE.ROI_KHO as rk, GIAO_HANG_LE.DEN_KHO as dk
    WHERE dg.ma_don_hang = @no AND dg.ma_thung_hang = th.ma_thung_hang AND th.ma_chang = c.ma_chang AND dg.ma_thung_hang = rk.ma_thung AND dg.ma_thung_hang = dk.ma_thung

    INSERT INTO @Chi_Tiet
    SELECT
    CAST(
        CASE WHEN da_roi_kho <> -1
            THEN 'Don hang da roi kho ' + (SELECT ten_kho_hang FROM GIAO_HANG_LE.KHO_HANG WHERE da_roi_kho = ma_kho_hang) + ' vao luc ' + CONVERT(NVARCHAR(MAX), thoi_gian_di) + CHAR(10)
            ELSE ''
        END AS VARCHAR(128)
    ) +
    CAST(
        CASE WHEN da_den_kho <> -1
            THEN 'Don hang da roi kho ' + (SELECT ten_kho_hang FROM GIAO_HANG_LE.KHO_HANG WHERE da_den_kho = ma_kho_hang) + ' vao luc ' + CONVERT(NVARCHAR(MAX), thoi_gian_den) + CHAR(10)
            ELSE ''
        END AS VARCHAR(128)
    )
    FROM @di_chuyen;

	RETURN;
END;
GO
