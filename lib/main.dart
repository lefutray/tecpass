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
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    app.cacheImages(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    app.cacheImages(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CustomNavBarBloc()),
        BlocProvider(create: (_) => ContactsBloc()),
      ],
      child: ThemeProvider(
        initTheme: app.theme.current,
        builder: (context, selectedTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: selectedTheme,
            initialRoute: 'home',
            onGenerateRoute: app.routes,
          );
        },
      ),
    );
  }
}
