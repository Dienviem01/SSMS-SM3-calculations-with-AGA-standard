USE [master]
GO

/****** Object:  View [dbo].[vCraddle_final]    Script Date: 09/01/2026 09:10:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[vCraddle_final] AS
SELECT
    kirim.idreport AS id_referensi, -- Tambahan agar punya kunci unik
    kirim.customer_1 AS customer_id,
    kirim.rc_kirim_1_customer_1 AS kode_tabung,
    trailer.lwc AS lwc,
    kirim.jam_berangkat AS tanggal_kirim,
    ambil.jam_berangkat AS tanggal_ambil,
    kirim.p_kirim_1_customer_1 AS isi_awal,
    ambil.p_ambil_1_customer_1 AS isi_akhir,
    (kirim.p_kirim_1_customer_1 - ambil.p_ambil_1_customer_1) AS selisih_isi,
    customer.rupiah_pjbg
FROM
    dbo.t_pengiriman_craddle kirim
INNER JOIN
    dbo.t_pengiriman_craddle ambil
    ON kirim.customer_1 = ambil.customer_1
    AND kirim.rc_kirim_1_customer_1 = ambil.rc_ambil_1_customer_1
    -- Pastikan ambil adalah transaksi SETELAH kirim yang paling dekat
    AND ambil.jam_berangkat >= kirim.jam_berangkat 
INNER JOIN
    dbo.master_trailer trailer
    ON kirim.rc_kirim_1_customer_1 = trailer.nama
INNER JOIN
    dbo.master_customer customer
    ON kirim.customer_1 = customer.nama
WHERE
    kirim.p_kirim_1_customer_1 IS NOT NULL 
    AND ambil.p_ambil_1_customer_1 IS NOT NULL;
GO


