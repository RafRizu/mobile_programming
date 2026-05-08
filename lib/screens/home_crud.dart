import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../db/database_helper.dart';
import 'form_screen.dart';



class HomeCrud extends StatefulWidget {
  const HomeCrud({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeCrud> {
  // Variabel untuk menampung data dari database
  List<Mahasiswa> daftarMahasiswa = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _refreshData(); // Ambil data saat aplikasi pertama kali dibuka
  }

  // Fungsi untuk mengambil data dari SQLite
  Future<void> _refreshData() async {
    setState(() => isLoading = true);
    // Memanggil fungsi getAllMahasiswa dari Helper
    daftarMahasiswa = await DatabaseHelper.instance.getAllMahasiswa();
    setState(() => isLoading = false);
  }

  // Fungsi untuk menghapus data
  Future<void> _hapusData(int id) async {
    await DatabaseHelper.instance.deleteMahasiswa(id);
    _refreshData(); // Refresh list setelah dihapus
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data berhasil dihapus')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Mahasiswa (SQLite)')),
      // Tampilkan indikator loading jika data sedang diambil
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : daftarMahasiswa.isEmpty
          ? const Center(child: Text('Belum ada data mahasiswa'))
          : ListView.builder(
              itemCount: daftarMahasiswa.length,
              itemBuilder: (context, index) {
                final mhs = daftarMahasiswa[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(mhs.nilai.toString()), // Menampilkan nilai
                    ),
                    title: Text(mhs.nama),
                    subtitle: Text('NIM: ${mhs.nim}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol Edit
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            // Pindah ke form dengan mengirim data mhs
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FormScreen(mahasiswa: mhs),
                              ),
                            );
                            // Jika form mengembalikan true, refresh data
                            if (result == true) {
                              _refreshData();
                            }
                          },
                        ),
                        // Tombol Hapus
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _hapusData(mhs.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Pindah ke form tambah data
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormScreen()),
          );
          if (result == true) {
            _refreshData();
          }
        },
      ),
    );
  }
}
