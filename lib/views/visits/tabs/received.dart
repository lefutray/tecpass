import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:tec_pass/models/invite.dart';
import 'package:tec_pass/models/place.dart';
import 'package:tec_pass/widgets/invite_widget.dart';

class ReceivedPage extends StatelessWidget {
  const ReceivedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = [
      InviteWidget(invite: Invite(date: DateTime.now(), place: Place('', 'Place Number 1'), status: InviteStatus.pending, recipientName: 'Mí')),
      InviteWidget(invite: Invite(date: DateTime.now(), place: Place('', 'Place Number 2'), status: InviteStatus.accepted, recipientName: 'Mí')),
      InviteWidget(invite: Invite(date: DateTime.now(), place: Place('', 'Place Number 3'), status: InviteStatus.declined, recipientName: 'Mí')),
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
