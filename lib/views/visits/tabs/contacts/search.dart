import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:tec_pass/bloc/contacts/contacts_bloc.dart';
import 'package:tec_pass/widgets/contact_widget.dart';

class ContactSearch extends SearchDelegate<Contact?> {
  List suggestions = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        state as ContactsLoaded;
        List<Contact> suggestions = state.allContacts.where((Contact element) => element.displayName.toLowerCase().startsWith(query.toLowerCase())).toList();
        if (suggestions.isEmpty) {
          return ListView(
            children: [
              ListView.builder(
                itemCount: state.selectedContacts.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ContactWidget(
                    state.selectedContacts[index],
                    true,
                    onChanged: (_) => context.read<ContactsBloc>().add(ContactsToggleSelection(contact: state.selectedContacts[index])),
                  );
                },
              ),
              ListView.builder(
                itemCount: state.unselectedContacts.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ContactWidget(
                    state.unselectedContacts[index],
                    false,
                    onChanged: (_) => context.read<ContactsBloc>().add(ContactsToggleSelection(contact: state.unselectedContacts[index])),
                  );
                },
              ),
            ],
          );
        }
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (BuildContext context, int index) {
            return ContactWidget(
              suggestions[index],
              state.selectedContacts.contains(suggestions[index]),
              onChanged: (_) => context.read<ContactsBloc>().add(ContactsToggleSelection(contact: suggestions[index])),
            );
          },
        );
      },
    );
  }
}
