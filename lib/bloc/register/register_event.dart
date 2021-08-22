part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterFullNameChanged extends RegisterEvent {
  final String fullName;
  RegisterFullNameChanged(this.fullName);
}

class RegisterRUTChanged extends RegisterEvent {
  late final String rut;
  RegisterRUTChanged(String rut) {
    this.rut = RUTValidator.formatFromText(rut);
  }
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  RegisterEmailChanged(this.email);
}

class RegisterMobileChanged extends RegisterEvent {
  final String mobile;
  RegisterMobileChanged(this.mobile);
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  RegisterPasswordChanged(this.password);
}

class RegisterPasswordConfirmationChanged extends RegisterEvent {
  final String password;
  RegisterPasswordConfirmationChanged(this.password);
}

class RegisterSubmitted extends RegisterEvent {}
class RegisterFinished extends RegisterEvent {}
