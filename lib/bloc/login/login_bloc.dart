import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tec_pass/app/app.dart';
import 'package:tec_pass/bloc/form_submission_status.dart';
import 'package:tec_pass/bloc/login/login_result.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());
  final app = App();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    switch (event.runtimeType) {
      case LoginEmailChanged:
        yield state.copyWith(email: (event as LoginEmailChanged).email);
        break;
      case LoginPasswordChanged:
        yield state.copyWith(password: (event as LoginPasswordChanged).password);
        break;
      case LoginSubmitted:
        yield state.copyWith(formStatus: FormSubmitting());
        try {
          // try to login
          final LoginResult? result = await app.authRepository.login(email: state.email, password: state.password);

          if (result == null) {
            yield LoginState(formStatus: SubmissionSuccess());
          } else {
            print(result);
            yield LoginState(formStatus: SubmissionFailure(result: result));
          }
        } catch (error) {
          print(error);
          // Show the error message if it fails
          yield state.copyWith(formStatus: SubmissionFailure());
        }
        break;
      case LoginFinished:
        yield LoginState();
        break;
    }
  }
}
