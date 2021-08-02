import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BotonesAccesosWidget extends StatefulWidget {
  BotonesAccesosWidget({Key key}) : super(key: key);

  @override
  _BotonesAccesosWidgetState createState() => _BotonesAccesosWidgetState();
}

class _BotonesAccesosWidgetState extends State<BotonesAccesosWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.primaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF279661),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  print('IconButton pressed ...');
                },
                icon: FaIcon(
                  FontAwesomeIcons.userAlt,
                  color: Colors.white,
                  size: 35,
                ),
                iconSize: 35,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFA2C2DB),
                  width: 1,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  print('IconButton pressed ...');
                },
                icon: Icon(
                  Icons.directions_car,
                  color: Color(0xFFA2C2DB),
                  size: 43,
                ),
                iconSize: 43,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0x00EEEEEE),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFA2C2DB),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  print('IconButton pressed ...');
                },
                icon: Icon(
                  Icons.pedal_bike_outlined,
                  color: Color(0xFFA2C2DB),
                  size: 45,
                ),
                iconSize: 45,
              ),
            ),
          )
        ],
      ),
    );
  }
}
