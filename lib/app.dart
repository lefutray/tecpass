import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tec_pass/views/authentication/login.dart';
import 'package:tec_pass/views/authentication/register.dart';
import 'package:tec_pass/views/home.dart';

class App {
  static final App _instance = App._();
  App._();

  late final SharedPreferences _preferences;
  late final _Theme theme;
  late final API api;
  late final User user;

  factory App() {
    return _instance;
  }

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    theme = _Theme(_preferences);
    user = User(_preferences);
    api = API();
  }

  Future<bool> login({required String email, required String password}) async {
    if (await api.login(email: email, password: password)) {
      await user.save(email: email, password: password);
    }
    return true;
  }

  Future<bool> register({
    required String fullName,
    required String mobile,
    required String rut,
    required String email,
    required String password,
  }) async {
    if (await api.register(
      email: email,
      password: password,
      fullName: fullName,
      mobile: mobile,
      rut: rut,
    )) {
      await user.save(email: email, password: password);
    }
    return true;
  }

  Future<bool> logout(BuildContext context) async {
    final result = await user.logout();
    Navigator.of(context).pushReplacementNamed('login');
    return result;
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
          builder: (_) => LoginPage(),
        );
      case 'register':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RegisterPage(),
        );
    }
  }

  final Set<String> discoveryItems = {
    'access_tab',
    'place_widget',
    'place_enter_widget',
    'place_exit_widget',
    'visits_tab',
    'perfil_tab',
    'theme_switcher',
  };
}

class API {
  Future<bool> login({required String email, required String password}) async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 2));
    print('logged in');
    return true;
  }

  Future<bool> register({
    required String fullName,
    required String mobile,
    required String rut,
    required String email,
    required String password,
  }) async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 2));
    print('logged in');
    return true;
  }
}

class User {
  late final String? email;
  late final String? password;
  late final bool isSet;
  late final SharedPreferences _preferences;

  User(SharedPreferences preferences) {
    _preferences = preferences;
    email = preferences.getString('email');
    password = preferences.getString('password'); // TODO: convert password to token
    isSet = email != null;
  }

  save({required String password, required String email}) async {
    return Future.wait([
      _preferences.setString('email', email),
      _preferences.setString('password', password),
    ]);
  }

  Future<bool> logout() async {
    await _preferences.remove('email');
    await _preferences.remove('password');
    return true;
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
