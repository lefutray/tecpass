part of 'login_bloc.dart';

class LoginState {
  final String email;
  final String password;

  String? validEmail(String? value) {
    final valid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!valid) return 'El correo electrónico no es válido';
  }

  String? validPassword(String? value) {
    if (password.isEmpty) return '· La contraseña no puede estar vacía\n';
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
