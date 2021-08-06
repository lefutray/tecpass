import 'dart:async';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:bloc/bloc.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial());

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    switch (event.runtimeType) {
      case ContactsLoad:
        // try {
        if (await FlutterContacts.requestPermission()) {
          final contacts = await FlutterContacts.getContacts(withProperties: true);
          if (contacts.isNotEmpty) {
            yield ContactsLoaded(allContacts: contacts);
          } else {
            yield ContactsPermissionDenied('No contacts found');
          }
        } else {
          yield ContactsPermissionDenied('No permission to access contacts');
        }
        break;
      case ContactsToggleSelection:
        final currentState = state as ContactsLoaded;
        if (currentState.allContacts.isNotEmpty) {
          final toggle = currentState.allContacts[(event as ContactsToggleSelection).index];
          if (currentState.selectedContacts.contains(toggle)) {
            final selectedContacts = currentState.selectedContacts..remove(toggle);
            yield currentState.copyWith(selectedContacts: selectedContacts);
          } else {
            final selectedContacts = [...currentState.selectedContacts, toggle];
            yield currentState.copyWith(selectedContacts: selectedContacts);
          }
        }
        break;
      default:
    }
  }
}
