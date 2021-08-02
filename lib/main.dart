import 'package:flutter/material.dart';
import 'package:tec_pass/login/login_widget.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'accesos/accesos_widget.dart';
import 'visitas/visitas_widget.dart';
import 'perfil/perfil_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TecPass',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NavBarPage(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'Accesos';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Accesos': AccesosWidget(),
      'Visitas': VisitasWidget(),
      'Perfil': PerfilWidget(),
    };
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sensor_door_outlined,
              color: Color(0xFF9E9E9E),
              size: 30,
            ),
            activeIcon: Icon(
              Icons.sensor_door_sharp,
              color: FlutterFlowTheme.primaryColor,
              size: 30,
            ),
            label: 'Accesos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add_alt,
              color: Color(0xFF9E9E9E),
              size: 35,
            ),
            activeIcon: Icon(
              Icons.person_add_alt_1,
              color: FlutterFlowTheme.primaryColor,
              size: 35,
            ),
            label: 'Visitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_history_outlined,
              color: Color(0xFF9E9E9E),
              size: 35,
            ),
            activeIcon: Icon(
              Icons.location_history_rounded,
              color: FlutterFlowTheme.primaryColor,
              size: 35,
            ),
            label: 'Perfil',
          )
        ],
        backgroundColor: Color(0xFF1767A4),
        currentIndex: tabs.keys.toList().indexOf(_currentPage),
        selectedItemColor: Colors.white,
        unselectedItemColor: FlutterFlowTheme.customColor1,
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
