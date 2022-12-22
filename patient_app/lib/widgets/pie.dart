import 'dart:math';

import 'package:flutter/material.dart';

class Pie extends StatelessWidget {
  const Pie({
    super.key,
    required this.radius,
    required this.colors,
    this.sweepAngle = 2 * pi,
    this.targetAngle,
  });

  final double radius;
  final List<MaterialColor> colors;
  final double sweepAngle;
  final double startingAngle = pi;
  final double? targetAngle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2 * radius,
      height: sweepAngle > pi ? 2 * radius : radius,
      child: CustomPaint(
        painter: _PiePainter(
          radius: radius,
          sweepAngle: sweepAngle,
          startingAngle: startingAngle,
          colors: colors,
          targetAngle: targetAngle,
        ),
      ),
    );
  }
}

class _PiePainter extends CustomPainter {
  final double startingAngle;
  final double sweepAngle;
  final double radius;
  final List<MaterialColor> colors;
  final double? targetAngle;

  _PiePainter({
    required this.radius,
    required this.startingAngle,
    required this.sweepAngle,
    required this.colors,
    required this.targetAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final pieSize = sweepAngle / colors.length;

    for (int i = 0; i < colors.length; i++) {
      canvas.drawArc(
          Rect.fromCircle(center: Offset(radius, radius), radius: radius),
          i * pieSize + startingAngle,
          pieSize,
          true,
          Paint()
            ..color = colors[i]
            ..style = PaintingStyle.fill);
    }

    if (targetAngle != null) {
      final painter = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(radius, radius);
      canvas.rotate(
          targetAngle! * pieSize * colors.length + startingAngle - pi / 2);
      canvas.drawRect(
          Rect.fromPoints(Offset(-radius * 0.05, radius * 0.01),
              Offset(radius * 0.05, radius * 0.70)),
          painter);
      canvas.drawCircle(Offset(0, radius * 0.70), radius * 0.12, painter);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}
