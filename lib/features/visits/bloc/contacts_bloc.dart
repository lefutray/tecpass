import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial());

  Future<List<Contact>> _getContacts() async {
    return await FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: true,
      deduplicateProperties: true,
      withThumbnail: true,
    );
  }

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    if (event is ContactsLoad) {
      yield* contactsLoadEvent();
    } else if (event is ContactsToggleSelection) {
      yield* contactsToggleSelectionEvent(event);
    }
  }

  Stream<ContactsState> contactsLoadEvent() async* {
    // if we don't have permission, we should show the permission prompt
    if (await FlutterContacts.requestPermission()) {
      final contacts = await _getContacts();
      if (contacts.isEmpty) {
        yield ContactsPermissionDenied();
      } else {
        yield ContactsLoaded(unselectedContacts: contacts);
      }
    } else {
      final status = await Permission.contacts.request();
      if (status.isGranted) {
        final contacts = await _getContacts();
        if (contacts.isEmpty) {
          yield ContactsPermissionDenied();
        } else {
          yield ContactsLoaded(unselectedContacts: contacts);
        }
      } else if (status.isDenied) {
        yield ContactsPermissionDenied();
      } else if (status.isPermanentlyDenied) {
        yield ContactsPermissionDeniedPermanently();
      }
    }
  }

  Stream<ContactsState> contactsToggleSelectionEvent(ContactsToggleSelection event) async* {
    final currentState = state as ContactsLoaded;
    if (currentState.selectedContacts.contains(event.contact)) {
      final selectedContacts = currentState.selectedContacts..remove(event.contact);
      final unselectedContacts = [event.contact, ...currentState.unselectedContacts];
      yield currentState.copyWith(selectedContacts: selectedContacts, unselectedContacts: unselectedContacts);
    } else {
      final selectedContacts = [...currentState.selectedContacts, event.contact];
      final unselectedContacts = currentState.unselectedContacts..remove(event.contact);
      yield currentState.copyWith(selectedContacts: selectedContacts, unselectedContacts: unselectedContacts);
    }
  }
}
