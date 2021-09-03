import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(SharedPreferences preferences) : super(UserState(preferences));

  loadPhoto() {
    final base64Photo = state.preferences.getString('photo');
    if (base64Photo != null) {
      add(PhotoChanged(base64Photo));
    }
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is PhotoChanged) {
      state.preferences.setString('photo', event.photo);
      yield state.copyWith(base64Photo: event.photo);
    }
  }
}
