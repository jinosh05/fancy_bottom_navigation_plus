import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class HalfPainter extends CustomPainter {
  HalfPainter(Color paintColor, this.height, {this.outline = 10}) {
    arcPaint = Paint()..color = paintColor;
  }

  late Paint arcPaint;
  final double? height;
  final double outline;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect =
        Rect.fromLTWH(0, (size.height / 2) - outline, outline, outline);
    final Rect largeRect = Rect.fromLTWH(
      outline,
      0,
      size.width - outline * 2,
      height ?? 60,
    );
    final Rect afterRect = Rect.fromLTWH(
        size.width - outline, (size.height / 2) - outline, outline, outline);

    final path = Path();
    path.arcTo(beforeRect, radians(0), radians(90), false);
    path.lineTo(outline * 2, size.height / 2);
    path.arcTo(largeRect, radians(0), -radians(180), false);
    path.moveTo(size.width - outline, size.height / 2);
    path.lineTo(size.width - outline, (size.height / 2) - outline);
    path.arcTo(afterRect, radians(180), radians(-90), false);
    path.close();

    canvas.drawPath(path, arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
