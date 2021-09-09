import 'package:flutter/material.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tec_pass/app/theme.dart';
import 'package:tec_pass/helpers/helpers.dart';
import 'package:tec_pass/repositories/auth_repository.dart';
import 'package:tec_pass/views/views.dart';

class App {
  static final App _instance = App._();
  factory App() => _instance;
  App._();

  late final SharedPreferences preferences;
  late final AppTheme theme;
  late final AuthRepository authRepository;
  late final OneSignal _oneSignal;

  final _oneSignalAppId = '0240f6b8-344c-4953-b274-814251444407';

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

  Future<void> initOneSignal(BuildContext context) async {
    await OneSignal.shared.setAppId(_oneSignalAppId);

    _oneSignal = OneSignal();

    if (email != null) await _oneSignal.setEmail(email: email!);
    if (userIsSet) await _oneSignal.sendTag('smsNumber', '+54 911 4424-6661');
    setOneSignalNotificationHandler(context);
  }

  void setOneSignalNotificationHandler(BuildContext context) async {
    _oneSignal.setNotificationWillShowInForegroundHandler((event) async {
      event.complete(event.notification);

      debugPrint('notification event title: ${event.notification.title}');
      debugPrint('notification event body: ${event.notification.body}');
    });

    _oneSignal.setNotificationOpenedHandler((openedResult) {
      final action = openedResult.action?.actionId;

      if (action != null) {
        switch (action) {
          case 'ACCEPT':
            debugPrint('invite accepted');
            break;
          case 'DECLINE':
            debugPrint('invite declined');
            break;
        }
      }

      debugPrint('notification opened title: ${openedResult.notification.title}');
      debugPrint('notification opened body: ${openedResult.notification.body}');
    });

    _oneSignal.setInAppMessageClickedHandler((action) {
      debugPrint('action name: ${action.clickName}');
      debugPrint('action url: ${action.clickUrl}');
    });
  }

  bool? get isLoggedIn => preferences.getBool('isLoggedIn');
  bool get userIsSet => preferences.getString('email') != null;
  String? get email => preferences.getString('email');
  String? get name => preferences.getString('name');
  String? get authToken => preferences.getString('authToken');
  String? get imageBase64 => preferences.getString('image');

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
