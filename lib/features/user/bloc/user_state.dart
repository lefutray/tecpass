part of 'user_bloc.dart';

enum UpdatePhotoStatus { uploading, uploaded, failed }

@immutable
class UserState {
  final SharedPreferences preferences;
  final String? name;
  final String? email;
  final String? base64Photo;
  final List<int>? doors;
  final UpdatePhotoStatus updatingPhoto;

  UserState(
    this.preferences, {
    this.name,
    this.email,
    this.base64Photo,
    this.doors,
    this.updatingPhoto = UpdatePhotoStatus.uploaded,
  });

  UserState copyWith({
    String? name,
    String? email,
    String? base64Photo,
    List<int>? doors,
    UpdatePhotoStatus? updatingPhoto,
  }) {
    return UserState(
      preferences,
      name: name ?? this.name,
      email: email ?? this.email,
      base64Photo: base64Photo ?? this.base64Photo,
      doors: doors ?? this.doors,
      updatingPhoto: updatingPhoto ?? this.updatingPhoto,
    );
  }
}
