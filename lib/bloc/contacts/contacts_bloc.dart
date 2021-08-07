import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial());

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    switch (event.runtimeType) {
      case ContactsLoad:
        // if we don't have permission, we should show the permission prompt
        if (await FlutterContacts.requestPermission()) {
          final contacts = await FlutterContacts.getContacts(withProperties: true);
          if (contacts.isEmpty)
            yield ContactsPermissionDenied();
          else
            yield ContactsLoaded(allContacts: contacts);
        } else {
          final status = await Permission.contacts.request();
          switch (status) {
            case PermissionStatus.granted:
              final contacts = await FlutterContacts.getContacts(withProperties: true);
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
