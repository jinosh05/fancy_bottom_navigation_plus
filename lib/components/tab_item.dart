import 'package:flutter/material.dart';

const double iconOff = -3;
const double iconOn = 0;
const double textOff = 3;
const double textOn = 1;

class TabItem extends StatelessWidget {
  const TabItem({
    Key? key,
    this.animDuration = 300,
    required this.selected,
    required this.title,
    required this.uniqueKey,
    required this.icon,
    this.titleStyle,
    required this.callbackFunction,
  }) : super(key: key);

  final int animDuration;
  final bool selected;
  final UniqueKey uniqueKey;
  final String title;
  final Widget icon;
  final TextStyle? titleStyle;
  final Function(UniqueKey uniqueKey) callbackFunction;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => callbackFunction(uniqueKey),
      child: Expanded(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedAlign(
              alignment: Alignment(0, selected ? textOn : textOff),
              duration: Duration(milliseconds: animDuration),
              child: Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: titleStyle ??
                      const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
            ),
            AnimatedAlign(
              alignment: Alignment(0, (selected) ? iconOff : iconOn),
              duration: Duration(milliseconds: animDuration),
              child: AnimatedOpacity(
                opacity: selected ? 1 : 0,
                duration: Duration(milliseconds: animDuration),
                child: icon,
              ),
            )
          ],
        ),
      ),
    );
  }
}
