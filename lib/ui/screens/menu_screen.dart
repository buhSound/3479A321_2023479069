import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget{
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Solitario Ingles',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 60),

              _MenuButton(
                label: 'Nueva Partida',
                icon: Icons.play_arrow,
                onPressed: () => Navigator.pushNamed(context, '/juego')
              ),
              const SizedBox(height: 16),
              _MenuButton(
                label: 'Historial',
                icon: Icons.history,
                onPressed: () => Navigator.pushNamed(context, '/historial'),
              ),
              const SizedBox(height: 16),
              _MenuButton(
                label: 'Reglas',
                icon: Icons.rule,
                onPressed: () => Navigator.pushNamed(context, '/reglas'),
              ),
              const SizedBox(height: 16),
              _MenuButton(
                label: 'Acerca de', 
                icon: Icons.info_outline,
                onPressed: () => Navigator.pushNamed(context, '/sobre'),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
 }

 class _MenuButton extends StatelessWidget{
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _MenuButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context){
    return ElevatedButton.icon(
      style:ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 28),
      label: Text(label),
    );
  }
}