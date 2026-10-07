import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../core/enums/cell_type.dart';
import '../widgets/peg_cell.dart';
import '../../models/game_record.dart';
import '../../models/board_position.dart';
import '../../viewmodels/peg_solitaire_viewmodel.dart';

final _logger = Logger();

class PegSolitaireScreen extends StatefulWidget{
  const PegSolitaireScreen({super.key});

  @override
  State<PegSolitaireScreen> createState() => _PegSolitaireScreenState();
}
class _PegSolitaireScreenState extends State<PegSolitaireScreen> {
  BoardPosition? selectedPosition;

  //Determina tipo de celda
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

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PegSolitaireViewModel>();

    return Scaffold(
      appBar: AppBar(
      title: const Text('Solitario'),
      actions: [
        IconButton(
          icon: const Icon(Icons.bug_report),
          onPressed: () => _simularPartida(),         
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
              child: Center(
                child: Text('Movimientos: ${vm.moveCount} | Piezas restantes: ${vm.remainingPegs}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const Divider(height: 1),
            //Area del Juego
            if(vm.isGameOver)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                color: vm.isVictory ? Colors.green[200] : Colors.orange[200],
                child: Text(
                  vm.isVictory ? 'Victoria! Has limpiado el tablero' : 'Fin del juego',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Expanded(child: _gameBoard(context, vm),
              ),
         ],
       ),
     ),
   );
}

  Widget _gameBoard(BuildContext context, PegSolitaireViewModel vm){
    _logger.i('Construyendo el tablero de juego');
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: PegSolitaireViewModel.gridSize,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount: PegSolitaireViewModel.gridSize * PegSolitaireViewModel.gridSize,
            itemBuilder: (context, index) {
              final int row = index ~/ PegSolitaireViewModel.gridSize;
              final int col = index % PegSolitaireViewModel.gridSize;
              final position = BoardPosition(row, col);
              final CellType cellType = vm.getCellType(row,col);

              return PegCell(
                position: position,
                type: cellType,
                isSelected: position == vm.selectedPosition,
                onTap: () => context.read<PegSolitaireViewModel>().onCellTapped(position),                       
              );
            },
          ),
        ),
      ),
    );
  }  
}
