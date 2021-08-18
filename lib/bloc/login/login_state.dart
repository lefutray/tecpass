part of 'login_bloc.dart';

class LoginState {
  final String email;
  final String password;

  String? validEmail(String? value) {
    final valid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!valid) return 'El correo electrónico no es válido';
  }

  String? validPassword(String? value) {
    String errors = '';
    if (!RegExp(r'[A-Z]').hasMatch(password)) errors += '· 1 Mayúscula\n';
    if (!RegExp(r'[a-z]').hasMatch(password)) errors += '· 1 Minúscula\n';
    // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) errors += '· 1 Caracter especial\n';
    if (password.characters.length <= 8) errors += '· 8 Caracteres mínimo\n';

    if (errors.isEmpty) return null;
    return errors;
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
