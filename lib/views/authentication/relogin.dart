import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

import 'package:tec_pass/app/app.dart';

class ReLogin extends StatelessWidget {
  const ReLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = App();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: MediaQuery.of(context).size.width * 0.1,
            ),
            radius: MediaQuery.of(context).size.width * 0.08,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.1),
          Text('Encontramos una sesión previa de ${app.email ?? app.name}', style: TextStyle(color: Colors.white)),
          Text('¿Quieres restaurar esta sesión?', style: TextStyle(color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                child: Text('Cancelar', style: TextStyle(color: Colors.white)),
                onPressed: () async => await app.authRepository.deleteSession(context),
              ),
              MaterialButton(
                child: Text('Restaurar', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  final LocalAuthentication auth = LocalAuthentication();
                  if (await auth.authenticate(localizedReason: 'Restaurar la sesión de ${app.email ?? app.name}')) {
                    app.authRepository.relogin(context);
                  } else {
                    await app.authRepository.deleteSession(context);
                    await Fluttertoast.showToast(msg: 'La sesión no se ha podido recuperar');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
