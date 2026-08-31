import 'package:flutter/material.dart';
import 'ui/screens/peg_solitaire_screen.dart';
void main() {
  runApp(const MyApp()); 
}

//Estados de la celda del tablero
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solitario Inglés',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const PegSolitaireScreen(),
    );
  }
}




  



