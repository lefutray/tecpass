part of 'contacts_bloc.dart';

abstract class ContactsEvent {}

class ContactsLoad extends ContactsEvent {}

class ContactsToggleSelection extends ContactsEvent {
  final Contact contact;
  ContactsToggleSelection(this.contact);
}
