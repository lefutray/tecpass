part of 'models.dart';

enum AccessType { walk, bike, car }

class Place {
  final String id;
  final String query;
  final String address;
  final String? floor;
  final String? additionalInfo;
  final AccessType accessType;
  final String name;

  Place({
    required this.id,
    required this.name,
    required this.query,
    required this.address,
    required this.accessType,
    this.floor,
    this.additionalInfo,
  });

  Future action(String action) async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: action,
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
                        await action('Entrando...');
                        Navigator.pop(context);
                      },
                      child: Text('Entrar'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await action("Saliendo...");
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
