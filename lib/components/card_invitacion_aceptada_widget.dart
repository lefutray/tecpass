import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardInvitacionAceptadaWidget extends StatefulWidget {
  CardInvitacionAceptadaWidget({Key key}) : super(key: key);

  @override
  _CardInvitacionAceptadaWidgetState createState() =>
      _CardInvitacionAceptadaWidgetState();
}

class _CardInvitacionAceptadaWidgetState
    extends State<CardInvitacionAceptadaWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 182,
      decoration: BoxDecoration(
        color: Color(0xFF1767A4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFF47BB80),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 22,
            decoration: BoxDecoration(
              color: Color(0xFF47BB80),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    'Aceptada',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 10,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0x00EEEEEE),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                    child: Text(
                      'Invitación para [NombreApellido]',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFFF3F4F6),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      '22-02-2022',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFFF3F4F6),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      '10:00:00',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFFF3F4F6),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0x00EEEEEE),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment(0, 0.1),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF47BB80),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0x0047BB80),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                        icon: Icon(
                          Icons.qr_code,
                          color: Color(0xFFF3F4F6),
                          size: 30,
                        ),
                        iconSize: 30,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0.1),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF47BB80),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0x0047BB80),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                        icon: Icon(
                          Icons.call,
                          color: Color(0xFFF3F4F6),
                          size: 30,
                        ),
                        iconSize: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
