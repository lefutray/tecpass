import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tec_pass/views/access/tabs/access_bikes.dart';
import 'package:tec_pass/views/access/tabs/access_cars.dart';
import 'package:tec_pass/views/access/tabs/access_people.dart';

class AccessView extends StatelessWidget {
  const AccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          indicatorColor: Colors.green,
          tabs: [
            Tab(text: "Personas", icon: Icon(Icons.person)),
            Tab(text: "Autos", icon: Icon(FontAwesomeIcons.car)),
            Tab(text: "Bicicletas", icon: Icon(FontAwesomeIcons.bicycle)),
          ],
        ),
        body: TabBarView(
          children: [
            AccessPeopleView(),
            AccessCarsView(),
            AccessBikesView(),
          ],
        ),
      ),
    );
  }
}
