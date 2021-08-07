import 'package:flutter/material.dart';

final blueLightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(backgroundColor: Color(0xFF1767a4)),
  primaryColor: Color(0xFF1767a4),
  scaffoldBackgroundColor: Color(0xFF1767a4),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1767A4),
    selectedItemColor: Colors.white,
    unselectedItemColor: Color(0xFFA2C2DB),
    elevation: 15,
  ),
);

final greyDarkTheme = ThemeData.dark().copyWith(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white54,
    elevation: 15,
  ),
);
