import 'package:flutter/material.dart';
import 'ui/screens/peg_solitaire_screen.dart';
import 'package:logger/logger.dart';
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

final _logger = Logger();
  
class RulesScreen extends StatelessWidget{
  const RulesScreen ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reglas del Juego'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Reglas del Juego',
            onPressed: (){
              _logger.i('Navegando a Rulescreen desde PegSolitaireScreen');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RulesScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Objetivo',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Eliminar clavijas saltand sobre ellas', 
                    style: TextStyle(fontSize: 14, height: 1.4),
                    ),               
                  ],
                ),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver al Juego'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}




  



