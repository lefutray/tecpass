import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octo_image/octo_image.dart';

import 'package:tec_pass/app/app.dart';
import 'package:tec_pass/bloc/bloc.dart';
import 'package:tec_pass/helpers/helpers.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = App();
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          _Photo(),
          _UserData(app),
          _Options(app),
        ],
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 0.33,
        right: size.width * 0.33,
        top: 20,
      ),
      child: Stack(
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.base64Photo != null) {
                return OctoImage(
                  image: MemoryImage(Uint8List.fromList(base64Decode(state.base64Photo!))),
                  imageBuilder: OctoImageTransformer.circleAvatar(),
                  placeholderBuilder: (_) => _noImage(size),
                  errorBuilder: (_, __, ___) => _noImage(size),
                  colorBlendMode: BlendMode.dstOver,
                  height: size.width * 0.35,
                  width: size.width * 0.35,
                  color: Colors.black38,
                  gaplessPlayback: true,
                );
              }
              return _noImage(size);
            },
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: GestureDetector(
              onTap: () => pickUserPhoto(context),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: size.width * 0.06,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CircleAvatar _noImage(Size size) {
    return CircleAvatar(
      radius: size.width * 0.175,
      backgroundColor: Colors.black38,
      child: Icon(
        Icons.person,
        color: Colors.white,
        size: size.width * 0.1,
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
              BlocProvider.of<CustomNavBarBloc>(context).add(Access());
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
