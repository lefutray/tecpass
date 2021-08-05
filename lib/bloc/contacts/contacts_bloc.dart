import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsState());

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    if (event is ContactsLoad) {
      if (await FlutterContacts.requestPermission()) {
        try {
          final contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
          if (contacts.isNotEmpty) yield ContactsState(allContacts: contacts);
        } catch (e) {
          print(e);
        }
      }
    }
    if (event is ContactsToggleSelection) {
      if (state.allContacts.isNotEmpty) {
        final toggle = state.allContacts[event.index];
        if (state.selectedContacts.contains(toggle)) {
          final selectedContacts = this.state.selectedContacts..remove(toggle);
          yield this.state.copyWith(selectedContacts: selectedContacts);
        } else {
          final selectedContacts = [...this.state.selectedContacts, toggle];
          yield this.state.copyWith(selectedContacts: selectedContacts);
        }
      }
    }
  }
}
