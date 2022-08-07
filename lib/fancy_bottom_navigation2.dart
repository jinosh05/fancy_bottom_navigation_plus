import 'package:flutter/material.dart';

class FancyBottomNavigation2 extends StatefulWidget {
  const FancyBottomNavigation2({
    Key? key,
    this.barheight = 60,
  }) : super(key: key);

  final double barheight;

  @override
  State<FancyBottomNavigation2> createState() => _FancyBottomNavigation2State();
}

class _FancyBottomNavigation2State extends State<FancyBottomNavigation2> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            height: widget.barheight,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
            ]),
            child: Row()),
        Positioned(child: Container())
      ],
    );
  }
}
