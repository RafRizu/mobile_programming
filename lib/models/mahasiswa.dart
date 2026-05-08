class Mahasiswa {
  int? id;
  String nim;
  String nama;
  double nilai;
  // Constructor
  Mahasiswa({
    this.id,
    required this.nim,
    required this.nama,
    required this.nilai,
  });
  // Fungsi untuk mengubah object Mahasiswa menjadi Map (Format JSON/Dictionary)
  // Ini wajib dilakukan karena SQLite hanya menerima data dalam bentuk Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'nim': nim, 'nama': nama, 'nilai': nilai};
  }

  // Fungsi untuk mengubah Map dari database kembali menjadi object Mahasiswa
  factory Mahasiswa.fromMap(Map<String, dynamic> map) {
    return Mahasiswa(
      id: map['id'],
      nim: map['nim'],
      nama: map['nama'],
      nilai: map['nilai'],
    );
  }
}
