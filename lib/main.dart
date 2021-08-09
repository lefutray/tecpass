import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:showcaseview/showcaseview.dart';

import 'package:tec_pass/app.dart';
import 'package:tec_pass/bloc/contacts/contacts_bloc.dart';
import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';
import 'package:tec_pass/widgets/keys_to_be_inherited.dart';

final app = App();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await app.initialize(); // Initialize the Flutter app.

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CustomNavBarBloc()),
        BlocProvider(create: (_) => ContactsBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    app.cacheImages(context);
  }

  @override
  void didChangeDependencies() {
    app.cacheImages(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: app.theme.current,
      builder: (context, selectedTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: selectedTheme,
        home: ShowCaseWidget(
          onComplete: (index, key) {},
          onFinish: app.showcaseSettings.finish,
          builder: Builder(
            builder: (context) => Routes(),
          ),
        ),
      ),
    );
  }
}

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  final GlobalKey _accessTabKey = GlobalKey();
  final GlobalKey _placeWidgetKey = GlobalKey();
  final GlobalKey _placeWidgetEnterKey = GlobalKey();
  final GlobalKey _placeWidgetExitKey = GlobalKey();
  final GlobalKey _visitsTabKey = GlobalKey();
  final GlobalKey _profileTabKey = GlobalKey();
  final GlobalKey _themeSwitcherKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    app.showcaseSettings.initialize(context, [
      this._accessTabKey,
      this._placeWidgetKey,
      this._placeWidgetEnterKey,
      this._placeWidgetExitKey,
      this._visitsTabKey,
      this._profileTabKey,
      this._themeSwitcherKey,
    ]);

    return KeysToBeInherited(
      accessTabKey: this._accessTabKey,
      visitsTabKey: this._visitsTabKey,
      profileTabKey: this._profileTabKey,
      placeWidgetKey: this._placeWidgetKey,
      placeWidgetEnterKey: this._placeWidgetEnterKey,
      placeWidgetExitKey: this._placeWidgetExitKey,
      themeSwitcherKey: this._themeSwitcherKey,
      child: Navigator(
        initialRoute: 'home',
        onGenerateRoute: app.routes,
      ),
    );
  }
}
