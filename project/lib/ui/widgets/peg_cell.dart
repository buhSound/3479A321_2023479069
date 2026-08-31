import 'package:flutter/material.dart';
import '/core/enums/cell_type.dart';

class PegCell extends StatelessWidget {
  final int row;
  final int col;
  final CellType type;
  final bool isSelected;
  final VoidCallback? onTap;

  const PegCell({
    super.key,
    required this.row,
    required this.col,
    required this.type,
    this.isSelected = false,
    this.onTap,   
  });

  @override
  Widget build(BuildContext context) {
    //ocultar esquinas para ver la fomra de cruz
    if (type == CellType.voidCell){
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          border: Border.all(color: Colors.grey[600]!, width: 1.5),
        ),
      child: Center(
        child: type == CellType.occupiedPeg
          ? Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          )
        : type == CellType.emptyHole
          ? Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 
                  20)
                    :Image.asset('assets/icons/NombreName.png'),
            )
          : null, 
          ),
        ),
    );
  }
}