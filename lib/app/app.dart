import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tec_pass/app/theme.dart';

import 'package:tec_pass/helpers/helpers.dart';
import 'package:tec_pass/repositories/auth_repository.dart';
import 'package:tec_pass/views/authentication/login.dart';
import 'package:tec_pass/views/authentication/register.dart';
import 'package:tec_pass/views/authentication/relogin.dart';
import 'package:tec_pass/views/home.dart';

class App {
  static final App _instance = App._();
  App._();

  late final SharedPreferences preferences;
  late final AppTheme theme;
  late final AuthRepository authRepository;

  factory App() {
    return _instance;
  }

  Future<void> initialize() async {
    preferences = await SharedPreferences.getInstance();
    theme = AppTheme(preferences);
    authRepository = AuthRepository(preferences);
  }

  Route<dynamic>? routes(RouteSettings? settings) {
    switch (settings?.name) {
      case 'home':
        allOrientations();
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );
      case 'login':
        portraitOnly();
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return LoginPage();
          },
        );
      case 'relogin':
        portraitOnly();
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ReLogin(),
        );
      case 'register':
        portraitOnly();
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RegisterPage(),
        );
    }
  }

  bool? get isLoggedIn => preferences.getBool('isLoggedIn');
  bool get userIsSet => preferences.getString('email') != null;
  String? get email => preferences.getString('email');
  String? get name => preferences.getString('name');

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
