part of 'login_bloc.dart';

class LoginState {
  final String email;
  final String password;
  String? validEmail(String? value) {
    if(email.length > 6) return null;
    return  'El nombre de usuario debe tener más de 6 caracteres';
  }
  String? validPassword(String? value) { 
    if(password.length > 8) return null;
    return 'La contraseña debe tener más de 8 caracteres';
  }
  final FormSubmissionStatus formStatus;

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({String? email, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
