import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tec_pass/bloc/contacts/contacts_bloc.dart';

void sendSMStoContacts(ContactsState contactsState) async {
  if (contactsState is ContactsLoaded) {
    Future<void> showError({PlatformException? error}) async {
      await Fluttertoast.showToast(
        timeInSecForIosWeb: 5,
        toastLength: Toast.LENGTH_LONG,
        msg: 'Ocurrió un error al enviar el mensaje.\nPor favor, inténtalo de nuevo. ${(error != null) ? '\n\nERROR: ${error.message}' : ''}',
      );
    }

    final List<String> recipients = contactsState.selectedContacts.map((contact) => contact.phones.first.number).toList();
    try {
      final String? result = await sendSMS(message: 'Te invito a este lugar.', recipients: recipients);
      if (result != null && result == 'Error sending sms') {
        showError();
      }
    } on PlatformException catch (error) {
      showError(error: error);
    }
  }
}
