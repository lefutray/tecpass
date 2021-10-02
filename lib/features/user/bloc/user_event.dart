part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class PhotoChanged extends UserEvent {
  final String photo;
  final BuildContext context;

  PhotoChanged(this.photo, this.context);
}

class NameChanged extends UserEvent {
  final String name;

  NameChanged(this.name);
}

class EmailChanged extends UserEvent {
  final String email;

  EmailChanged(this.email);
}

class DoorsChanged extends UserEvent {
  final List<String> doors;

  DoorsChanged(this.doors);
}
