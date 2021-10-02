import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:tec_pass/features/auth/common/form_submission_status.dart';
import 'package:tec_pass/features/auth/common/error_from_server.dart';
import 'package:tec_pass/features/app/app.dart';

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
        yield state.copyWith(formStatus: SubmissionSuccess());
      } else {
        yield state.copyWith(formStatus: SubmissionFailure(errors: errors));
        for (var element in errors) {
          print(element?.param);
        }
      }
    } catch (error) {
      // Show the error message if it fails
      print(error);
      yield state.copyWith(formStatus: SubmissionFailure());
    }
  }
}
