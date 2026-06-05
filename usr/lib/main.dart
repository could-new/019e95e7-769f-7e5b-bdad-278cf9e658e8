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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // State untuk Data Pasien
  String namaPasien = '';
  int usiaPasien = 0;
  List<String> obatPasien = [];

  // Database Obat Interaksi Sederhana
  final List<Map<String, String>> databaseInteraksi = [
    {
      'obat1': 'Rifampisin (TB)',
      'obat2': 'Amlodipine (Hipertensi)',
      'interaksi': 'Antagonis',
      'mekanisme': 'Rifampisin menginduksi enzim sitokrom P450 (CYP3A4), mempercepat metabolisme Amlodipine sehingga kadarnya turun.',
      'rekomendasi': 'Pantau tekanan darah ketat. Dosis Amlodipine mungkin perlu ditingkatkan.',
    },
    {
      'obat1': 'Rifampisin (TB)',
      'obat2': 'Lopinavir/Ritonavir (ARV)',
      'interaksi': 'Antagonis',
      'mekanisme': 'Induksi kuat CYP3A4 oleh Rifampisin mengurangi kadar Lopinavir hingga sub-terapeutik.',
      'rekomendasi': 'Hindari penggunaan bersamaan. Ganti regimen ARV ke Efavirenz atau Dolutegravir.',
    },
    {
      'obat1': 'Isoniazid (TB)',
      'obat2': 'Efavirenz (ARV)',
      'interaksi': 'Aditif',
      'mekanisme': 'Keduanya memiliki profil efek samping hepatotoksik (merusak hati).',
      'rekomendasi': 'Pemantauan ketat fungsi hati (SGOT/SGPT) berkala pada lansia.',
    },
    {
      'obat1': 'Dolutegravir (ARV)',
      'obat2': 'Rifampisin (TB)',
      'interaksi': 'Antagonis',
      'mekanisme': 'Rifampisin menginduksi UGT1A1 dan CYP3A4, menurunkan kadar Dolutegravir signifikan.',
      'rekomendasi': 'Tingkatkan dosis Dolutegravir menjadi 50 mg 2x sehari selama terapi TB.',
    },
    {
      'obat1': 'Tenofovir (ARV)',
      'obat2': 'Lisinopril (Hipertensi)',
      'interaksi': 'Aditif',
      'mekanisme': 'Keduanya dapat mempengaruhi fungsi ginjal (nefrotoksisitas).',
      'rekomendasi': 'Pantau fungsi ginjal (kreatinin serum) rutin.',
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _tambahObat(String obat) {
    if (!obatPasien.contains(obat)) {
      setState(() {
        obatPasien.add(obat);
      });
    }
  }

  void _hapusObat(String obat) {
    setState(() {
      obatPasien.remove(obat);
    });
  }

  List<Map<String, String>> _analisisInteraksi() {
    List<Map<String, String>> hasil = [];
    for (int i = 0; i < obatPasien.length; i++) {
      for (int j = i + 1; j < obatPasien.length; j++) {
        String o1 = obatPasien[i];
        String o2 = obatPasien[j];
        
        var interaksi = databaseInteraksi.where((e) => 
          (e['obat1'] == o1 && e['obat2'] == o2) || 
          (e['obat1'] == o2 && e['obat2'] == o1)
        ).toList();

        hasil.addAll(interaksi);
      }
    }
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workbook Polifarmasi Geriatri'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Input Pasien'),
            Tab(icon: Icon(Icons.dataset), text: 'Database Interaksi'),
            Tab(icon: Icon(Icons.analytics), text: 'Dashboard Analisis'),
            Tab(icon: Icon(Icons.local_hospital), text: 'Manajemen Terapi'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInputPasienTab(),
          _buildDatabaseTab(),
          _buildDashboardAnalisisTab(),
          _buildManajemenTerapiTab(),
        ],
      ),
    );
  }

  Widget _buildInputPasienTab() {
    final TextEditingController namaCtrl = TextEditingController(text: namaPasien);
    final TextEditingController usiaCtrl = TextEditingController(text: usiaPasien > 0 ? usiaPasien.toString() : '');

    List<String> daftarObatPilihan = [
      'Rifampisin (TB)', 'Isoniazid (TB)', 'Amlodipine (Hipertensi)', 
      'Lisinopril (Hipertensi)', 'Lopinavir/Ritonavir (ARV)', 
      'Efavirenz (ARV)', 'Dolutegravir (ARV)', 'Tenofovir (ARV)'
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Data Pasien Geriatri', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(
            controller: namaCtrl,
            decoration: const InputDecoration(labelText: 'Nama Pasien', border: OutlineInputBorder()),
            onChanged: (val) => namaPasien = val,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: usiaCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Usia', border: OutlineInputBorder()),
            onChanged: (val) => usiaPasien = int.tryParse(val) ?? 0,
          ),
          const SizedBox(height: 20),
          const Text('Pilih Obat Saat Ini:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8.0,
            children: daftarObatPilihan.map((obat) {
              return ActionChip(
                label: Text(obat),
                onPressed: () => _tambahObat(obat),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text('Obat Terpilih:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: obatPasien.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(obatPasien[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _hapusObat(obatPasien[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDatabaseTab() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16.0),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.teal.shade50),
          columns: const [
            DataColumn(label: Text('Obat 1', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Obat 2', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Jenis Interaksi', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Mekanisme', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: databaseInteraksi.map((data) => DataRow(cells: [
            DataCell(Text(data['obat1']!)),
            DataCell(Text(data['obat2']!)),
            DataCell(Text(data['interaksi']!)),
            DataCell(SizedBox(width: 300, child: Text(data['mekanisme']!))),
          ])).toList(),
        ),
      ),
    );
  }

  Widget _buildDashboardAnalisisTab() {
    List<Map<String, String>> hasilAnalisis = _analisisInteraksi();

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Analisis Interaksi Pasien: $namaPasien ($usiaPasien Tahun)', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Total Obat: ${obatPasien.length}'),
                Text('Ditemukan ${hasilAnalisis.length} potensi interaksi obat.', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...hasilAnalisis.map((interaksi) => Card(
          color: interaksi['interaksi'] == 'Antagonis' ? Colors.red.shade50 : Colors.orange.shade50,
          child: ListTile(
            title: Text('${interaksi['obat1']} + ${interaksi['obat2']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('Jenis: ${interaksi['interaksi']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Mekanisme: ${interaksi['mekanisme']}'),
              ],
            ),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildManajemenTerapiTab() {
    List<Map<String, String>> hasilAnalisis = _analisisInteraksi();

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('Rekomendasi Terapi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        if (hasilAnalisis.isEmpty)
          const Text('Belum ada interaksi obat yang memerlukan manajemen terapi saat ini.')
        else
          ...hasilAnalisis.map((interaksi) => Card(
            child: ListTile(
              leading: const Icon(Icons.warning, color: Colors.amber),
              title: Text('Perhatian: ${interaksi['interaksi']}'),
              subtitle: Text(interaksi['rekomendasi']!),
            ),
          )).toList(),
        
        const Divider(height: 40),
        const Text('Referensi Jurnal Interaksi ARV, TB, Hipertensi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const ListTile(
          leading: Icon(Icons.menu_book),
          title: Text('Babadoko, A. A., et al. (2021)'),
          subtitle: Text('Drug-drug interactions among HIV/TB co-infected patients. Journal of Pharmacy & Bioallied Sciences.'),
        ),
        const ListTile(
          leading: Icon(Icons.menu_book),
          title: Text('Gengiah, S., et al. (2020)'),
          subtitle: Text('Drug interactions between antiretrovirals and antituberculosis drugs: clinical considerations. Clinical Pharmacokinetics.'),
        ),
        const ListTile(
          leading: Icon(Icons.menu_book),
          title: Text('Gong, J., et al. (2023)'),
          subtitle: Text('Polypharmacy and drug-drug interactions among older adults with HIV and non-communicable diseases. Journal of Antimicrobial Chemotherapy.'),
        ),
      ],
    );
  }
}
