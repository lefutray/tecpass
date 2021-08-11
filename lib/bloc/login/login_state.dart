part of 'login_bloc.dart';

class LoginState {
  final String username;
  final String password;
  String? validUsername(String? value) {
    if(username.length > 6) return null;
    return  'El nombre de usuario debe tener más de 6 caracteres';
  }
  String? validPassword(String? value) { 
    if(password.length > 8) return null;
    return 'La contraseña debe tener más de 8 caracteres';
  }
  final FormSubmissionStatus formStatus;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({String? username, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
