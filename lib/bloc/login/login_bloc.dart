import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tec_pass/app/app.dart';
import 'package:tec_pass/bloc/form_submission_status.dart';
import 'package:tec_pass/bloc/error_from_server.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(formKey: GlobalKey<FormState>()));
  final app = App();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    switch (event.runtimeType) {
      case LoginEmailChanged:
        yield state.copyWith(email: (event as LoginEmailChanged).email, formStatus: InitialFormStatus());
        break;
      case LoginPasswordChanged:
        yield state.copyWith(password: (event as LoginPasswordChanged).password, formStatus: InitialFormStatus());
        break;
      case LoginSubmitted:
        yield* loginSubmittedEvent();
        break;
      case LoginFinished:
        yield state.copyWith(formStatus: InitialFormStatus());
        break;
    }
  }

  Stream<LoginState> loginSubmittedEvent() async* {
    yield state.copyWith(formStatus: FormSubmitting());
    try {
      // try to login
      final List<AuthError?> errors = await app.authRepository.login(email: state.email, password: state.password);

      if (errors.isEmpty) {
        yield LoginState(formStatus: SubmissionSuccess(), formKey: state.formKey);
      } else {
        yield state.copyWith(formStatus: SubmissionFailure(errors: errors));
      }
    } catch (error) {
      // Show the error message if it fails
      yield state.copyWith(formStatus: SubmissionFailure());
    }
  }
}
