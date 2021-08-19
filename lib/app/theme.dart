import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  AppTheme(this._preferences) {
    _themes = {
      'dark': darkTheme,
      'light': lightTheme,
    };
  }

  final SharedPreferences _preferences;

  ThemeData _auto() {
    changeTheme('light');
    
    return lightTheme;
  }

  ThemeData get current {
    final savedTheme = _preferences.getString('theme');
    return _themes[savedTheme] ?? _auto();
  }

  Future<bool> changeTheme(String theme) async {
    return await _preferences.setString('theme', theme);
  }

  late final Map<String, ThemeData> _themes;

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;

  // themes:
  final _lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1767a4),
      centerTitle: true,
    ),
    primaryColor: Color(0xFF1767a4),
    scaffoldBackgroundColor: Color(0xFF1767a4),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1767A4),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFFA2C2DB),
      elevation: 15,
    ),
    primaryColorLight: Color(0xFF000000),
    primaryColorDark: Color(0xFF000000),
  );

  final _darkTheme = ThemeData.dark().copyWith(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      elevation: 15,
    ),
  );
}
