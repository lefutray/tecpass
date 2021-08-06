import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tec_pass/bloc/contacts/contacts_bloc.dart';
import 'package:tec_pass/widgets/contact_widget.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactsBloc = BlocProvider.of<ContactsBloc>(context);

    return Scaffold(
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          if (state.allContacts.isNotEmpty) {
            return ListView.builder(
              itemCount: state.allContacts.length,
              itemBuilder: (BuildContext context, int index) {
                return ContactWidget(
                  state.allContacts[index],
                  state.selectedContacts.contains(state.allContacts[index]),
                  onChanged: (_) => contactsBloc.add(ContactsToggleSelection(index)),
                );
              },
            );
          }
          return Center(child: Text('Loading...'));
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => _sendSMS(contactsBloc), child: Icon(Icons.send)),
    );
  }

  void _sendSMS(ContactsBloc contactsBloc) async {
    Future<void> showError({PlatformException? error}) async {
      await Fluttertoast.showToast(
        timeInSecForIosWeb: 5,
        toastLength: Toast.LENGTH_LONG,
        msg: 'Ocurrió un error al enviar el mensaje.\nPor favor, inténtalo de nuevo. ${(error != null) ? '\n\nERROR: ${error.message}' : ''}', //? '\n\nERROR: $error' : '',
      );
    }

    final List<String> recipients = contactsBloc.state.selectedContacts.map((contact) => contact.phones.first.number).toList();
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
