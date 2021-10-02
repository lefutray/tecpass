import 'package:flutter/material.dart';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tec_pass/features/app/app.dart';
import 'package:tec_pass/features/home/cubit/navbar_cubit.dart';
import 'package:tec_pass/helpers/helpers.dart';
import 'package:tec_pass/widgets/widgets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = App();
    return Scaffold(
      body: ListView(
        children: [
          UserPhoto(editOption: true),
          _UserData(app),
          _Options(app),
        ],
      ),
    );
  }
}

class _UserData extends StatelessWidget {
  const _UserData(this.app, {Key? key}) : super(key: key);
  final App app;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            app.name ?? 'Usuario',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
          ),
          Divider(
            indent: size.width * 0.4,
            endIndent: size.width * 0.4,
            color: Colors.white,
          ),
          Text(
            app.email ?? 'Correo Electrónico',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _Options extends StatelessWidget {
  const _Options(this.app, {Key? key}) : super(key: key);

  final App app;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Mostrar tutorial', style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.lightbulb, color: Colors.white),
          onTap: () async {
            confirmationPopup(context, title: '¿Desea mostrar el tutorial?', onConfirm: () async {
              await FeatureDiscovery.clearPreferences(context, app.discoveryItems);
              FeatureDiscovery.discoverFeatures(context, app.discoveryItems);
              BlocProvider.of<NavbarCubit>(context).emit(0);
            });
          },
        ),
        ListTile(
          title: Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.logout, color: Colors.white),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text('¿Estás seguro de que quieres cerrar la sesión?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('NO'),
                  ),
                  ElevatedButton(
                    onPressed: () async => await app.authRepository.logout(context),
                    child: Text('SÍ'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
