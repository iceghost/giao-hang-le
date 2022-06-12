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
    SET gia_tien = gia_tien + GIAO_HANG_LE.Tinh_Tien_Mot_Chang(trong_luong, ma_chang)
    FROM DON_HANG as dh, inserted as i
    WHERE dh.ma_don_hang = i.ma_don_hang;

    UPDATE DON_HANG
    SET gia_tien = gia_tien - GIAO_HANG_LE.Tinh_Tien_Mot_Chang(trong_luong, ma_chang)
    FROM DON_HANG as dh, deleted as d
    WHERE dh.ma_don_hang = d.ma_don_hang;
GO