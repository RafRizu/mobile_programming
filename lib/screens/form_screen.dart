import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../db/database_helper.dart';

class FormScreen extends StatefulWidget {
  final Mahasiswa?
  mahasiswa; // Jika null berarti tambah data, jika ada isi berarti edit
  const FormScreen({super.key, this.mahasiswa});
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // Controller untuk mengambil teks dari inputan
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _nilaiController = TextEditingController();
  // Kunci form untuk validasi
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // Jika widget.mahasiswa tidak null (Mode Edit), isi controller dengan data lama
    if (widget.mahasiswa != null) {
      _nimController.text = widget.mahasiswa!.nim;
      _namaController.text = widget.mahasiswa!.nama;
      _nilaiController.text = widget.mahasiswa!.nilai.toString();
    }
  }

  // Fungsi untuk menyimpan data ke Database
  Future<void> _simpanData() async {
    // Cek apakah semua input sudah valid
    if (_formKey.currentState!.validate()) {
      final mahasiswa = Mahasiswa(
        id: widget.mahasiswa?.id, // Gunakan ID lama jika mode edit
        nim: _nimController.text,
        nama: _namaController.text,
        nilai: double.parse(_nilaiController.text),
      );
      if (widget.mahasiswa == null) {
        // Mode Tambah
        await DatabaseHelper.instance.insertMahasiswa(mahasiswa);
      } else {
        // Mode Edit
        await DatabaseHelper.instance.updateMahasiswa(mahasiswa);
      }
      // Tutup halaman form dan kembali ke halaman sebelumnya
      if (mounted) {
        Navigator.pop(
          context,
          true,
        ); // Kirim flag 'true' agar halaman depan me-refresh data
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mahasiswa == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM'),
                validator: (value) =>
                    value!.isEmpty ? 'NIM tidak boleh kosong' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nilaiController,
                decoration: const InputDecoration(labelText: 'Nilai'),
                keyboardType: TextInputType.number, // Munculkan keyboard angka
                validator: (value) =>
                    value!.isEmpty ? 'Nilai tidak boleh kosong' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _simpanData,
                  child: const Text('Simpan Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
