--1.2.1
DROP PROCEDURE IF EXISTS GIAO_HANG_LE.Dang_Nhap;
GO
CREATE PROCEDURE GIAO_HANG_LE.Dang_Nhap
    @tai_khoan VARCHAR(32),
    @mat_khau VARCHAR(32)
AS
DECLARE @ma_khach_hang INT, @ma_nhan_vien INT, @ma_kiem_kho INT, @ma_tai_xe INT
IF EXISTS (SELECT *
FROM TAI_KHOAN as tk
WHERE tk.ten_dang_nhap = @tai_khoan AND tk.mat_khau = @mat_khau)
BEGIN
    SELECT @ma_khach_hang = ma_khach_hang
    FROM KHACH_HANG
    WHERE ten_dang_nhap = @tai_khoan
    SELECT @ma_nhan_vien = ma_nhan_vien
    FROM NHAN_VIEN
    WHERE ten_dang_nhap = @tai_khoan
    IF @ma_nhan_vien IS NOT NULL
    BEGIN
        SELECT @ma_kiem_kho = ma_nhan_vien
        FROM KIEM_KHO
        WHERE ma_nhan_vien = @ma_nhan_vien
        SELECT @ma_tai_xe = ma_tai_xe
        FROM TAI_XE
        WHERE ma_tai_xe = @ma_nhan_vien
    END
    SELECT @ma_khach_hang, @ma_kiem_kho, @ma_tai_xe
END
GO

CREATE OR ALTER PROCEDURE GIAO_HANG_LE.Them_Tai_Khoan
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

CREATE OR ALTER PROCEDURE GIAO_HANG_LE.Thay_Doi_Mat_Khau
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

CREATE OR ALTER PROCEDURE Xoa_Tai_Khoan
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
CREATE PROCEDURE GIAO_HANG_LE.Dong_Goi
    @no INT,
    @ma_kiem_kho INT
AS
BEGIN
    DECLARE @ma_so_kho INT;
    SELECT @ma_so_kho = ma_so_kho
    FROM GIAO_HANG_LE.KIEM_KHO
    WHERE @ma_kiem_kho = ma_nhan_vien

    DECLARE @ma_chang INT;
    SELECT @ma_chang = ma_chang
    FROM GIAO_HANG_LE.CHANG
    WHERE kho_bat_dau = @ma_so_kho;

    DECLARE @ma_thung_hang INT;
    SELECT @ma_thung_hang = ma_thung_hang
    FROM GIAO_HANG_LE.THUNG_HANG
    WHERE ma_chang = @ma_chang;

    IF @ma_thung_hang IS NULL
    BEGIN
        INSERT INTO GIAO_HANG_LE.THUNG_HANG(ma_chang) VALUES (@ma_chang);
        SELECT @ma_thung_hang = ma_thung_hang
        FROM GIAO_HANG_LE.THUNG_HANG
        WHERE ma_chang = @ma_chang;
    END;

    INSERT INTO GIAO_HANG_LE.DONG_GOI(ma_don_hang, ma_thung_hang, ma_kiem_kho) VALUES (@no, @ma_thung_hang, @ma_kiem_kho);
END;