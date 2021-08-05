import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tec_pass/models/place.dart';

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({
    Key? key,
    required this.place,
    this.size = 45,
  }) : super(key: key);

  final double size;
  final Place place;

  @override
  Widget build(BuildContext context) {
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
          _TriangleButton(this.place.enter, size: this.size, color: Colors.green),
          SizedBox(width: 15),
          _TriangleButton(this.place.exit, size: this.size, inverted: true),
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
