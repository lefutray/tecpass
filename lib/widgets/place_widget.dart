part of 'widgets.dart';

Map<AccessType, IconData> accessTypeMap = {
  AccessType.walk: Icons.directions_walk,
  AccessType.bike: Icons.directions_bike,
  AccessType.car: Icons.directions_car,
};

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({
    Key? key,
    required this.place,
    this.size = 45,
    this.showcase = false,
  }) : super(key: key);

  final double size;
  final Place place;
  final bool showcase;

  @override
  Widget build(BuildContext context) {
    if (showcase) {
      return CustomFeatureOverlay(
        featureId: 'place_widget',
        title: 'Lugar',
        description: 'Podrás visualizar los lugares a los \nque puedes acceder aquí.',
        tapTarget: Icon(Icons.place, color: Colors.black),
        child: widget(context),
      );
    }
    return widget(context);
  }

  ListTile widget(BuildContext context) {
    return ListTile(
      onTap: () => place.showDetails(context),
      contentPadding: EdgeInsets.all(20),
      leading: Icon(accessTypeMap[place.accessType]),
      title: Text(
        place.name,
        style: TextStyle(color: Colors.white, fontSize: 18),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFeatureOverlay(
            featureId: 'place_enter_widget',
            title: 'Ingresar',
            description: 'Este botón te permitirá ingresar al lugar.',
            child: _TriangleButton(() async => await place.action('Entrando...'), size: size, color: Colors.green),
          ),
          SizedBox(width: 15),
          CustomFeatureOverlay(
            featureId: 'place_exit_widget',
            title: 'Salir',
            description: 'Y este, salir.',
            child: _TriangleButton(() async => await place.action('Saliendo...'), size: size, inverted: true),
          ),
        ],
      ),
    );
  }
}

class _TriangleButton extends StatelessWidget {
  const _TriangleButton(
    this.onPressed, {
    Key? key,
    required this.size,
    this.color = Colors.red,
    this.inverted = false,
  }) : super(key: key);

  final double size;
  final Color color;
  final VoidCallback onPressed;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: CircleBorder(),
      padding: EdgeInsets.zero,
      color: color,
      minWidth: size,
      height: size,
      child: Icon(
        inverted ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
        size: size,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      onPressed: onPressed,
    );
  }
}
