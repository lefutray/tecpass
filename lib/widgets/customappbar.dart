import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF1F80B5),
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
      actions: [],
      elevation: 0,
    );
  }

  @override
  get preferredSize => new Size.fromHeight(70);
}
