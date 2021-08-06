import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tec_pass/bloc/contacts/contacts_bloc.dart';
import 'package:tec_pass/widgets/contact_widget.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ContactsInitial:
            context.read<ContactsBloc>().add(ContactsLoad());
            return Center(child: Text('Loading...'));
          case ContactsPermissionDenied:
            return Column(
              children: [
                Center(child: Text('Permission denied\nERROR: ${(state as ContactsPermissionDenied).error}')),
                ElevatedButton(
                  onPressed: () async {
                    final permitted = await FlutterContacts.requestPermission();
                    if (permitted) {
                      context.read<ContactsBloc>().add(ContactsLoad());
                    }
                  },
                  child: Text('Allow access'),
                ),
              ],
            );
          case ContactsLoaded:
            state as ContactsLoaded; // tell flutter that this is a ContactsLoaded state
            return Scaffold(
              body: ListView.builder(
                itemCount: state.allContacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeInLeft(
                    duration: Duration(milliseconds: 300),
                    child: ContactWidget(
                      state.allContacts[index],
                      state.selectedContacts.contains(state.allContacts[index]),
                      onChanged: (_) => context.read<ContactsBloc>().add(ContactsToggleSelection(index)),
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _sendSMS(context.read<ContactsBloc>()),
                child: Icon(Icons.send),
              ),
            );
          default:
            return Center(child: Text('The State ${state.runtimeType} was not recognized.'));
        }
      },
    );
  }

  void _sendSMS(ContactsBloc contactsBloc) async {
    if (contactsBloc.state is ContactsLoaded) {
      Future<void> showError({PlatformException? error}) async {
        await Fluttertoast.showToast(
          timeInSecForIosWeb: 5,
          toastLength: Toast.LENGTH_LONG,
          msg: 'Ocurrió un error al enviar el mensaje.\nPor favor, inténtalo de nuevo. ${(error != null) ? '\n\nERROR: ${error.message}' : ''}',
        );
      }

      final List<String> recipients = (contactsBloc.state as ContactsLoaded).selectedContacts.map((contact) => contact.phones.first.number).toList();
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
}
