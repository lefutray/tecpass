import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tec_pass/helpers/helpers.dart';
import 'package:tec_pass/views/access/tabs/access_bikes.dart';
import 'package:tec_pass/views/access/tabs/access_cars.dart';
import 'package:tec_pass/views/access/tabs/access_people.dart';

class AccessView extends StatefulWidget {
  const AccessView({Key? key}) : super(key: key);

  @override
  _AccessViewState createState() => _AccessViewState();
}

class _AccessViewState extends State<AccessView> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging && tabController.index != 0)
        portraitOnly();
      else
        allOrientations();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: tabController,
        indicatorColor: Colors.green,
        tabs: [
          Tab(text: "Personas", icon: Icon(Icons.person)),
          Tab(text: "Autos", icon: Icon(FontAwesomeIcons.car)),
          Tab(text: "Bicicletas", icon: Icon(FontAwesomeIcons.bicycle)),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          AccessPeopleView(),
          AccessCarsView(),
          AccessBikesView(),
        ],
      ),
    );
  }
}
