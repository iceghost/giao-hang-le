CREATE OR ALTER FUNCTION GIAO_HANG_LE.Tong_Doanh_Thu(@thang INT, @nam INT)
RETURNS INT
AS
BEGIN
    DECLARE @income INT;
    SELECT @income = SUM(gia_tien)
    FROM GIAO_HANG_LE.DON_HANG
    WHERE @thang = MONTH(thoi_gian) AND @nam = YEAR(thoi_gian)
    RETURN @income;
END;


CREATE OR ALTER FUNCTION GIAO_HANG_LE.Tien_Trinh_Don_Hang(
    @no INT
)
RETURNS @Chi_Tiet TABLE (
    thoi_gian DATETIME,
    thong_tin VARCHAR(128)
)
AS
BEGIN
    DECLARE @thoi_gian DATETIME;

    SELECT @thoi_gian = thoi_gian
    FROM DON_HANG as dh
    where dh.ma_don_hang = @no;

    -- Input validation
    IF @thoi_gian IS NULL
    BEGIN
        RETURN;
    END;

    INSERT INTO @Chi_Tiet
    VALUES
        (
            @thoi_gian,
            'Don hang dang duoc chuan bi.'
    )

    INSERT INTO @Chi_Tiet
    SELECT
        thoi_gian,
        CASE WHEN thanh_cong = 1
            THEN 'Lay hang thanh cong.'
            ELSE 'Lay hang that bai. Ly do: ' + ly_do
	    END AS thong_tin
    FROM GIAO_DI
    WHERE ma_don_hang = @no;

    INSERT INTO @Chi_Tiet
    SELECT
        GIAO_DEN_KHO.thoi_gian,
        'Giao den kho '  + GIAO_HANG_LE.KHO_HANG.ten_kho_hang as thong_tin
    FROM GIAO_DEN_KHO, GIAO_HANG_LE.KHO_HANG, GIAO_HANG_LE.KIEM_KHO
    WHERE ma_don_hang = @no AND GIAO_HANG_LE.GIAO_DEN_KHO.ma_kiem_kho = GIAO_HANG_LE.KIEM_KHO.ma_nhan_vien AND GIAO_HANG_LE.KIEM_KHO.ma_so_kho = GIAO_HANG_LE.KHO_HANG.ma_kho_hang;

    WITH
        th
        AS
        (
            SELECT ma_thung_hang
            FROM DONG_GOI
            WHERE ma_don_hang = @no
        ),
        luot_roi_kho
        AS
        (
            SELECT rk.thoi_gian_di as thoi_gian, 'Roi kho ' + GIAO_HANG_LE.KHO_HANG.ten_kho_hang as thong_tin
            FROM ROI_KHO as rk, GIAO_HANG_LE.KHO_HANG, GIAO_HANG_LE.KIEM_KHO
            WHERE rk.ma_thung IN (SELECT ma_thung_hang FROM th) AND rk.ma_kiem_kho = GIAO_HANG_LE.KIEM_KHO.ma_nhan_vien AND GIAO_HANG_LE.KIEM_KHO.ma_so_kho = GIAO_HANG_LE.KHO_HANG.ma_kho_hang
        ),
        luot_den_kho
        AS
        (
            SELECT dk.thoi_gian_den as thoi_gian, 'Den kho ' + GIAO_HANG_LE.KHO_HANG.ten_kho_hang as thong_tin
            FROM DEN_KHO as dk, th, GIAO_HANG_LE.KHO_HANG, GIAO_HANG_LE.KIEM_KHO
            WHERE dk.ma_thung IN (SELECT ma_thung_hang FROM th) AND dk.ma_kiem_kho = GIAO_HANG_LE.KIEM_KHO.ma_nhan_vien AND GIAO_HANG_LE.KIEM_KHO.ma_so_kho = GIAO_HANG_LE.KHO_HANG.ma_kho_hang
        )
    INSERT INTO @Chi_Tiet
            SELECT *
        FROM luot_den_kho
    UNION
        SELECT *
        FROM luot_roi_kho;

    INSERT INTO @Chi_Tiet
    SELECT
        thoi_gian,
        CASE WHEN thanh_cong = 1
            THEN 'Giao hang thanh cong.'
            ELSE 'Giao hang that bai. Ly do: ' + ly_do
	    END AS thong_tin
    FROM GIAO_DEN
    WHERE ma_don_hang = @no;

    RETURN;
END;
GO

SELECT * FROM GIAO_HANG_LE.Tien_Trinh_Don_Hang(4);

GO

DROP FUNCTION IF EXISTS GIAO_HANG_LE.Tinh_Tien_Mot_Chang;
GO
CREATE FUNCTION GIAO_HANG_LE.Tinh_Tien_Mot_Chang(
    @trong_luong FLOAT,
    @phi_duoi_1kg INT,
    @phi_duoi_10kg INT,
    @phi_tren_10kg INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @sum FLOAT

    SELECT @sum = (CASE
        WHEN @trong_luong >= 10 THEN (@trong_luong - 10) * @phi_tren_10kg
        WHEN @trong_luong >= 1 THEN @phi_duoi_10kg
        ELSE @phi_duoi_1kg
    END)

    RETURN @sum
END
GO