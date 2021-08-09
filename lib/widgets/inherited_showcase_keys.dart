import 'package:flutter/material.dart';

class InheritedShowcaseKeys extends InheritedWidget {
  InheritedShowcaseKeys({
    required this.child,
  }) : super(child: child);

  final Widget child;

  final GlobalKey accessTab = GlobalKey();
  // final GlobalKey visitsTab = GlobalKey();
  // final GlobalKey profileTab = GlobalKey();
  // final GlobalKey personAccessPlace = GlobalKey();
  // final GlobalKey personAccessPlaceEnter = GlobalKey();
  // final GlobalKey personAccessPlaceExit = GlobalKey();
  // final GlobalKey carAccessQR = GlobalKey();

  static InheritedShowcaseKeys? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedShowcaseKeys>();
  }

  @override
  bool updateShouldNotify(InheritedShowcaseKeys oldWidget) {
    return true;
  }
}
