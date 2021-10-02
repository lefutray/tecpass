import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tec_pass/models/models.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc() : super(PlacesInitial());

  @override
  Stream<PlacesState> mapEventToState(PlacesEvent event) async* {
    
  }
}
