import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/board_position.dart';
import '../core/enums/cell_type.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class PegSolitaireViewModel extends ChangeNotifier{
  static const int gridSize = 7;

  late List<List<CellType>> _board;
  BoardPosition? _selectedPosition;
  int _remainingPegs = 0;
  int _moveCount = 0;
  bool _isGameOver = false;
  bool _isVictory = false;

  List<List<CellType>> get board => _board;
  BoardPosition? get selectedPosition => _selectedPosition;
  int get remainingPegs => _remainingPegs; 
  int get moveCount => _moveCount;
  bool get isGameOver => _isGameOver;
  bool get isVictory => _isVictory;

  PegSolitaireViewModel(){
    initializeBoard();
  }

  void initializeBoard(){
    _board = List.generate(gridSize, (row){
      return List.generate(gridSize, (col){
        if((row < 2 || row > 4) && (col < 2 || col > 4)){
          return CellType.voidCell;
        }

        if (row == 3 && col == 3){
          return CellType.emptyHole;
        }
        return CellType.occupiedPeg;
      });
    });
    _selectedPosition = null;
    _remainingPegs = 32;
    _moveCount = 0;
    _isGameOver = false;
    _isVictory = false;

    notifyListeners();
  }

  CellType getCellType(int row, int col){
    if(row < 0 || row >= gridSize || col < 0 || col >= gridSize){
      return CellType.voidCell;
    }
    return _board[row][col];
  }
  void onCellTapped(BoardPosition pos){
    if(_isGameOver){
      return;
    }
    final CellType tappedType = _board[pos.row][pos.col];
    if(tappedType == CellType.voidCell) return;

    if(_selectedPosition == null){
      if(tappedType == CellType.occupiedPeg){
        _selectedPosition = pos;
        notifyListeners();
      }
      return;
    }  
    //estado 1: Existe una clavija origen activa
    final BoardPosition origin = _selectedPosition!;

    //transiciopn 1.1: pulsar sobre la misma casilla -> Deseleccion
    if(origin == pos) {
      _selectedPosition = null;
      notifyListeners();
      return;
    }

    //Transicion 1.2: Pulsar sobre una clavija propia 
    if(tappedType == CellType.occupiedPeg){
      _selectedPosition = pos;
      notifyListeners();
      return;
    }

    //Transicion 1.3: Pulsar sobre un hueco vacion ->Evaluar salto y captura
    if(tappedType == CellType.emptyHole){
      if(_isValidMove(origin, pos)){
        _executeMove(origin, pos);
        _selectedPosition = null;
        _evaluateGameTermination();
        notifyListeners();
      } else {
        logger.w('Reglas: Intento de salto invalido rechazado desde $origin hacia $pos');
      }
    }
  }

  bool _isValidMove(BoardPosition from, BoardPosition to){
    final int rowDelta = (from.row - to.row).abs();
    final int colDelta = (from.col - to.col).abs();

    //1. Debe ser un salto ortogonal estricto de distancia 2
    final bool isOrthogonalTwoStep = 
      (rowDelta == 2 && colDelta == 0) || (rowDelta == 0 && colDelta == 2);
    if(!isOrthogonalTwoStep) return false;

    //2. El destino debe ser un hueco vacio 
    if(_board[to.row][to.col] != CellType.emptyHole) return false;

    //3. La celda intermedia debe contener una clavija para ser capturada
    final int midRow = (from.row + to.row) ~/ 2;
    final int midCol = (from.col + to.col) ~/ 2;
    if (_board[midRow][midCol] != CellType.occupiedPeg) return false;

    return true;
  }

  void _executeMove(BoardPosition from, BoardPosition to){
    final int midRow = (from.row + to.row) ~/ 2;
    final int midCol = (from.col + to.col) ~/ 2;

    _board[from.row][from.col] = CellType.emptyHole;
    _board[midRow][midCol] = CellType.emptyHole;
    _board[to.row][to.col] = CellType.occupiedPeg;

    _remainingPegs--;
    _moveCount++;

    logger.i('Salto ejecutado con exito: $from -> $to | clavijas restantes: $_remainingPegs');
  }

  void _evaluateGameTermination(){
    if(_remainingPegs == 1){
      _isGameOver = true;
      _isVictory = true;
      logger.i('Victoria! Partida completa en $_moveCount movimientos.');
      return;
    }

    if(!_hasValidMovesRemaining()){
      _isGameOver = true;
      _isVictory = false;
      logger.w('Fin de juego por bloqueo. No existen movimientos validos');
    }
  }
  bool _hasValidMovesRemaining() {
  const List<List<int>> directions = [
    [-2, 0], // Arriba
    [2, 0], // Abajo
    [0, -2], // Izquierda
    [0, 2], // Derecha
  ];
  for (int r = 0; r < gridSize; r++) {
    for (int c = 0; c < gridSize; c++) {
      if (_board[r][c] == CellType.occupiedPeg) {
        final from = BoardPosition(r, c);
        for (final dir in directions) {
          final int targetRow = r + dir[0];
          final int targetCol = c + dir[1];
  // Validar que el salto potencial no desborde los límites de la matriz
          if (targetRow >= 0 && targetRow < gridSize &&
              targetCol >= 0 && targetCol < gridSize) {
            final to = BoardPosition(targetRow, targetCol);
            if (_board[targetRow][targetCol] != CellType.voidCell &&
                _isValidMove(from, to)) {
                return true; // Existe al menos un movimiento válido en el tablero
              }
            }
          }
        }
      }
    }
  return false;
  }
}
