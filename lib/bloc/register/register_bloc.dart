import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:tec_pass/app/app.dart';
import 'package:tec_pass/helpers/helpers.dart';
import 'package:tec_pass/bloc/form_submission_status.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState(formKey: GlobalKey<FormState>()));
  final app = App();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    switch (event.runtimeType) {
      case RegisterFullNameChanged:
        yield state.copyWith(fullName: (event as RegisterFullNameChanged).fullName);
        break;
      case RegisterMobileChanged:
        yield state.copyWith(mobile: (event as RegisterMobileChanged).mobile);
        break;
      case RegisterRUTChanged:
        yield state.copyWith(rut: (event as RegisterRUTChanged).rut);
        break;
      case RegisterEmailChanged:
        yield state.copyWith(email: (event as RegisterEmailChanged).email);
        break;
      case RegisterPasswordChanged:
        yield state.copyWith(password: (event as RegisterPasswordChanged).password);
        break;
      case RegisterPasswordConfirmationChanged:
        yield state.copyWith(passwordConfirmation: (event as RegisterPasswordConfirmationChanged).password);
        break;
      case RegisterSubmitted:
        yield* registerSubmittedEvent(state);
        break;
      case RegisterFinished:
        yield state.copyWith(formStatus: InitialFormStatus());
        break;
    }
  }

  Stream<RegisterState> registerSubmittedEvent(RegisterState state) async* {
    yield state.copyWith(formStatus: FormSubmitting());
    try {
      state.formKey.currentState?.validate();
      // try to Register
      final errors = await app.authRepository.register(
        email: state.email,
        name: state.fullName,
        phone: state.mobile,
        password: state.password,
        rut: state.rut,
        passwordConfirmation: state.passwordConfirmation,
      );

      if (errors.isEmpty) {
        // save the information if it was successful
        yield RegisterState(formStatus: SubmissionSuccess(), formKey: state.formKey);
      } else {
        yield state.copyWith(formStatus: SubmissionFailure(errors: errors));
      }
    } catch (error) {
      // Show the error message if it fails
      yield state.copyWith(formStatus: SubmissionFailure());
    }
  }
}
