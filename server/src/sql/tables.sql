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
    can_giao_di BIT NOT NULL DEFAULT 1,
    dia_chi_di VARCHAR(128) NOT NULL,
    dia_chi_den VARCHAR(128) NOT NULL,
    gia_tien INT NOT NULL DEFAULT 0,
    thoi_gian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (ma_khach_hang) REFERENCES GIAO_HANG_LE.KHACH_HANG(ma_khach_hang) ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT check_giatien_donhang
		CHECK (gia_tien >= 0)
);


CREATE TABLE GIAO_HANG_LE.KHO_HANG
(
    ma_kho_hang INT PRIMARY KEY IDENTITY(0,1),
    ten_kho_hang VARCHAR(32) NOT NULL UNIQUE,
    dia_chi VARCHAR(128) NOT NULL UNIQUE,
    kinh_do FLOAT NOT NULL,
    vi_do FLOAT NOT NULL
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

    PRIMARY KEY (ma_don_hang, thoi_gian, ma_tai_xe),

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


CREATE TABLE GIAO_HANG_LE.NGUOI_NHAN
(
    ma_don_hang INT PRIMARY KEY,
    ten_nguoi_nhan VARCHAR(32) NOT NULL,
    so_dien_thoai CHAR(10) NOT NULL,

    FOREIGN KEY (ma_don_hang) REFERENCES GIAO_HANG_LE.DON_HANG(ma_don_hang) ON DELETE CASCADE ON UPDATE CASCADE
);
