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
    switch (event.runtimeType) {
      case ContactsLoad:
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
          switch (status) {
            case PermissionStatus.granted:
              final contacts = await _getContacts();
              if (contacts.isEmpty) {
                yield ContactsPermissionDenied();
              } else {
                yield ContactsLoaded(unselectedContacts: contacts);
              }
              break;
            case PermissionStatus.denied:
              yield ContactsPermissionDenied();
              break;
            case PermissionStatus.permanentlyDenied:
              yield ContactsPermissionDeniedPermanently();
              break;
            default:
              break;
          }
        }
        break;
      case ContactsToggleSelection:
        final currentState = state as ContactsLoaded;
        event as ContactsToggleSelection;
        if (currentState.selectedContacts.contains(event.contact)) {
          final selectedContacts = currentState.selectedContacts..remove(event.contact);
          final unselectedContacts = [event.contact, ...currentState.unselectedContacts];
          yield currentState.copyWith(selectedContacts: selectedContacts, unselectedContacts: unselectedContacts);
        } else {
          final selectedContacts = [...currentState.selectedContacts, event.contact];
          final unselectedContacts = currentState.unselectedContacts..remove(event.contact);
          yield currentState.copyWith(selectedContacts: selectedContacts, unselectedContacts: unselectedContacts);
        }
        break;
      default:
    }
  }
}
