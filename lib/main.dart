import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:tec_pass/app.dart';
import 'package:tec_pass/bloc/contacts/contacts_bloc.dart';
import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';
import 'package:tec_pass/bloc/login/login_bloc.dart';

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
        BlocProvider(create: (_) => LoginBloc(app.api)),
      ],
      child: ThemeProvider(
        initTheme: app.theme.current,
        builder: (context, selectedTheme) {
          return FeatureDiscovery(
            child: MyMaterialApp(theme: selectedTheme),
          );
        },
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
    app.cacheImages(context);
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      // show the feature discovery sequence (if it hasn't been already shown)
      FeatureDiscovery.discoverFeatures(context, app.discoveryItems);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: this.widget.theme,
      initialRoute: app.user.isSet ? 'home' : 'login',
      onGenerateRoute: app.routes,
    );
  }
}
