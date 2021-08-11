import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tec_pass/app.dart';
import 'package:tec_pass/main.dart';
import 'package:tec_pass/models/form_submission_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final API api;
  LoginBloc({required this.api}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    switch (event.runtimeType) {
      case LoginUsernameChanged:
        yield state.copyWith(username: (event as LoginUsernameChanged).username);
        break;
      case LoginPasswordChanged:
        yield state.copyWith(password: (event as LoginPasswordChanged).password);
        break;
      case LoginSubmitted:
        yield state.copyWith(formStatus: FormSubmitting());
        try {
          if (await api.login()) {
            app.user.save(name: state.username, email: state.password);
            yield state.copyWith(formStatus: SubmissionSuccess());
            Navigator.of((event as LoginSubmitted).context).pushReplacementNamed('home');
          }
        } catch (error) {
          yield state.copyWith(formStatus: SubmissionFailure(error as Exception));
        }
        break;
    }
  }
}
