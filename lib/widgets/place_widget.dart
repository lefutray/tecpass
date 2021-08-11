import 'dart:math';
import 'package:flutter/material.dart';

import 'package:tec_pass/models/place.dart';
import 'package:tec_pass/widgets/feature_overlay.dart';

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
    if (this.showcase)
      return CustomFeatureOverlay(
        featureId: 'place_widget',
        title: 'Lugar',
        description: 'Podrás visualizar los lugares a los \nque puedes acceder aquí.',
        tapTarget: Icon(Icons.place, color: Colors.black),
        child: widget(context),
      );
    return widget(context);
  }

  ListTile widget(BuildContext context) {
    return ListTile(
      onTap: () => this.place.showDetails(context),
      contentPadding: EdgeInsets.all(20),
      title: Text(
        this.place.name,
        style: TextStyle(color: Colors.white, fontSize: 20),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFeatureOverlay(
            featureId: 'place_enter_widget',
            title: 'Ingresar',
            description: 'Este botón te permitirá ingresar al lugar.',
            child: _TriangleButton(this.place.enter, size: this.size, color: Colors.green),
          ),
          SizedBox(width: 15),
          CustomFeatureOverlay(
            featureId: 'place_exit_widget',
            title: 'Salir',
            description: 'Y este, salir.',
            child: _TriangleButton(this.place.exit, size: this.size, inverted: true),
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
  final Future<void> Function() onPressed;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: Transform.rotate(
        angle: inverted ? pi : 0,
        child: CustomPaint(
          painter: _TrianglePainter(strokeColor: color),
          child: Container(height: size, width: size),
        ),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  _TrianglePainter({
    this.strokeColor = Colors.green,
    this.strokeWidth = 1,
    this.paintingStyle = PaintingStyle.fill,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor || oldDelegate.paintingStyle != paintingStyle || oldDelegate.strokeWidth != strokeWidth;
  }
}
