part of 'contacts_bloc.dart';

class ContactsState {
  ContactsState({
    this.allContacts = const [],
    this.selectedContacts = const [],
  });

  final List<Contact> allContacts;
  final List<Contact> selectedContacts;

  ContactsState copyWith({allContacts, selectedContacts}) {
    return ContactsState(
      allContacts: allContacts ?? this.allContacts,
      selectedContacts: selectedContacts ?? this.selectedContacts,
    );
  }
}
