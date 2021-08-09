import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:tec_pass/main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: FadeInDown(
        duration: Duration(milliseconds: 500),
        from: 60,
        child: Image.asset(
          'assets/Logo-tecpass-s.png',
          width: 150,
          fit: BoxFit.contain,
        ),
      ),
      actions: [_ThemeSwitchingIconButton()],
      elevation: 0,
    );
  }

  @override
  get preferredSize => new Size.fromHeight(60);
}

class _ThemeSwitchingIconButton extends StatefulWidget {
  const _ThemeSwitchingIconButton({Key? key}) : super(key: key);

  @override
  __ThemeSwitchingIconButtonState createState() => __ThemeSwitchingIconButtonState();
}

class __ThemeSwitchingIconButtonState extends State<_ThemeSwitchingIconButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    if (app.theme.current.brightness == Brightness.dark) {
      _controller.value = 1;
    } else {
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher(
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(right: 5),
          child: IconButton(
            onPressed: () async {
              final busy = ThemeProvider.instanceOf(context)?.isBusy ?? false;
              if (!busy) {
                if (app.theme.current.brightness == Brightness.dark) {
                  _controller.reverse();
                  await app.theme.changeTheme('light');
                  ThemeSwitcher.of(context)?.changeTheme(theme: app.theme.lightTheme);
                } else {
                  _controller.forward();
                  await app.theme.changeTheme('dark');
                  ThemeSwitcher.of(context)?.changeTheme(theme: app.theme.darkTheme);
                }
              }
            },
            icon: Transform.rotate(
              angle: math.pi * 1.2,
              child: Lottie.asset(
                'assets/theme_switch_lottie.json',
                onLoaded: (composition) {
                  _controller.duration = composition.duration;
                  app.theme.current.brightness == Brightness.dark ? _controller.value = 1 : _controller.value = 0;
                },
                controller: _controller,
              ),
            ),
          ),
        );
      },
    );
  }
}
