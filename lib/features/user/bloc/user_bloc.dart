import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tec_pass/features/app/app.dart';
import 'package:tec_pass/features/user/services/user_backend_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(SharedPreferences preferences) : super(UserState(preferences));

  final app = App();
  final service = UserBackendService();

  loadPhoto(BuildContext context) {
    final base64Photo = state.preferences.getString('photo');
    if (base64Photo != null && base64Photo.isNotEmpty) {
      add(PhotoLoaded(base64Photo));
    }
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is PhotoChanged) {
      yield state.copyWith(updatingPhoto: UpdatePhotoStatus.uploading);

      final hasValidAccessToken = await service.getValidAccessToken(event.context);

      if (!hasValidAccessToken) {
        yield state.copyWith(updatingPhoto: UpdatePhotoStatus.failed);
        return;
      }

      final photo = event.photo;

      final accessToken = app.accessToken;
      final changed = await service.changePhoto(photo, accessToken!);

      if (changed) {
        if (photo == null || photo.isEmpty) {
          state.preferences.remove('photo');
        } else {
          state.preferences.setString('photo', photo);
        }

        yield state.copyWith(base64Photo: event.photo, updatingPhoto: UpdatePhotoStatus.uploaded);
      } else {
        yield state.copyWith(updatingPhoto: UpdatePhotoStatus.failed);
      }
    } else if (event is PhotoLoaded) {
      yield state.copyWith(base64Photo: event.photo, updatingPhoto: UpdatePhotoStatus.uploaded);
    }
  }
}
