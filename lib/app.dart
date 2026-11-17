import 'package:flutter/material.dart';
import 'core/theme/asho_theme.dart';
import 'features/home/home_screen.dart';

class AshoApp extends StatefulWidget {
  const AshoApp({super.key});

  @override
  State<AshoApp> createState() => _AshoAppState();
}

class _AshoAppState extends State<AshoApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أشو الإسلامية',
      debugShowCheckedModeBanner: false,
      theme: AshoTheme.light,
      darkTheme: AshoTheme.dark,
      themeMode: _themeMode,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      home: HomeScreen(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
