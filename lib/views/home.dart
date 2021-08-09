import 'package:flutter/material.dart';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';
import 'package:tec_pass/views/access/access.dart';
import 'package:tec_pass/views/profile.dart';
import 'package:tec_pass/views/visits/visits.dart';
import 'package:tec_pass/widgets/customappbar.dart';
import 'package:tec_pass/widgets/customnavbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
