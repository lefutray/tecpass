import 'package:flutter/material.dart';

import 'package:tec_pass/views/views.dart';

class VisitsView extends StatelessWidget {
  const VisitsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(text: "Contactos", icon: Icon(Icons.contact_mail)),
            Tab(text: "Enviadas", icon: Icon(Icons.send)),
            Tab(text: "Recibidas", icon: Icon(Icons.receipt)),
          ],
          unselectedLabelColor: Color(0xFFA2C2DB),
          indicatorColor: Colors.green,
        ),
        body: TabBarView(
          children: [
            ContactsPage(),
            SentPage(),
            ReceivedPage(),
          ],
        ),
      ),
    );
  }
}
