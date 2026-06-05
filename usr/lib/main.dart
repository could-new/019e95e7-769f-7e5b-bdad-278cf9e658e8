import 'package:flutter/material.dart';

void main() {
  runApp(const PolypharmacyWorkbookApp());
}

class PolypharmacyWorkbookApp extends StatelessWidget {
  const PolypharmacyWorkbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workbook Polifarmasi Geriatri',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Workbook Interaksi Obat Lansia'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.menu_book), text: 'Teori Dasar'),
              Tab(icon: Icon(Icons.table_chart), text: 'Worksheet Interaksi'),
              Tab(icon: Icon(Icons.library_books), text: 'Jurnal & Referensi'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TheoryTab(),
            WorksheetTab(),
            JournalTab(),
          ],
        ),
      ),
    );
  }
}

class TheoryTab extends StatelessWidget {
  const TheoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengertian Interaksi Obat',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pada pasien geriatri (lansia), penggunaan banyak obat secara bersamaan (polifarmasi) sangat umum terjadi, terutama pada kasus koinfeksi (seperti HIV dan TB) yang disertai penyakit degeneratif (seperti Hipertensi). Interaksi obat dapat digolongkan menjadi 3 jenis utama:',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildTheoryCard(
          context,
          title: '1. Sinergis',
          icon: Icons.add_circle,
          color: Colors.green,
          description: 'Interaksi di mana efek gabungan dari dua obat jauh lebih besar daripada jumlah efek masing-masing obat (Efek: 1 + 1 > 2).',
          example: 'Contoh: Penggunaan dua jenis antibiotik yang bekerja pada fase berbeda untuk membunuh bakteri dengan lebih cepat.',
        ),
        _buildTheoryCard(
          context,
          title: '2. Aditif',
          icon: Icons.add,
          color: Colors.blue,
          description: 'Interaksi di mana efek gabungan dari dua obat sama dengan jumlah efek masing-masing obat (Efek: 1 + 1 = 2). Keduanya bekerja pada reseptor yang sama atau memiliki efek farmakologis yang searah.',
          example: 'Contoh dalam polifarmasi ini: Efek samping hepatotoksik (merusak hati) dari obat Isoniazid (TB) dan Efavirenz (ARV) bersifat aditif. Jika digunakan bersamaan, risiko kerusakan hati pada lansia meningkat.',
        ),
        _buildTheoryCard(
          context,
          title: '3. Antagonis',
          icon: Icons.remove_circle,
          color: Colors.red,
          description: 'Interaksi di mana satu obat mengurangi, menghambat, atau menghilangkan efek dari obat lain (Efek: 1 + 1 < 2). Seringkali disebabkan oleh persaingan pada reseptor yang sama atau interaksi metabolisme enzim di hati.',
          example: 'Contoh: Rifampisin (TB) adalah penginduksi kuat enzim CYP3A4 di hati. Hal ini akan mempercepat metabolisme Amlodipine (Hipertensi), sehingga efek penurun tekanan darahnya berkurang drastis (antagonis terhadap efektivitas klinis).',
        ),
      ],
    );
  }

  Widget _buildTheoryCard(BuildContext context, {required String title, required IconData icon, required Color color, required String description, required String example}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description),
              const SizedBox(height: 8),
              Text(example, style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}

class WorksheetTab extends StatelessWidget {
  const WorksheetTab({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Worksheet Excel: Analisis Interaksi (Hipertensi, ARV, TB)',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tabel di bawah ini merupakan representasi worksheet untuk analisis interaksi obat geriatri yang dapat Anda salin ke Excel.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.teal.withOpacity(0.1)),
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columns: const [
                    DataColumn(label: Text('Obat 1', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Obat 2', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Jenis Interaksi', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Mekanisme (Farmakokinetik/Dinamik)', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Rekomendasi Klinis Geriatri', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Rifampisin (TB)')),
                      DataCell(Text('Amlodipine (Hipertensi)')),
                      DataCell(Text('Antagonis (Efektivitas)')),
                      DataCell(Text('Rifampisin menginduksi enzim sitokrom P450 (CYP3A4), mempercepat metabolisme Amlodipine sehingga kadarnya dalam darah turun tajam.')),
                      DataCell(Text('Pantau tekanan darah ketat. Dosis Amlodipine mungkin perlu ditingkatkan signifikan atau ganti ke antihipertensi lain yang tidak dimetabolisme CYP3A4.')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Rifampisin (TB)')),
                      DataCell(Text('Lopinavir/Ritonavir (ARV)')),
                      DataCell(Text('Antagonis / Kontraindikasi')),
                      DataCell(Text('Induksi kuat CYP3A4 oleh Rifampisin mengurangi kadar Lopinavir hingga sub-terapeutik, berisiko resistensi virus HIV.')),
                      DataCell(Text('Hindari penggunaan bersamaan. Ganti regimen ARV ke Efavirenz atau Dolutegravir (dengan penyesuaian dosis 50mg 2x sehari) selama terapi TB.')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Isoniazid (TB)')),
                      DataCell(Text('Efavirenz (ARV)')),
                      DataCell(Text('Aditif (Toksisitas)')),
                      DataCell(Text('Keduanya memiliki profil efek samping hepatotoksik (merusak hati). Penggunaan bersamaan meningkatkan risiko gangguan hati.')),
                      DataCell(Text('Pemantauan ketat fungsi hati (SGOT/SGPT) secara berkala, terutama pada pasien lansia yang fungsi organ hatinya sudah menurun.')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Dolutegravir (ARV)')),
                      DataCell(Text('Rifampisin (TB)')),
                      DataCell(Text('Antagonis (Efektivitas)')),
                      DataCell(Text('Rifampisin menginduksi UGT1A1 dan CYP3A4, menurunkan kadar Dolutegravir dalam plasma secara signifikan.')),
                      DataCell(Text('Tingkatkan dosis Dolutegravir menjadi 50 mg DUA KALI sehari selama pengobatan TB, dan kembalikan dosis normal 2 minggu setelah TB selesai.')),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class JournalTab extends StatelessWidget {
  const JournalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Daftar Jurnal & Literatur Referensi (5 Tahun Terakhir)',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildJournalItem(
          title: 'Management of Drug-Drug Interactions Between Antiretroviral and Anti-Tuberculosis Drugs (2022)',
          authors: 'Cerrone, M., et al.',
          journal: 'Drugs - Springer',
          description: 'Membahas secara mendalam interaksi antara Rifampisin dengan ARV modern seperti Dolutegravir dan PI pada pasien dewasa dan geriatri.',
          link: 'https://doi.org/10.1007/s40265-021-01633-9 (Ilustrasi DOI, cari via PubMed)',
        ),
        _buildJournalItem(
          title: 'Polypharmacy and drug-drug interactions among older adults with HIV and non-communicable diseases (2023)',
          authors: 'Gong, J., et al.',
          journal: 'Journal of Antimicrobial Chemotherapy',
          description: 'Studi klinis tentang dampak polifarmasi (termasuk obat hipertensi) pada lansia dengan HIV, menyoroti interaksi CYP3A4 yang memperburuk kondisi kardiovaskular.',
          link: 'https://pubmed.ncbi.nlm.nih.gov/ (Pencarian: Polypharmacy HIV older adults hypertension)',
        ),
        _buildJournalItem(
          title: 'Cardiovascular disease and drug interactions in people living with HIV (2021)',
          authors: 'Bavinger, C., et al.',
          journal: 'Current HIV/AIDS Reports',
          description: 'Fokus pada interaksi spesifik antara obat antihipertensi (seperti Calcium Channel Blockers / Amlodipine) dengan ARV dan obat koinfeksi (TB).',
          link: 'https://doi.org/10.1007/s11904-021-00560-6',
        ),
      ],
    );
  }

  Widget _buildJournalItem({required String title, required String authors, required String journal, required String description, required String link}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text('$authors | $journal', style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.teal)),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            SelectableText('Tautan/Akses: $link', style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
