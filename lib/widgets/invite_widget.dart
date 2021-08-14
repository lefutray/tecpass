import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:tec_pass/models/invite.dart';

class InviteWidget extends StatelessWidget {
  const InviteWidget({Key? key, required this.invite}) : super(key: key);
  final Invite invite;

  @override
  Widget build(BuildContext context) {
    late final Color color;
    late final String inviteTitle;
    List<Widget> buttons = [];
    switch (invite.status) {
      case InviteStatus.accepted:
        color = Color(0xFF5BC693);
        inviteTitle = 'Aceptada';
        buttons.add(_ActionInvite(icon: Icons.qr_code, color: Color(0xFF40FE90)));
        buttons.add(SizedBox(width: 10));
        buttons.add(_ActionInvite(icon: Icons.phone, color: Color(0xFF40FE90)));
        break;
      case InviteStatus.declined:
        color = Color(0xFFE74C3C);
        inviteTitle = 'Rechazada';
        break;
      case InviteStatus.pending:
        color = Color(0xFF3191C0);
        inviteTitle = 'Nueva Invitación';
        buttons.add(_ActionInvite(path: 'assets/Cancelar.svg'));
        buttons.add(SizedBox(width: 10));
        buttons.add(_ActionInvite(path: 'assets/Check.svg'));
        break;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: color, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: color,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Icon(Icons.insert_invitation, color: Colors.white, size: 18),
                ),
                Text(
                  inviteTitle,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0x00EEEEEE),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                  child: Text(
                    '${invite.place.name} - Para ${invite.recipientName}',
                    style: TextStyle(color: Color(0xFFF3F4F6), fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: (inviteTitle != 'Rechazada') ? 20 : 0),
                child: Text(
                  printDate(invite) + ' - ' + printTime(invite),
                  style: TextStyle(color: Color(0xFFF3F4F6), fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          if (inviteTitle != 'Rechazada')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...buttons,
              ],
            ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  String printDate(Invite invite) {
    final date = DateFormat("dd/MM/yyyy").format(invite.date);
    return date;
  }

  String printTime(Invite invite) {
    final date = DateFormat("HH:mm").format(invite.date);
    return date + 'hs';
  }
}

class _ActionInvite extends StatelessWidget {
  _ActionInvite({this.path, this.icon, this.color});
  final String? path;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        color: Colors.white,
        iconSize: 30,
        splashRadius: 30,
        onPressed: () async {},
        icon: icon != null
            ? Icon(icon)
            : SvgPicture.asset(
                path!,
                height: 50,
                width: 50,
                fit: BoxFit.fitHeight,
              ),
      ),
    );
  }
}
