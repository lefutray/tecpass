import 'package:animate_do/animate_do.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tec_pass/themes/themes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: FadeInDown(
        duration: Duration(milliseconds: 500),
        from: 60,
        child: Image.asset(
          'assets/Logo-tecpass-s.png',
          width: 150,
          height: 55,
          fit: BoxFit.cover,
        ),
      ),
      actions: [_ThemeSwitchingIconButton()],
      elevation: 0,
    );
  }

  @override
  get preferredSize => new Size.fromHeight(70);
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
              final isDark = ThemeProvider.of(context)?.brightness == Brightness.dark;
              if (isDark) {
                ThemeSwitcher.of(context)?.changeTheme(theme: blueLightTheme);
                _controller.reverse();
              } else {
                ThemeSwitcher.of(context)?.changeTheme(theme: greyDarkTheme);
                _controller.forward();
              }
            },
            icon: Lottie.asset(
              'assets/theme_switch_lottie.json',
              onLoaded: (composition) {
                _controller.duration = composition.duration;
                ThemeProvider.of(context)?.brightness == Brightness.dark ? _controller.value = 1 : _controller.value = 0;
              },
              controller: _controller,
            ),
          ),
        );
      },
    );
  }
}
