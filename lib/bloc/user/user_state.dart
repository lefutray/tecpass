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

  UserState copyWith({
    String? name,
    String? email,
    String? base64Photo,
    List<int>? doors,
  }) {
    return UserState(
      preferences,
      name: name ?? this.name,
      email: email ?? this.email,
      base64Photo: base64Photo ?? this.base64Photo,
      doors: doors ?? this.doors,
    );
  }
}
