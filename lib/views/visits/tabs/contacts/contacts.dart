import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:tec_pass/helpers/helpers.dart';
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

class _LoadedContactsWidget extends StatefulWidget {
  const _LoadedContactsWidget(this.state, {Key? key}) : super(key: key);
  final ContactsLoaded state;

  @override
  __LoadedContactsWidgetState createState() => __LoadedContactsWidgetState();
}

class __LoadedContactsWidgetState extends State<_LoadedContactsWidget> with SingleTickerProviderStateMixin {
  late AnimationController _fabVisibility;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _fabVisibility = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _fabVisibility.value = 1;
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    _fabVisibility.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _handleScrollNotification(ScrollNotification notification) {
      if (notification.depth == 0) {
        if (notification is UserScrollNotification) {
          final UserScrollNotification userScroll = notification;
          switch (userScroll.direction) {
            case ScrollDirection.forward:
              if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
                _fabVisibility.forward();
              }
              break;
            case ScrollDirection.reverse:
              if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
                _fabVisibility.reverse();
              }
              break;
            case ScrollDirection.idle:
              break;
          }
        }
      }
      return false;
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        body: Scrollbar(
          controller: scrollController,
          interactive: true,
          hoverThickness: 30,
          child: ListView(
            controller: scrollController,
            children: [
              searchContact(context),
              ...contactsList(context, widget.state.selectedContacts),
              ...contactsList(context, widget.state.unselectedContacts),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FadeTransition(
          opacity: _fabVisibility,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.white,
            onPressed: () => sendSMStoContacts(context.read<ContactsBloc>().state),
            label: Row(
              children: [
                Icon(Icons.add_circle_outline, color: Colors.blue),
                Text('  Enviar invitación', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchContact(BuildContext context) {
    return ListTile(
      title: Text('Buscar contacto', style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.search, color: Colors.white),
      onTap: () async {
        await showSearch(context: context, delegate: ContactSearch());
      },
    );
  }

  List<Widget> contactsList(BuildContext context, List<Contact> contacts) {
    return List.generate(
      contacts.length,
      (int index) {
        return FadeIn(
          duration: Duration(milliseconds: 200),
          child: ContactWidget(
            contacts[index],
            (BlocProvider.of<ContactsBloc>(context).state as ContactsLoaded).selectedContacts.contains(contacts[index]),
            onChanged: (_) => context.read<ContactsBloc>().add(ContactsToggleSelection(contacts[index])),
          ),
        );
      },
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
