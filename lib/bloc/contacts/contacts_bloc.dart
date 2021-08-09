import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial());

  Future<List<Contact>> _contacts() async {
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
          final contacts = await _contacts();
          if (contacts.isEmpty)
            yield ContactsPermissionDenied();
          else
            yield ContactsLoaded(allContacts: contacts, unselectedContacts: contacts);
        } else {
          final status = await Permission.contacts.request();
          switch (status) {
            case PermissionStatus.granted:
              final contacts = await _contacts();
              if (contacts.isEmpty)
                yield ContactsPermissionDenied();
              else
                yield ContactsLoaded(allContacts: contacts);
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
        if (currentState.allContacts.isNotEmpty) {
          late final Contact toggle = event.contact;
          if (currentState.selectedContacts.contains(toggle)) {
            final selectedContacts = currentState.selectedContacts..remove(toggle);
            final unselectedContacts = [...currentState.unselectedContacts, toggle];
            yield currentState.copyWith(selectedContacts: selectedContacts, unselectedContacts: unselectedContacts);
          } else {
            final selectedContacts = [...currentState.selectedContacts, toggle];
            final unselectedContacts = currentState.unselectedContacts..remove(toggle);
            yield currentState.copyWith(selectedContacts: selectedContacts, unselectedContacts: unselectedContacts);
          }
        }
        break;
      default:
    }
  }
}
