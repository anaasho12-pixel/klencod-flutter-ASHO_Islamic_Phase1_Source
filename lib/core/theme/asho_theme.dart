import 'package:flutter/material.dart';

class AshoColors {
  static const emerald = Color(0xFF102D27);
  static const emeraldLight = Color(0xFF174638);
  static const gold = Color(0xFFC5A15B);
  static const cream = Color(0xFFF5EEDC);
  static const darkBackground = Color(0xFF0B1714);
  static const darkSurface = Color(0xFF142720);
}

class AshoTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AshoColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: AshoColors.gold,
          secondary: AshoColors.emeraldLight,
          surface: AshoColors.darkSurface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AshoColors.darkBackground,
          foregroundColor: AshoColors.cream,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardTheme(
          color: AshoColors.darkSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(color: AshoColors.gold.withValues(alpha: .18)),
          ),
        ),
        fontFamily: 'sans-serif',
      );

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AshoColors.cream,
        colorScheme: const ColorScheme.light(
          primary: AshoColors.emerald,
          secondary: AshoColors.gold,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AshoColors.cream,
          foregroundColor: AshoColors.emerald,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      );
}
