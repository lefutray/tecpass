import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:tec_pass/app.dart';
import 'package:tec_pass/bloc/contacts/contacts_bloc.dart';
import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';

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
        initialRoute: 'home',
        onGenerateRoute: app.routes,
      ),
    );
  }
}
