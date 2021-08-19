import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_pass/app/app.dart';
import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = App();
    return Scaffold(
      body: ListView(
        children: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.width * 0.35,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('http://vignette1.wikia.nocookie.net/doblaje/images/d/d6/C-3PO_rebels.png/revision/latest?cb=20170108021237&path-prefix=es'),
                ),
              ),
            ),
          ),
          ListTile(title: Text('C-3PO', textAlign: TextAlign.center, style: TextStyle(color: Colors.white))),
          ListTile(
            title: Text('Mostrar tutorial', style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.lightbulb, color: Colors.white),
            onTap: () async {
              await FeatureDiscovery.clearPreferences(context, app.discoveryItems);
              FeatureDiscovery.discoverFeatures(context, app.discoveryItems);
              BlocProvider.of<CustomNavBarBloc>(context).add(Access());
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
                      onPressed: () async {
                        await app.authRepository.logout(context);
                      },
                      child: Text('SÍ'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
