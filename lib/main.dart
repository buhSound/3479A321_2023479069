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
      home: const PegSolitaireScreen(),
    );
  }
}

class PegSolitaireScreen extends StatelessWidget {
  const PegSolitaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solitario')),
      body: SafeArea(
        child: Column(
          children: [
            //Area de Status
            Container(
              height:60,
              color: Colors.grey[300],
              child: const Center(
                child: Text('Status: 349 segundos | Piezas restantes: 33',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const Divider(height: 1),
            //Area del Juego
            Expanded(
              child: _gameBoard(),
            ),
         ],
       ),
     ),
   );
}

  Widget _gameBoard(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount:49,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  border: Border.all(color: Colors.grey[600]!, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}



