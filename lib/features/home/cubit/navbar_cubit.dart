import 'package:bloc/bloc.dart';

class NavbarCubit extends Cubit<int> {
  NavbarCubit() : super(0);

  void viewAccess() => emit(0);
  void viewVisits() => emit(1);
  void viewHistory() => emit(2);
  void viewProfile() => emit(3);
}
