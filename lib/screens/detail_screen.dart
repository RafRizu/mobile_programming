import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  // Variabel untuk menerima data dari layar sebelumnya
  final String judulKursus;
  final String deskripsiKursus;
  const DetailScreen({
    super.key,
    required this.judulKursus,
    required this.deskripsiKursus,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail: $judulKursus',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 100, color: Colors.indigo),
              const SizedBox(height: 24),
              Text(
                judulKursus,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                deskripsiKursus,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Tombol untuk kembali
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Fungsi pop untuk kembali
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Kembali ke Katalog"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
