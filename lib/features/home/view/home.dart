import 'package:flutter/material.dart';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tec_pass/features/access/view/access.dart';
import 'package:tec_pass/features/history/view/history_view.dart';
import 'package:tec_pass/features/profile/view/profile.dart';
import 'package:tec_pass/features/visits/view/visits.dart';
import 'package:tec_pass/widgets/widgets.dart';
import 'package:tec_pass/features/home/cubit/navbar_cubit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: BlocBuilder(
          bloc: BlocProvider.of<NavbarCubit>(context),
          builder: (context, int state) {
            final views = [
              AccessView(),
              VisitsView(),
              HistoryView(),
              ProfileView(),
            ];
            return views[state];
          },
        ),
        bottomNavigationBar: CustomNavBar(),
      ),
    );
  }
}
