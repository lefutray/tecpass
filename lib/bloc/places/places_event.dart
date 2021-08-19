part of 'places_bloc.dart';

@immutable
abstract class PlacesEvent {}

class PlacesLoad extends PlacesEvent {}

class PlacesToggleSelection extends PlacesEvent {
  final Place place;
  PlacesToggleSelection(this.place);
}
