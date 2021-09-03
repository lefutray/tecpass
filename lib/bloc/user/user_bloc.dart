import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(SharedPreferences preferences) : super(UserState(preferences));

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {}
}
