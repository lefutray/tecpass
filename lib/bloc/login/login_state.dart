part of 'login_bloc.dart';

class LoginState {
  final String email;
  final String password;
  final GlobalKey<FormState> formKey;

  String? validateField(String field) {
    String? errors = getErrorsFromParam(field);
    if (errors.isEmpty) return null;
    return errors;
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

  _addToNextLine(String text, String add) {
    if (text.isNotEmpty) {
      return text + '\n' + add;
    } else {
      return add;
    }
  }

  final FormSubmissionStatus formStatus;

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
    required this.formKey,
  });

  LoginState copyWith({String? email, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      formKey: formKey,
    );
  }
}
