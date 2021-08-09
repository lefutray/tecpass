import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tec_pass/models/place.dart';
import 'package:tec_pass/widgets/place_widget.dart';

class AccessPeopleView extends StatelessWidget {
  const AccessPeopleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = [
      PlaceWidget(place: Place('asdas', 'Oficina 401')),
      PlaceWidget(place: Place('asdas', 'Oficina 510')),
      PlaceWidget(place: Place('asdas', 'Puerta Principal')),
    ];
    final showcaseWidget = PlaceWidget(place: Place('asdas', 'Puerta Principal'), showcase: true);
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return FadeInLeft(
            from: 40,
            duration: Duration(milliseconds: 500),
            child: index == 0 ? showcaseWidget : widgets[index % 3],
          );
        },
      ),
    );
  }
}
