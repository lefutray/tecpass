import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'customnavbar_event.dart';
part 'customnavbar_state.dart';

class CustomNavBarBloc extends Bloc<CustomNavBarEvent, CustomNavBarState> {
  CustomNavBarBloc() : super(AccessState());

  @override
  Stream<CustomNavBarState> mapEventToState(CustomNavBarEvent event) async* {
    if (event is Visits) {
      yield VisitsState();
    } else if (event is Profile) {
      yield ProfileState();
    } else {
      yield AccessState();
    }
  }
}
