import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.deepPurple;

  static final ThemeData lightTheme = ThemeData().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: primary,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primary,
      elevation: 0,
    ),
  );
}
