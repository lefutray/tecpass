import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:tec_pass/app/app.dart';
import 'package:tec_pass/bloc/bloc.dart';
import 'package:tec_pass/helpers/helpers.dart';

final app = App();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await app.initialize(); // Initialize the Flutter app.

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CustomNavBarBloc()),
        BlocProvider(create: (_) => ContactsBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => RegisterBloc()),
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
  @override
  void initState() {
    cacheImages(context);
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
