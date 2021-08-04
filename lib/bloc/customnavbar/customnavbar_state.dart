part of 'customnavbar_bloc.dart';

@immutable
abstract class CustomNavBarState {
  CustomNavBarState get initialState => AccessState();

  final int index;
  final Widget? child;
  CustomNavBarState({
    required this.index,
    this.child,
  });
}

class AccessState extends CustomNavBarState {
  AccessState() : super(index: 0);
}

class VisitsState extends CustomNavBarState {
  VisitsState() : super(index: 1);
}

class ProfileState extends CustomNavBarState {
  ProfileState() : super(index: 2);
}
