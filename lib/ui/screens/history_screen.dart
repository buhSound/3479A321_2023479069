import 'package:flutter/material.dart';

import '../../models/game_record.dart';

class HistoryScreen extends StatelessWidget{
  const HistoryScreen({super.key});

  List<GameRecord> _getMockRecords(){
    return [
      GameRecord(
        id: 'REC-101',
        date: DateTime.now().subtract(const Duration(hours: 1)),
        remainingPegs: 1,
        totalMoves: 31,
        durationSeconds: 145,
        isVictory: true,

      ),
      GameRecord(
        id: 'REC-102',
        date: DateTime.now().subtract(const Duration(days: 1)),
        remainingPegs: 3,
        totalMoves: 32,
        durationSeconds: 245,
        isVictory: false,
      ),
    ];
  }
  @override
  Widget build(BuildContext context){
    final records = _getMockRecords();
    final theme = Theme.of(context);

    return Scaffold(appBar: AppBar(
      title: const Text('Historial de Partidas'),
    ),

    body: ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: records.length,
      itemBuilder: (context, index){
        final record = records[index];
        return _GameRecordCard(record: record);
      },
    ),
    );
  }
}

class _GameRecordCard extends StatelessWidget{
  final GameRecord record;

  const _GameRecordCard({required this.record});

  String _formatDuration(int totalSeconds){
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    return'${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),

        leading: CircleAvatar(
          backgroundColor: record.isVictory ? Colors.green[100] : Colors.red[100],
          child: Icon(
            record.isVictory ? Icons.emoji_events : Icons.close,
            color: record.isVictory ? Colors.green[800] : Colors.red[800],
          ),
        ),
        title: Text(
          record.isVictory ? 'Victoria!' : 'Derrota',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${record.id} | Movimientos: ${record.totalMoves}'),
              const SizedBox(height: 4),
              Text('Piezas restantes: ${record.remainingPegs}'),
              const SizedBox(height: 4),
              Text('Tiempo: ${_formatDuration(record.durationSeconds)}'),
              const SizedBox(height: 4),
              Text('Fecha: ${record.date.day}/${record.date.month}')
            ],
          ),
        ),
      ),
    );
  }
}