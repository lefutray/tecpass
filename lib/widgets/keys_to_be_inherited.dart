import 'package:flutter/material.dart';

class KeysToBeInherited extends InheritedWidget {
  final GlobalKey accessTabKey;
  final GlobalKey placeWidgetKey;
  final GlobalKey placeWidgetEnterKey;
  final GlobalKey placeWidgetExitKey;
  final GlobalKey visitsTabKey;
  final GlobalKey profileTabKey;
  final GlobalKey themeSwitcherKey;

  KeysToBeInherited({
    Key? key,
    required this.accessTabKey,
    required this.placeWidgetKey,
    required this.placeWidgetEnterKey,
    required this.placeWidgetExitKey,
    required this.visitsTabKey,
    required this.profileTabKey,
    required this.themeSwitcherKey,
    required this.child,
  }) : super(key: key, child: child);

  final Widget child;

  static KeysToBeInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<KeysToBeInherited>();
  }

  @override
  bool updateShouldNotify(KeysToBeInherited oldWidget) {
    return true;
  }
}
