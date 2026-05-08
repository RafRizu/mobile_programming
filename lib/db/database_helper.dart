import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/mahasiswa.dart';

class DatabaseHelper {
  // Singleton pattern: Memastikan hanya ada 1 koneksi database yang terbuka
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();
  // Getter untuk mengambil database, jika belum ada maka akan dibuat (initDB)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mahasiswa.db');
    return _database!;
  }

  // Fungsi untuk inisialisasi / membuat file database
  Future<Database> _initDB(String filePath) async {
    // Mendapatkan lokasi default penyimpanan database di perangkat Android/iOS
    final dbPath = await getDatabasesPath();
    // Menggabungkan path dengan nama file db
    final path = join(dbPath, filePath);
    // Membuka database. Jika belum ada, akan memanggil fungsi _createDB
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Fungsi untuk membuat tabel saat database pertama kali dibuat
  Future _createDB(Database db, int version) async {
    // Menjalankan query SQL untuk membuat tabel
    await db.execute('''
CREATE TABLE tb_mahasiswa (
id INTEGER PRIMARY KEY AUTOINCREMENT,
nim TEXT NOT NULL,
nama TEXT NOT NULL,
nilai REAL NOT NULL
)
''');
  }

  // 1. CREATE (Menambah Data)
  Future<int> insertMahasiswa(Mahasiswa mahasiswa) async {
    final db = await instance.database;
    // Menyimpan data ke tabel tb_mahasiswa. conflictAlgorithm mencegah error jika ada data ganda
    return await db.insert(
      'tb_mahasiswa',
      mahasiswa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 2. READ (Membaca Semua Data)
  Future<List<Mahasiswa>> getAllMahasiswa() async {
    final db = await instance.database;
    // Query untuk mengambil semua data, diurutkan berdasarkan NIM
    final result = await db.query('tb_mahasiswa', orderBy: 'nim ASC');
    // Mengubah hasil query (List of Map) menjadi List of Object Mahasiswa
    return result.map((map) => Mahasiswa.fromMap(map)).toList();
  }

  // 3. UPDATE (Mengubah Data)
  Future<int> updateMahasiswa(Mahasiswa mahasiswa) async {
    final db = await instance.database;
    return await db.update(
      'tb_mahasiswa',
      mahasiswa.toMap(),
      where: 'id = ?', // Syarat: ID harus sesuai
      whereArgs: [mahasiswa.id], // Nilai ID yang diupdate
    );
  }

  // 4. DELETE (Menghapus Data)
  Future<int> deleteMahasiswa(int id) async {
    final db = await instance.database;
    return await db.delete('tb_mahasiswa', where: 'id = ?', whereArgs: [id]);
  }
}
