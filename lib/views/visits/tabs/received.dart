import 'package:flutter/material.dart';
import 'package:tec_pass/models/invite.dart';
import 'package:tec_pass/models/place.dart';
import 'package:tec_pass/widgets/invite_widget.dart';

class ReceivedPage extends StatelessWidget {
  const ReceivedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          InviteWidget(invite: Invite(date: DateTime.now(), place: Place('', ''), status: InviteStatus.pending)),
          InviteWidget(invite: Invite(date: DateTime.now(), place: Place('', ''), status: InviteStatus.accepted)),
          InviteWidget(invite: Invite(date: DateTime.now(), place: Place('', ''), status: InviteStatus.declined)),
        ],
      ),
    );
  }
}
