import 'package:flutter/material.dart';

/// [HalfClipper] is a custom [Rect] clipper that clips the bottom half of a widget.
/// It is used to create the background shadow effect for the floating circle.
class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
