CREATE OR ALTER TRIGGER GIAO_HANG_LE.Check_Khoiluong
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

CREATE OR ALTER TRIGGER GIAO_HANG_LE.Check_SoluongNV
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

CREATE OR ALTER TRIGGER GIAO_HANG_LE.Check_Solannhan
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

CREATE OR ALTER TRIGGER GIAO_HANG_LE.Check_Solangui
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
DROP TRIGGER IF EXISTS GIAO_HANG_LE.Tinh_Tien;
GO
CREATE TRIGGER GIAO_HANG_LE.Tinh_Tien ON GIAO_HANG_LE.DI_QUA
FOR INSERT, UPDATE, DELETE
AS
    WITH
    tang_them
    AS
    (
        SELECT ma_don_hang,
            SUM(phi_duoi_1kg) as duoi_1kg,
            SUM(phi_duoi_10kg) as duoi_10kg,
            SUM(phi_tren_10kg) as tren_10kg
        FROM CHANG, inserted
        WHERE CHANG.ma_chang = inserted.ma_chang
        GROUP BY ma_don_hang
    ),
    giam_xuong
    AS
    (
        SELECT ma_don_hang,
            SUM(phi_duoi_1kg) as duoi_1kg,
            SUM(phi_duoi_10kg) as duoi_10kg,
            SUM(phi_tren_10kg) as tren_10kg
        FROM CHANG, deleted
        WHERE CHANG.ma_chang = deleted.ma_chang
        GROUP BY ma_don_hang
    ),
    tong_cong
    AS
    (
        SELECT t.ma_don_hang,
            ISNULL(t.duoi_1kg, 0) - ISNULL(g.duoi_1kg, 0) as duoi_1kg,
            ISNULL(t.duoi_10kg, 0) - ISNULL(g.duoi_10kg, 0) as duoi_10kg,
            ISNULL(t.tren_10kg, 0) - ISNULL(g.tren_10kg, 0) as tren_10kg
        FROM tang_them as t FULL OUTER JOIN giam_xuong as g
            ON t.ma_don_hang = g.ma_don_hang
    )
    UPDATE DON_HANG
    SET gia_tien = gia_tien
        + GIAO_HANG_LE.Tinh_Tien_Mot_Chang(trong_luong, duoi_1kg, duoi_10kg, tren_10kg)
    FROM DON_HANG, tong_cong
    WHERE DON_HANG.ma_don_hang = tong_cong.ma_don_hang
GO

