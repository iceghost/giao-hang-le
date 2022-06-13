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