part of 'register_bloc.dart';

class RegisterState {
  final String fullName;
  final String mobile;
  final String rut;
  final String email;
  final String password;
  final String passwordConfirmation;

  String? validateName(String? value) {
    if (fullName.length > 6) return null;
    return 'El nombre de usuario debe tener más de 6 caracteres';
  }

  String? validateEmail(String? value) {
    final valid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!valid) return 'El correo electrónico no es válido';
  }

  String? validatePassword(String? value) {
    if (password.length > 8 && password == passwordConfirmation) return null;
    if (password != passwordConfirmation || password.length < 8) return 'Las contraseñas no coinciden';
    return 'La contraseña debe tener más de 8 caracteres';
  }

  String? validateRUT(String? value) {
    return RUTValidator().validator(value);
  }

  String? validateMobile(String? value) {
    if (Fzregex.hasMatch(mobile, FzPattern.phone)) return null;
    return 'El número de celular no es válido';
  }

  final FormSubmissionStatus formStatus;

  RegisterState({
    this.fullName = '',
    this.mobile = '',
    this.rut = '',
    this.email = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String? fullName,
    String? mobile,
    String? rut,
    String? email,
    String? password,
    String? passwordConfirmation,
    FormSubmissionStatus? formStatus,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      mobile: mobile ?? this.mobile,
      rut: rut ?? this.rut,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
