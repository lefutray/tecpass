import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:tec_pass/models/models.dart';
import 'package:tec_pass/widgets/widgets.dart';

class SentPage extends StatelessWidget {
  const SentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = [
      InviteWidget(
        invite: Invite(
          date: DateTime.now(),
          place: Place(
            id: 'asdas',
            name: 'Puerta Principal',
            address: 'Av. Rivadavia 2344',
            query: 'Av. Rivadavia 2344',
            floor: '3',
            accessType: AccessType.walk,
          ),
          status: InviteStatus.pending,
        ),
      ),
      InviteWidget(
        invite: Invite(
          date: DateTime.now(),
          place: Place(
            id: 'asdas',
            name: 'Puerta Principal',
            address: 'Av. Rivadavia 2344',
            query: 'Av. Rivadavia 2344',
            floor: '3',
            accessType: AccessType.car,
          ),
          status: InviteStatus.accepted,
        ),
      ),
      InviteWidget(
        invite: Invite(
          date: DateTime.now(),
          place: Place(
            id: 'asdas',
            name: 'Puerta Principal',
            address: 'Av. Rivadavia 2344',
            query: 'Av. Rivadavia 2344',
            floor: '3',
            accessType: AccessType.bike,
          ),
          status: InviteStatus.declined,
        ),
      ),
    ];
    return Scaffold(
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return FadeIn(
            duration: Duration(milliseconds: 500),
            child: widgets[index % 3],
          );
        },
      ),
    );
  }
}
