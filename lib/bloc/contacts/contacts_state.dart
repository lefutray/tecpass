part of 'contacts_bloc.dart';

abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class ContactsPermissionDenied extends ContactsState {
  final error;
  ContactsPermissionDenied(this.error);
}

class ContactsLoaded extends ContactsState {
  ContactsLoaded({
    this.allContacts = const [],
    this.selectedContacts = const [],
  });

  final List<Contact> allContacts;
  final List<Contact> selectedContacts;

  ContactsLoaded copyWith({allContacts, selectedContacts}) {
    return ContactsLoaded(
      allContacts: allContacts ?? this.allContacts,
      selectedContacts: selectedContacts ?? this.selectedContacts,
    );
  }
}
