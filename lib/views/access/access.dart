import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tec_pass/helpers/screen_orientation.dart';
import 'package:tec_pass/views/access/tabs/access_bikes.dart';
import 'package:tec_pass/views/access/tabs/access_cars.dart';
import 'package:tec_pass/views/access/tabs/access_people.dart';

class AccessView extends StatefulWidget {
  const AccessView({Key? key}) : super(key: key);

  @override
  _AccessViewState createState() => _AccessViewState();
}

class _AccessViewState extends State<AccessView> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      if (!_controller.indexIsChanging) {
        (_controller.index == 0) ? allOrientations() : portraitOnly();
      }
    });
  }

  @override
  void dispose() {
    allOrientations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _controller,
        indicatorColor: Colors.green,
        tabs: [
          Tab(text: "Personas", icon: Icon(Icons.person)),
          Tab(text: "Autos", icon: Icon(FontAwesomeIcons.car)),
          Tab(text: "Bicicletas", icon: Icon(FontAwesomeIcons.bicycle)),
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          AccessPeopleView(),
          AccessCarsView(),
          AccessBikesView(),
        ],
      ),
    );
  }
}
