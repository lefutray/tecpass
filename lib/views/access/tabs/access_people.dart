import 'package:flutter/material.dart';
import 'package:tec_pass/models/place.dart';
import 'package:tec_pass/widgets/place_widget.dart';

class AccessPeopleView extends StatelessWidget {
  const AccessPeopleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PlaceWidget(place: Place('asdas', 'Oficina 401')),
        PlaceWidget(place: Place('asdas', 'Oficina 510')),
        PlaceWidget(place: Place('asdas', 'Puerta Principal')),
      ],
    );
  }
}
