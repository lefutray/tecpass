import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sms/flutter_sms.dart';
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
    print(contactsBloc.state.selectedContacts);
    List<String> recipients = [];
    contactsBloc.state.selectedContacts.forEach((contact) => recipients.add(contact.phones.first.number));
    try {
      await sendSMS(message: 'Te invito a este lugar.', recipients: recipients);
    } catch (e) {
      print(e);
    }
  }
}
