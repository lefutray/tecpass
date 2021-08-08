import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static final App _instance = App._();
  App._();

  late final SharedPreferences _preferences;
  late final _Theme theme;

  factory App() {
    return _instance;
  }

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    theme = _Theme(this._preferences);
  }
}

class _Theme {
  _Theme(this._preferences) {
    _themes = {'dark': darkTheme, 'light': lightTheme};
  }

  late final SharedPreferences _preferences;

  ThemeData _auto() {
    if (WidgetsBinding.instance?.window.platformBrightness == Brightness.dark) {
      changeTheme('dark');
      return darkTheme;
    }
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

  final lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF1767a4), centerTitle: true),
    primaryColor: Color(0xFF1767a4),
    scaffoldBackgroundColor: Color(0xFF1767a4),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1767A4),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFFA2C2DB),
      elevation: 15,
    ),
  );

  final darkTheme = ThemeData.dark().copyWith(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      elevation: 15,
    ),
  );
}
