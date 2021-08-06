import 'package:flutter/material.dart';

import 'package:tec_pass/models/invite.dart';
import 'package:tec_pass/models/place.dart';
import 'package:tec_pass/widgets/invite_widget.dart';

class SentPage extends StatelessWidget {
  const SentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          InviteWidget(invite: Invite(date: DateTime.now(), place: Place('', 'Place Number 1'), status: InviteStatus.pending)),
          InviteWidget(invite: Invite(date: DateTime.now(), place: Place('', 'Place Number 2'), status: InviteStatus.accepted)),
          InviteWidget(invite: Invite(date: DateTime.now(), place: Place('', 'Place Number 3'), status: InviteStatus.declined)),
        ],
      ),
    );
  }
}
