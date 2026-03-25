import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

/// [HalfPainter] is a [CustomPainter] that draws a unique "arc" border for the
/// floating circle in [FancyBottomNavigationPlus].
class HalfPainter extends CustomPainter {
  /// Creates a [HalfPainter].
  ///
  /// [paintColor] defines the color of the arc.
  /// [height] defines the height of the arc portion.
  /// [outline] defines the thickness of the border/outline.
  HalfPainter(this.paintColor, this.height, {this.outline = 10}) {
    arcPaint = Paint()..color = paintColor;
  }

  /// The color used to paint the arc.
  final Color paintColor;

  /// The [Paint] object used to draw the arc.
  late Paint arcPaint;

  /// The height of the arc.
  final double? height;

  /// The width of the outline border.
  final double outline;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect =
        Rect.fromLTWH(0, (size.height / 2) - outline, outline, outline);
    final Rect largeRect = Rect.fromLTWH(
      outline,
      0,
      size.width - outline * 2,
      height ?? 40,
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
  bool shouldRepaint(HalfPainter oldDelegate) {
    return oldDelegate.paintColor != paintColor ||
        oldDelegate.height != height ||
        oldDelegate.outline != outline;
  }
}
