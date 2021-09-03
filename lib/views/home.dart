import 'package:flutter/material.dart';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tec_pass/bloc/bloc.dart';
import 'package:tec_pass/views/views.dart';
import 'package:tec_pass/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
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
    );
  }
}
