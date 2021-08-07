import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomNavBarBloc, CustomNavBarState>(
      builder: (BuildContext context, CustomNavBarState state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: (index) {
            if (index != state.index) {
              switch (index) {
                case 0:
                  context.read<CustomNavBarBloc>().add(Access());
                  break;
                case 1:
                  context.read<CustomNavBarBloc>().add(Visits());
                  break;
                default:
                  context.read<CustomNavBarBloc>().add(Profile());
                  break;
              }
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.sensor_door_outlined),
              activeIcon: Icon(Icons.sensor_door_sharp),
              label: 'Accesos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt),
              activeIcon: Icon(Icons.person_add_alt_1),
              label: 'Visitas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_history_outlined),
              activeIcon: Icon(Icons.location_history_rounded),
              label: 'Perfil',
            )
          ],
          backgroundColor: Color(0xFF1767A4),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFFA2C2DB),
        );
      },
    );
  }
}
