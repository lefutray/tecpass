import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tec_pass/features/app/app.dart';
import 'package:tec_pass/features/user/services/user_backend_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(SharedPreferences preferences) : super(UserState(preferences));

  final app = App();

  loadPhoto(BuildContext context) {
    final base64Photo = state.preferences.getString('photo');
    debugPrint('photo: $base64Photo');
    if (base64Photo != null) {
      add(PhotoChanged(base64Photo, context));
    }
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is PhotoChanged) {
      final service = UserBackendService();
      final accessToken = app.accessToken;
      final refreshToken = app.refreshToken;

      if (accessToken == null || refreshToken == null) {
        app.authRepository.logout(event.context);
        Fluttertoast.showToast(msg: 'La sesión ha expirado');
        return;
      }

      if (service.accessTokenExpired(accessToken)) {
        final newAccessToken = await service.regenerateAccessToken(refreshToken);
        if (newAccessToken == null) {
          Fluttertoast.showToast(msg: 'La sesión ha expirado');
          return;
        }
        await app.preferences.setString('accessToken', newAccessToken);
      }

      final changed = await service.changePhoto(event.photo, accessToken);

      if (changed) {
        state.preferences.setString('photo', event.photo);
        yield state.copyWith(base64Photo: event.photo);
      }
    }
  }
}
