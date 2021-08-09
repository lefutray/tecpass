part of 'contacts_bloc.dart';

abstract class ContactsEvent {}

class ContactsLoad extends ContactsEvent {}

class ContactsToggleSelection extends ContactsEvent {
  final int? index;
  final Contact? contact;
  ContactsToggleSelection({this.index, this.contact}) : assert(index != null || contact != null);
}
