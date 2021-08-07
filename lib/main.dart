import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:tec_pass/bloc/contacts/contacts_bloc.dart';
import 'package:tec_pass/themes/themes.dart';
import 'package:tec_pass/widgets/customappbar.dart';
import 'package:tec_pass/views/access/access.dart';
import 'package:tec_pass/views/profile.dart';
import 'package:tec_pass/views/visits/visits.dart';
import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';
import 'package:tec_pass/widgets/customnavbar.dart';

void main() {
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
  cacheImages(context) async {
    await precacheImage(AssetImage('assets/Logo-tecpass-s.png'), context);
    await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/Check.svg'), context);
    await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/Cancelar.svg'), context);
  }

  @override
  void initState() {
    super.initState();
    cacheImages(context);
  }

  @override
  void didChangeDependencies() {
    cacheImages(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final isPlatformDark = WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? greyDarkTheme : blueLightTheme;
    return ThemeProvider(
      initTheme: initTheme,
      builder: (context, selectedTheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: selectedTheme,
          home: ThemeSwitchingArea(
            child: Scaffold(
              appBar: CustomAppBar(),
              body: BlocBuilder<CustomNavBarBloc, CustomNavBarState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case AccessState:
                      return AccessView();
                    case VisitsState:
                      return VisitsView();
                    case ProfileState:
                      return ProfileView();
                    default:
                      return Center(child: Text('ERROR: NAVBAR COULDN`T BE BUILT'));
                  }
                },
              ),
              bottomNavigationBar: CustomNavBar(),
            ),
          ),
        );
      },
    );
  }
}
