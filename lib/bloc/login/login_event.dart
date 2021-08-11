part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String username;

  LoginUsernameChanged(this.username);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {
  final BuildContext context;

  LoginSubmitted(this.context);
}
