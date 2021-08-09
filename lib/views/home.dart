import 'package:flutter/material.dart';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';
import 'package:tec_pass/main.dart';
import 'package:tec_pass/views/access/access.dart';
import 'package:tec_pass/views/profile.dart';
import 'package:tec_pass/views/visits/visits.dart';
import 'package:tec_pass/widgets/customappbar.dart';
import 'package:tec_pass/widgets/customnavbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      onComplete: (index, key) {
        if (index == 3) context.read<CustomNavBarBloc>().add(Visits());
        if (index == 4) context.read<CustomNavBarBloc>().add(Profile());
      },
      onFinish: app.showcaseSettings.finish,
      builder: Builder(
        builder: (context) {
          return Builder(
              builder: (context) {
                app.showcaseSettings.initialize(context, );
                return ThemeSwitchingArea(
                  child: Scaffold(
                    appBar: CustomAppBar(),
                    body: BlocBuilder<CustomNavBarBloc, CustomNavBarState>(
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case AccessState:
                            return AccessView(showcase: (state as AccessState).showcase);
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
                );
              },
          );
        },
      ),
    );
  }
}
