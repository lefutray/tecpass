part of 'contacts_bloc.dart';

abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class ContactsLoaded extends ContactsState {
  ContactsLoaded({
    this.allContacts = const [],
    this.unselectedContacts = const [],
    this.selectedContacts = const [],
  });

  final List<Contact> allContacts;
  final List<Contact> selectedContacts;
  final List<Contact> unselectedContacts;

  ContactsLoaded copyWith({allContacts, selectedContacts, unselectedContacts}) {
    return ContactsLoaded(
      allContacts: allContacts ?? this.allContacts,
      unselectedContacts: unselectedContacts ?? this.unselectedContacts,
      selectedContacts: selectedContacts ?? this.selectedContacts,
    );
  }
}

class ContactsPermissionDenied extends ContactsState {}

class ContactsPermissionDeniedPermanently extends ContactsState {}

class ContactsNotFound extends ContactsState {}
