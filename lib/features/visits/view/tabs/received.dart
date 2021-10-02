import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:tec_pass/models/models.dart';
import 'package:tec_pass/widgets/widgets.dart';

class ReceivedPage extends StatelessWidget {
  const ReceivedPage({Key? key}) : super(key: key);

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
            ),
            status: InviteStatus.pending,
            recipientName: 'Mí'),
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
            ),
            status: InviteStatus.accepted,
            recipientName: 'Mí'),
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
            ),
            status: InviteStatus.declined,
            recipientName: 'Mí'),
      ),
    ];
    return Scaffold(
      body: ListView.builder(
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
