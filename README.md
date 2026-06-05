# Workbook Interaksi Obat Polifarmasi Geriatri

Aplikasi ini adalah Workbook Interaktif berbasis Flutter yang dirancang untuk membantu mahasiswa dan tenaga kesehatan dalam menganalisis interaksi obat pada pasien geriatri dengan polifarmasi, khususnya untuk kombinasi obat Hipertensi, ARV (Antiretroviral), dan TB (Tuberkulosis).

## Teori Interaksi Obat
Dalam farmakologi, interaksi obat dapat diklasifikasikan berdasarkan efek kombinasi obat:

1. **Sinergis**: Interaksi di mana kombinasi dua obat menghasilkan efek yang lebih besar daripada jumlah efek masing-masing obat (1 + 1 > 2).
2. **Aditif**: Interaksi di mana kombinasi dua obat menghasilkan efek yang sama dengan jumlah efek masing-masing obat jika diberikan sendiri-sendiri (1 + 1 = 2).
3. **Antagonis**: Interaksi di mana satu obat mengurangi atau menetralkan efek obat lain (1 + 1 < 2).

## Contoh Interaksi Obat (Hipertensi, ARV, TB)

| Obat 1 | Obat 2 | Mekanisme Interaksi | Efek (S/A/Ant) | Rekomendasi Klinis |
| :--- | :--- | :--- | :--- | :--- |
| Rifampisin (TB) | Amlodipin (Hipertensi) | Rifampisin menginduksi enzim CYP3A4, mempercepat metabolisme Amlodipin. | Antagonis (Penurunan efikasi) | Pantau tekanan darah, mungkin perlu peningkatan dosis Amlodipin. |
| Isoniazid (TB) | Efavirenz (ARV) | Keduanya berisiko menyebabkan hepatotoksisitas. | Aditif (Toksisitas) | Pantau ketat fungsi hati (SGOT/SGPT). |
| Tenofovir (ARV) | Lisinopril (Hipertensi) | Keduanya dapat mempengaruhi fungsi ginjal. | Aditif (Nefrotoksisitas) | Pantau fungsi ginjal (kreatinin serum) secara rutin. |
| Rifampisin (TB) | Lopinavir/Ritonavir (ARV) | Rifampisin sangat menurunkan kadar Lopinavir melalui induksi enzim hati. | Antagonis | Hindari penggunaan bersamaan atau gunakan dosis ARV yang disesuaikan/ganti regimen. |

## Referensi Jurnal (5 Tahun Terakhir)
Aplikasi dan materi ini merujuk pada literatur medis dan farmasi terkait interaksi obat ARV, OAT (Obat Anti-Tuberkulosis), dan Antihipertensi:
1. *Babadoko, A. A., et al. (2021). "Drug-drug interactions among HIV/TB co-infected patients." Journal of Pharmacy & Bioallied Sciences.*
2. *Gengiah, S., et al. (2020). "Drug interactions between antiretrovirals and antituberculosis drugs: clinical considerations." Clinical Pharmacokinetics.*
3. *Perhimpunan Dokter Spesialis Kardiovaskular Indonesia (PERKI). (2021). Pedoman Tatalaksana Hipertensi.* (Sebagai pedoman tata laksana penyerta).

> *Catatan: Data interaksi spesifik dapat diverifikasi lebih lanjut menggunakan database seperti Lexicomp atau Drugs.com.*

## Tech Stack
- Flutter (Dart)
- Material Design 3

## Setup & Instalasi
1. Pastikan Flutter SDK sudah terpasang.
2. Clone repository ini.
3. Jalankan `flutter pub get` untuk mengunduh dependensi.
4. Jalankan aplikasi dengan `flutter run`.

---
## Tentang CouldAI
Aplikasi ini di-generate menggunakan [CouldAI](https://could.ai), AI app builder untuk aplikasi cross-platform yang mengubah prompt menjadi aplikasi native iOS, Android, Web, dan Desktop dengan agen AI otonom yang merancang, membangun, menguji, men-deploy, dan melakukan iterasi pada aplikasi siap pakai.