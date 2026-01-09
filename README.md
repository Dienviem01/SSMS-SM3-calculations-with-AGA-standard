# Gas Logistics Billing Automation (AGA Standards)

Repositori ini berisi sistem otomasi database SQL Server untuk kalkulasi volume standar gas dan manajemen data billing. Sistem ini dirancang untuk menangani beban komputasi besar secara efisien dengan memindahkan logika kalkulasi dari aplikasi ke layer database.

## 🛠️ Arsitektur Data & Alur Kerja

Sistem bekerja secara otomatis melalui rantai eksekusi berikut:

1. **`[dbo].[t_pengiriman_craddle]`** (Input Layer)
* Tabel utama yang menampung data mentah logistik dan tekanan (pressure) dari lapangan.


2. **`[trg_AfterInsertCraddle]`** (Automation Layer)
* Trigger yang aktif secara otomatis setelah ada operasi `INSERT` atau `UPDATE` pada tabel pengiriman.


3. **`[dbo].[vCraddle_final]`** (Logic Layer)
* View yang berfungsi melakukan *self-join* untuk menjodohkan data pengiriman dan pengambilan unit berdasarkan ID unik, sehingga selisih tekanan dapat dihitung.


4. **`[dbo].[sp_SM3AGAcalc]`** (Processing Layer)
* Stored Procedure yang berisi algoritma kalkulasi volume standar berdasarkan parameter AGA. Menggunakan perintah `MERGE` untuk memastikan efisiensi data.


5. **`[dbo].[t_finalresult]`** (Presentation Layer)
* Tabel fisik hasil akhir yang menyimpan data "siap saji" untuk ditampilkan pada dashboard web atau laporan keuangan.



## 📝 Logika Kalkulasi (AGA Approach)

Sistem mengonversi tekanan gas menjadi volume standar () dengan mempertimbangkan faktor kompresibilitas () dan perbandingan temperatur standar:

$$Vol_{Sm3} = \left( \frac{LWC}{1000} \times \frac{P + P_{base}}{P_{base}} \right) \times \left( \frac{273.15 + T_{base}}{273.15 + T_{std}} \right) \times FPV^2$$

## 🚀 Keunggulan Sistem

* **Zero Manual Intervention**: Dengan adanya Trigger, kalkulasi berjalan otomatis tanpa perintah manual.
* **Optimal Performance**: Aplikasi frontend hanya membaca dari `t_finalresult`, sehingga beban query sangat ringan dan cepat.
* **Data Consistency**: Menghindari redudansi dan ketidakkonsistenan data antara aplikasi dan database.
* **Audit Ready**: Parameter teknis gas disimpan secara historis pada setiap baris transaksi.

## 💻 Cara Penggunaan

1. Jalankan skrip tabel utama `t_pengiriman_craddle`.
2. Buat view `vCraddle_final` untuk logika penjodohan data.
3. Buat tabel `t_finalresult` sebagai wadah hasil akhir.
4. Daftarkan Stored Procedure `sp_SM3AGAcalc` yang merujuk pada view tersebut.
5. Aktifkan Trigger `trg_AfterInsertCraddle` untuk mengotomatisasi seluruh proses.
