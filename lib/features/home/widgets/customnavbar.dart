part of '../../../widgets/widgets.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<NavbarCubit>(context),
      builder: (BuildContext context, int state) {
        return BottomNavigationBar(
          currentIndex: state,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => (index != state) ? context.read<NavbarCubit>().emit(index) : null,
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
              icon: Icon(Icons.history),
              activeIcon: CustomFeatureOverlay(
                featureId: 'history_tab',
                title: 'Historial',
                description: 'Aquí podrás ver tus acciones recientes.',
                tapTarget: Icon(Icons.history, color: Colors.black),
                child: Icon(Icons.history),
              ),
              label: 'Historial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: CustomFeatureOverlay(
                featureId: 'perfil_tab',
                title: 'Perfil',
                description: 'Aquí podrás editar tu información personal y configuración de la aplicación.',
                tapTarget: Icon(Icons.settings_rounded, color: Colors.black),
                child: Icon(Icons.settings_rounded),
              ),
              label: 'Perfil',
            )
          ],
        );
      },
    );
  }
}
