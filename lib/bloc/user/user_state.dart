part of 'user_bloc.dart';

@immutable
class UserState {
  final SharedPreferences preferences;
  final String? name;
  final String? email;
  final String? base64Photo;
  final List<int>? doors;

  UserState(
    this.preferences, {
    this.name,
    this.email,
    this.base64Photo,
    this.doors,
  });
}
