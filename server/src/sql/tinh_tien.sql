DROP FUNCTION IF EXISTS GIAO_HANG_LE.Tinh_Tien_Mot_Chang;
GO
CREATE FUNCTION GIAO_HANG_LE.Tinh_Tien_Mot_Chang(
    @trong_luong FLOAT,
    @ma_chang INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @sum FLOAT

    SELECT @sum = (CASE
                    WHEN @trong_luong >= 10 THEN (@trong_luong - 10) * phi_tren_10kg
                    WHEN @trong_luong >= 1 THEN phi_duoi_10kg
                    ELSE phi_duoi_1kg
                    END)
    FROM GIAO_HANG_LE.CHANG

    WHERE ma_chang = @ma_chang;
    RETURN @sum
END
GO

DROP TRIGGER IF EXISTS GIAO_HANG_LE.Tinh_Tien;
GO
CREATE TRIGGER GIAO_HANG_LE.Tinh_Tien ON GIAO_HANG_LE.DI_QUA
FOR INSERT, UPDATE, DELETE
AS


    UPDATE DON_HANG
    SET gia_tien = gia_tien + i.sum
    FROM DON_HANG as dh, (
        SELECT inserted.ma_don_hang, SUM(GIAO_HANG_LE.Tinh_Tien_Mot_Chang(trong_luong, ma_chang)) as sum
    FROM inserted, DON_HANG as dh
    WHERE inserted.ma_don_hang = dh.ma_don_hang
    GROUP BY inserted.ma_don_hang
    ) as i
    WHERE dh.ma_don_hang = i.ma_don_hang;

    UPDATE DON_HANG
    SET gia_tien = gia_tien - i.sum
    FROM DON_HANG as dh, (
        SELECT deleted.ma_don_hang, SUM(GIAO_HANG_LE.Tinh_Tien_Mot_Chang(trong_luong, ma_chang)) as sum
    FROM deleted, DON_HANG as dh
    WHERE deleted.ma_don_hang = dh.ma_don_hang
    GROUP BY deleted.ma_don_hang
    ) as i
    WHERE dh.ma_don_hang = i.ma_don_hang;
GO