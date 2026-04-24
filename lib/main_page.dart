import 'package:flutter/material.dart';
import 'models/student.dart'; // Import model data kita

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Inisialisasi Array (List) untuk menampung data mahasiswa
  final List<Student> _students = [];
  // 2. Controller untuk mengambil teks yang diketik user
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // Fungsi untuk memasukkan data ke dalam List
  void _addStudent() {
    // Validasi sederhana agar tidak menyimpan data kosong
    if (_nimController.text.isNotEmpty && _nameController.text.isNotEmpty) {
      // setState memberitahu Flutter bahwa ada perubahan data,
      // sehingga layar harus di-render ulang
      setState(() {
        _students.add(
          Student(nim: _nimController.text, name: _nameController.text),
        );
      });
      // Bersihkan kolom input setelah berhasil disimpan
      _nimController.clear();
      _nameController.clear();
    }
  }

  @override
  void dispose() {
    // Selalu bersihkan controller saat widget dihancurkan untuk mencegah memory leak
    _nimController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Mahasiswa'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- BAGIAN FORM INPUT ---
            TextField(
              controller: _nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Mahasiswa',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 134, 9, 9),
                ),
                child: ElevatedButton(
                  onPressed: _addStudent,
                  child: const Text('Simpan Data'),
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Daftar Mahasiswa:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // --- BAGIAN MENAMPILKAN DATA (ARRAY) ---
            // Expanded digunakan agar list mengambil sisa ruang kosong di layar
            Expanded(
              child: _students.isEmpty
                  ? const Center(child: Text('Belum ada data mahasiswa.'))
                  : ListView.builder(
                      itemCount: _students.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(child: Text('${index + 1}')),
                            title: Text(_students[index].name),
                            subtitle: Text('NIM: ${_students[index].nim}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
