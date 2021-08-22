import 'package:tec_pass/bloc/error_from_server.dart';

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {}

class SubmissionFailure extends FormSubmissionStatus {
  final List<AuthError?> errors;

  SubmissionFailure({this.errors = const []});
}
