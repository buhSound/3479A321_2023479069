import 'package:flutter/material.dart';
import '../../core/enums/cell_type.dart';
import '../widgets/peg_cell.dart';
import 'package:logger/logger.dart';
import '../../models/game_record.dart';

final _logger = Logger();

void _simularPartida(){
  final testGame = GameRecord(
    id:'test_001',
    date: DateTime.now(),
    remainingPegs: 1,
    totalMoves: 31,
    durationSeconds: 349,
    isVictory: true,
  );

  _logger.i('''
  Simulacion de Partida
  ID: ${testGame.id}
  Fecha: ${testGame.date}
  Piezas restantes: ${testGame.remainingPegs}
  Victoria: ${testGame.isVictory}
 ''');
}
class PegSolitaireScreen extends StatelessWidget {
  const PegSolitaireScreen({super.key});

  static const int gridSize = 7;
  static const int totalCells = gridSize * gridSize;

  //Determina tipo de celda

  CellType _getCellType(int row, int col){
    final bool isCorner = (row < 2 || row > 4) && (col < 2 || col > 4);
    if(isCorner){
      return CellType.voidCell;
    }
    return CellType.occupiedPeg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Solitario'),
      actions: [
        IconButton(
          icon: const Icon(Icons.bug_report),
          onPressed: () {
            _simularPartida();
          },
        ),
      ],
    ),
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
              //convertir indice en coordenadas matriciales
              final int row = index ~/ gridSize;
              final int col = index % gridSize;
              final CellType cellType = _getCellType(row, col);

              return PegCell(
                row: row,
                col: col,
                type: cellType,
                isSelected: false,
                onTap: (){
                 
                },          
              );
            },
          ),
        ),
      ),
    );
  }  
}