import 'package:tec_pass/bloc/login/login_result.dart';

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {}

class SubmissionFailure extends FormSubmissionStatus {
  final LoginResult? result;

  SubmissionFailure({this.result});
}
