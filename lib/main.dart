import 'package:flutter/material.dart';
// Mengimpor file screen yang kita buat di folder screens
import 'main2.dart';
import 'screens/profile_screen.dart';
import 'screens/home_crud.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum SQLite',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeCrud(),
      debugShowCheckedModeBanner: false,
    );
  }
}
