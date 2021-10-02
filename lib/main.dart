import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:tec_pass/features/app/app.dart';
import 'package:tec_pass/features/auth/login/bloc/login_bloc.dart';
import 'package:tec_pass/features/auth/register/bloc/register_bloc.dart';
import 'package:tec_pass/features/home/cubit/navbar_cubit.dart';
import 'package:tec_pass/features/user/bloc/user_bloc.dart';
import 'package:tec_pass/features/visits/bloc/contacts_bloc.dart';
import 'package:tec_pass/helpers/helpers.dart';

void main() async {
  final app = App();
  WidgetsFlutterBinding.ensureInitialized();
  await app.initialize(); // Initialize the app settings.

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = App();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavbarCubit()),
        BlocProvider(create: (_) => ContactsBloc()),
        BlocProvider(create: (_) => RegisterBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => UserBloc(app.preferences)),
      ],
      child: FeatureDiscovery(
        child: ThemeProvider(
          initTheme: app.theme.current,
          builder: (context, selectedTheme) => MyMaterialApp(theme: selectedTheme),
        ),
      ),
    );
  }
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({Key? key, this.theme}) : super(key: key);
  final ThemeData? theme;

  @override
  _MyMaterialAppState createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  final app = App();

  @override
  void initState() {
    cacheImages(context);
    app.initOneSignal(context);
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      FeatureDiscovery.discoverFeatures(context, app.discoveryItems);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late final String initialRoute;
    if (app.userIsSet) {
      if (app.isLoggedIn ?? false) {
        initialRoute = 'home';
      } else {
        initialRoute = 'relogin';
      }
    } else {
      initialRoute = 'login';
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeProvider.instanceOf(context)?.theme,
      initialRoute: initialRoute,
      onGenerateRoute: app.routes,
    );
  }
}
