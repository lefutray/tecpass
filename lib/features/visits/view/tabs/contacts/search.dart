import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:tec_pass/features/visits/bloc/contacts_bloc.dart';
import 'package:tec_pass/widgets/widgets.dart';

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

  bool resultMatches(Contact element) {
    return element.displayName.toLowerCase().startsWith(query.toLowerCase());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        state as ContactsLoaded;
        List<Contact> suggestions = state.selectedContacts.where(resultMatches).toList();
        suggestions.addAll(state.unselectedContacts.where(resultMatches).toList());
        if (query.isEmpty) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ...contactsList(context, state.selectedContacts),
                  ...contactsList(context, state.unselectedContacts),
                ],
              );
            },
          );
        }
        return ListView(
          physics: BouncingScrollPhysics(),
          children: contactsList(context, suggestions),
        );
      },
    );
  }

  List<Widget> contactsList(BuildContext context, List<Contact> contacts) {
    return List.generate(
      contacts.length,
      (index) => ContactWidget(
        contacts[index],
        (BlocProvider.of<ContactsBloc>(context).state as ContactsLoaded).selectedContacts.contains(contacts[index]),
        onChanged: (_) {
          context.read<ContactsBloc>().add(ContactsToggleSelection(contacts[index]));
          query = '';
        },
      ),
    );
  }
}
