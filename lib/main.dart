import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solitario Inglés',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const Text('Hola Dieguito!'),
    );
  }
}
