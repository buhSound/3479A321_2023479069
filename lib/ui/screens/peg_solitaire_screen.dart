import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../core/enums/cell_type.dart';
import '../widgets/peg_cell.dart';
import '../../models/game_record.dart';
import '../../models/board_position.dart';

final _logger = Logger();

class PegSolitaireScreen extends StatefulWidget{
  const PegSolitaireScreen({super.key});

  @override
  State<PegSolitaireScreen> createState() => _PegSolitaireScreenState();
}
class _PegSolitaireScreenState extends State<PegSolitaireScreen> {
  static const int gridSize = 7;
  static const int totalCells = gridSize * gridSize;

  BoardPosition? selectedPosition;

  //Determina tipo de celda

  CellType _getCellType(BoardPosition pos){
    final bool isCorner = (pos.row < 2 || pos.row > 4) && (pos.col < 2 || pos.col > 4);
    if(isCorner){
      return CellType.voidCell;
    }
    return CellType.occupiedPeg;
  }
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

  void _handleCellTapper(BoardPosition pos, CellType type){
  if (type == CellType.voidCell) return;

  setState((){
    if(selectedPosition == pos){
      _logger.d ('Deseleccionada celda en $pos');
      selectedPosition = null;
    } else {
      selectedPosition = pos;
      _logger.d('Seleccionada la celda $pos | Tipo: $type');
    }
  });
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
                child: Text('Status: 379 segundos | Piezas restantes: 33',
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
            itemCount:totalCells,
            itemBuilder: (context, index) {
              //convertir indice en coordenadas matriciales
              final pos = BoardPosition(index ~/gridSize, index % gridSize);
              final CellType cellType = _getCellType(pos);

              final bool isCurrentlySelected = (pos == selectedPosition);

              return PegCell(
                position: pos,
                type: cellType,
                isSelected: isCurrentlySelected,
                onTap: () => _handleCellTapper(pos, cellType),                       
              );
            },
          ),
        ),
      ),
    );
  }  
}
