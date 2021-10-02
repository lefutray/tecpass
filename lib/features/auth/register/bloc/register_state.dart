part of 'register_bloc.dart';

class RegisterState {
  final String fullName;
  final String mobile;
  final String rut;
  final String email;
  final String password;
  final String passwordConfirmation;
  final GlobalKey<FormState> formKey;

  String? validateField(String field) {
    String? errors = getErrorsFromParam(field);
    if (errors.isEmpty) return null;
    return errors;
  }

  String? validatePassConfirmation(String? value) {
    if (password != passwordConfirmation) return 'Las contraseñas no coinciden';
  }

  String getErrorsFromParam(String param) {
    String errors = '';
    if (formStatus is SubmissionFailure) {
      if ((formStatus as SubmissionFailure).errors.isNotEmpty) {
        final errorsAPI = (formStatus as SubmissionFailure).errors.where((element) => element?.param == param);
        if (errorsAPI.isNotEmpty) {
          for (final error in errorsAPI) {
            errors = _addToNextLine(errors, error!.msg!);
          }
        }
      }
    }
    return errors;
  }

  String getGeneralErrors() {
    String errors = '';
    if (formStatus is SubmissionFailure) {
      if ((formStatus as SubmissionFailure).errors.isNotEmpty) {
        final errorsAPI = (formStatus as SubmissionFailure).errors.where((element) => element?.param == 'server' || element?.param == 'general');
        if (errorsAPI.isNotEmpty) {
          for (final error in errorsAPI) {
            errors = _addToNextLine(errors, error!.msg!);
          }
        }
      }
    }
    return errors;
  }

  _addToNextLine(String text, String add) {
    if (text.isNotEmpty) {
      return text + '\n' + add;
    } else {
      return add;
    }
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
    required this.formKey,
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
      formKey: formKey,
    );
  }
}
