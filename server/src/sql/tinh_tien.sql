DROP FUNCTION IF EXISTS GIAO_HANG_LE.Tinh_Tien;
GO
CREATE FUNCTION GIAO_HANG_LE.Tinh_Tien(
    @no INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @sum FLOAT, @trong_luong FLOAT;

    SELECT @trong_luong = trong_luong
    FROM DON_HANG
    where ma_don_hang = @no;

    WITH
        ch
        AS
        (
            SELECT ma_chang
            from DI_QUA
            WHERE ma_don_hang = @no
        ),
        don_gia
        AS
        (
            SELECT
                SUM(phi_duoi_1kg) AS duoi_1kg,
                SUM(phi_duoi_10kg) AS duoi_10kg,
                SUM(phi_tren_10kg) AS tren_10kg
            FROM CHANG
            WHERE ma_chang IN (SELECT *
            FROM ch)
        )
    SELECT @sum = (CASE
                    WHEN @trong_luong >= 10 THEN 1 * duoi_1kg + 10 * duoi_10kg + (@trong_luong - 10) * tren_10kg
                    WHEN @trong_luong >= 1 THEN 1 * duoi_1kg + (@trong_luong - 1) * duoi_10kg
                    ELSE @trong_luong * duoi_1kg
                    END)
    FROM don_gia;

    RETURN @sum;
END
GO