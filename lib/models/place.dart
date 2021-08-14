import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Place {
  final String id;
  final String name;

  Place(this.id, this.name);

  Future<void> enter() async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: "Entrando...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<void> exit() async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: "Saliendo...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  void showDetails(BuildContext context) async {
    final textStyle = TextStyle(color: Colors.white);
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Color(0xFF00A9E2),
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Información del lugar:\n', style: textStyle),
                Text('Nombre: $name', style: textStyle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await enter();
                        Navigator.pop(context);
                      },
                      child: Text('Entrar'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await exit();
                        Navigator.pop(context);
                      },
                      child: Text('Salir'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
