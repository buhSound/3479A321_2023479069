import 'package:flutter/material.dart';

class AppTheme {
  static const Color primarySeed = Color(0xFF5D4037);
  static const Color boardBaseColor = Color.fromARGB(255, 84, 107, 85);
  static const Color emptyHoleColor = Color.fromARGB(255, 44, 23, 23);

  static ThemeData get lightTheme{
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeed, 
        brightness: Brightness.light, 
        surfaceContainerHighest: const Color.fromARGB(255, 97, 118, 150),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F2EB),
        appBarTheme: const AppBarTheme(          
          centerTitle: true,
          elevation: 0,
          backgroundColor: primarySeed,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          )
        ),
      );
    }
  }