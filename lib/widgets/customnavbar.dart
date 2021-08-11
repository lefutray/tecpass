import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';
import 'package:tec_pass/widgets/feature_overlay.dart';

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
              activeIcon: CustomFeatureOverlay(
                featureId: 'access_tab',
                title: 'Accesso',
                description: 'En esta pestaña se muestran los datos de acceso a los lugares',
                tapTarget: Icon(Icons.sensor_door_sharp, color: Colors.black),
                child: Icon(Icons.sensor_door_sharp),
              ),
              label: 'Accesos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt),
              activeIcon: CustomFeatureOverlay(
                featureId: 'visits_tab',
                title: 'Visitas',
                description: 'Aquí podrás dar acceso a otras personas.',
                tapTarget: Icon(Icons.person_add_alt_1, color: Colors.black),
                child: Icon(Icons.person_add_alt_1),
              ),
              label: 'Visitas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_history_outlined),
              activeIcon: CustomFeatureOverlay(
                featureId: 'perfil_tab',
                title: 'Visitas',
                description: 'Aquí podrás editar tu información personal y configuración de la aplicación.',
                tapTarget: Icon(Icons.location_history_rounded, color: Colors.black),
                child: Icon(Icons.location_history_rounded),
              ),
              label: 'Perfil',
            )
          ],
        );
      },
    );
  }
}
