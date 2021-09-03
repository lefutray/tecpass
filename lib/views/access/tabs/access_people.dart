import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:tec_pass/models/models.dart';
import 'package:tec_pass/widgets/widgets.dart';

class AccessPeopleView extends StatelessWidget {
  const AccessPeopleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = [
      PlaceWidget(place: Place(id: 'asdas', name: 'Oficina 401', address: 'Av. Rivadavia 2344', query: 'Av. Rivadavia 2344', floor: '3')),
      PlaceWidget(place: Place(id: 'asdas', name: 'Oficina 510', address: 'Av. Rivadavia 2344', query: 'Av. Rivadavia 2344', floor: '3')),
      PlaceWidget(place: Place(id: 'asdas', name: 'Puerta Principal', address: 'Av. Rivadavia 2344', query: 'Av. Rivadavia 2344', floor: '3')),
    ];
    final showcaseWidget = PlaceWidget(
      place: Place(
        id: 'asdas',
        name: 'Puerta Principal',
        address: 'Av. Rivadavia 2344',
        query: 'Av. Rivadavia 2344',
        floor: '3',
      ),
      showcase: true,
    );

    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return FadeIn(
            duration: Duration(milliseconds: 500),
            child: index == 0 ? showcaseWidget : widgets[index % 3],
          );
        },
      ),
    );
  }
}
