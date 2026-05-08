import 'package:flutter/material.dart';
import 'screens/detail_screen.dart'; // Import halaman detail untuk fungsi onTap

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // Data dummy untuk daftar kursus
  final List<Map<String, String>> daftarKursus = const [
    {
      "judul": "Flutter Dasar",
      "deskripsi": "Pelajari widget dasar dan state management.",
      "ikon": "phone_android",
    },
    {
      "judul": "UI/UX Design",
      "deskripsi": "Buat desain aplikasi yang memukau pengguna.",
      "ikon": "brush",
    },
    {
      "judul": "Backend API",
      "deskripsi": "Hubungkan aplikasi mobile dengan server database.",
      "ikon": "cloud",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Katalog Kursus',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        actions: [
          // Navigasi ke Profil menggunakan Named Route
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/profil');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Mau belajar apa hari ini?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: daftarKursus.length,
                itemBuilder: (context, index) {
                  final kursus = daftarKursus[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.book, color: Colors.indigo),
                      ),
                      title: Text(
                        kursus["judul"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(kursus["deskripsi"]!),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                      // Aksi navigasi ke Layar Detail sambil mengirim data
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              judulKursus: kursus["judul"]!,
                              deskripsiKursus: kursus["deskripsi"]!,
                            ),
                          ),
                        );
                      },
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
