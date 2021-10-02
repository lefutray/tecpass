import 'package:flutter/material.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tec_pass/features/app/theme.dart';
import 'package:tec_pass/features/auth/common/repositories/auth_repository.dart';
import 'package:tec_pass/features/auth/login/view/login.dart';
import 'package:tec_pass/features/auth/register/view/register.dart';
import 'package:tec_pass/features/auth/relogin.dart';
import 'package:tec_pass/features/home/view/home.dart';
import 'package:tec_pass/helpers/helpers.dart';

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
        return MaterialPageRoute(settings: settings, builder: (_) => HomePage());
      case 'login':
        portraitOnly();
        return MaterialPageRoute(settings: settings, builder: (_) => LoginPage());
      case 'relogin':
        portraitOnly();
        return MaterialPageRoute(settings: settings, builder: (_) => ReLogin());
      case 'register':
        portraitOnly();
        return MaterialPageRoute(settings: settings, builder: (_) => RegisterPage());
    }
  }

  Future<void> initOneSignal(BuildContext context) async {
    await OneSignal.shared.setAppId(_oneSignalAppId);

    _oneSignal = OneSignal();

    if (email != null) await _oneSignal.sendTag('email', email!);
    if (phone != null) await _oneSignal.sendTag('phone', phone!);
    setOneSignalNotificationHandler(context);
  }

  void setOneSignalNotificationHandler(BuildContext context) async {
    _oneSignal.setNotificationWillShowInForegroundHandler((event) async {
      event.complete(event.notification);

      debugPrint('notification event title: ${event.notification.title}');
      debugPrint('notification event body: ${event.notification.body}');
      debugPrint(event.notification.additionalData.toString());
    });

    _oneSignal.setNotificationOpenedHandler((openedResult) {
      debugPrint(openedResult.notification.additionalData.toString());
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
  String? get phone => preferences.getString('phone');
  String? get name => preferences.getString('name');
  String? get accessToken => preferences.getString('accessToken');
  String? get refreshToken => preferences.getString('refreshToken');
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
