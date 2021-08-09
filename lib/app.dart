import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tec_pass/views/home.dart';

class App {
  static final App _instance = App._();
  App._();

  late final SharedPreferences _preferences;
  late final _Theme theme;
  late final _ShowcaseSettings showcaseSettings;

  factory App() {
    return _instance;
  }

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    theme = _Theme(this._preferences);
    showcaseSettings = _ShowcaseSettings(this._preferences);
  }

  void cacheImages(BuildContext context) async {
    await precacheImage(AssetImage('assets/Logo-tecpass-s.png'), context);
    await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/Check.svg'), context);
    await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/Cancelar.svg'), context);
  }

  Route<dynamic>? routes(RouteSettings? settings) {
    switch (settings?.name) {
      case 'home':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );
      case 'login':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );
      case 'register':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );
    }
  }
}

class _Theme {
  _Theme(this._preferences) {
    _themes = {
      'dark': darkTheme,
      'light': lightTheme,
    };
  }

  final SharedPreferences _preferences;

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

class _ShowcaseSettings {
  _ShowcaseSettings(this._preferences);

  void initialize(BuildContext context) {
    if (showcase) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        ShowCaseWidget.of(context)?.startShowCase([
          accessTabKey,
          placeWidgetKey,
          placeWidgetEnterKey,
          placeWidgetExitKey,
          visitsTabKey,
          profileTabKey,
          themeSwitcherKey,
        ]);
      });
    }
  }

  bool get showcase {
    return _preferences.getBool('showcase') ?? true;
  }

  Future<bool> setShowcase(bool showcase) async {
    return await _preferences.setBool('showcase', showcase);
  }

  Future<bool> finish() async {
    return await _preferences.setBool('showcase', false);
  }

  startShowcase(BuildContext context) async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)?.startShowCase([
        accessTabKey,
        placeWidgetKey,
        placeWidgetEnterKey,
        placeWidgetExitKey,
        visitsTabKey,
        profileTabKey,
        themeSwitcherKey,
      ]);
    });
  }

  final SharedPreferences _preferences;

  final accessTabKey = GlobalKey();
  final placeWidgetKey = GlobalKey();
  final placeWidgetEnterKey = GlobalKey();
  final placeWidgetExitKey = GlobalKey();
  final visitsTabKey = GlobalKey();
  final profileTabKey = GlobalKey();
  final themeSwitcherKey = GlobalKey();
}
