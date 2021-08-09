import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_settings/app_settings.dart';

import 'package:tec_pass/helpers/sms.dart';
import 'package:tec_pass/bloc/contacts/contacts_bloc.dart';
import 'package:tec_pass/views/visits/tabs/contacts/search.dart';
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
            return Center(child: CircularProgressIndicator(color: Colors.white));
          case ContactsLoaded:
            return _LoadedContactsWidget(state as ContactsLoaded);
          case ContactsNotFound:
            return _NoContacts(state);
          case ContactsPermissionDenied:
            return _PermissionDenied(state);
          case ContactsPermissionDeniedPermanently:
            return _PermissionDenied(state);
          default:
            return Center(child: Text('The State ${state.runtimeType} was not recognized.'));
        }
      },
    );
  }
}

class _LoadedContactsWidget extends StatelessWidget {
  const _LoadedContactsWidget(this.state, {Key? key}) : super(key: key);
  final ContactsLoaded state;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        interactive: true,
        hoverThickness: 30,
        child: ListView(
          controller: scrollController,
          children: [
            ListTile(
              title: Text('Buscar contacto'),
              trailing: Icon(Icons.search),
              onTap: () {
                showSearch(context: context, delegate: ContactSearch());
              },
            ),
            ...List.generate(
              state.selectedContacts.length,
              (int index) {
                return FadeIn(
                  duration: Duration(milliseconds: 200),
                  child: ContactWidget(
                    state.selectedContacts[index],
                    state.selectedContacts.contains(state.selectedContacts[index]),
                    onChanged: (_) => context.read<ContactsBloc>().add(ContactsToggleSelection(contact: state.selectedContacts[index])),
                  ),
                );
              },
            ).toList(),
            ...List.generate(
              state.unselectedContacts.length,
              (int index) {
                return FadeIn(
                  duration: Duration(milliseconds: 200),
                  child: ContactWidget(
                    state.unselectedContacts[index],
                    state.selectedContacts.contains(state.unselectedContacts[index]),
                    onChanged: (_) => context.read<ContactsBloc>().add(ContactsToggleSelection(contact: state.unselectedContacts[index])),
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendSMStoContacts(context.read<ContactsBloc>().state),
        child: Icon(Icons.send),
      ),
    );
  }
}

class _NoContacts extends StatelessWidget {
  const _NoContacts(this.state);
  final ContactsState state;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'ERROR: No hay contactos para mostrar.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PermissionDenied extends StatelessWidget {
  const _PermissionDenied(this.state);
  final ContactsState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Esta aplicación necesita permiso para acceder a los contactos',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          child: Text(
            'Inténtalo de nuevo'.toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
          style: TextButton.styleFrom(
            primary: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: () async {
            if (state is ContactsPermissionDeniedPermanently) await AppSettings.openAppSettings();
            context.read<ContactsBloc>().add(ContactsLoad());
          },
        ),
      ],
    );
  }
}
