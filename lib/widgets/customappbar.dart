import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF1F80B5),
      automaticallyImplyLeading: true,
      flexibleSpace: Align(
        alignment: Alignment(0, 0.6),
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
