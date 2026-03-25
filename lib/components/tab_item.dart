import 'package:flutter/material.dart';

/// Position of the icon when it is not selected.
const double iconOff = -3;

/// Position of the icon when it is selected.
const double iconOn = 0;

/// Position of the text when it is not selected.
const double textOff = 3;

/// Position of the text when it is selected.
const double textOn = 1;

/// [TabItem] is an internal widget used to render an individual tab
/// within the [FancyBottomNavigationPlus] bar.
class TabItem extends StatelessWidget {
  /// Creates a [TabItem].
  const TabItem({
    Key? key,
    this.animDuration = 300,
    required this.selected,
    required this.title,
    required this.uniqueKey,
    required this.icon,
    this.titleStyle,
    required this.callbackFunction,
    this.activeIconColor,
    this.inactiveIconColor,
  }) : super(key: key);

  /// The duration of the transition animations.
  final int animDuration;

  /// Whether this tab is currently selected.
  final bool selected;

  /// The unique key associated with this tab.
  final UniqueKey uniqueKey;

  /// The text label to display.
  final String title;

  /// The icon widget to display.
  final Widget icon;

  /// Custom text style for the label.
  final TextStyle? titleStyle;

  /// Callback function triggered when this tab is tapped.
  final Function(UniqueKey uniqueKey) callbackFunction;

  /// Optional color for the icon when the tab is active.
  final Color? activeIconColor;

  /// Optional color for the icon when the tab is inactive.
  final Color? inactiveIconColor;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: selected ? 1 : 0,
            child: AnimatedAlign(
              alignment: Alignment(0, selected ? textOn : textOff),
              duration: Duration(milliseconds: animDuration),
              curve: Curves.easeInOut,
              child: Padding(
                padding: EdgeInsets.all(height * 0.015),
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: titleStyle ??
                      const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            alignment: Alignment(0, (selected) ? iconOff : iconOn),
            duration: Duration(milliseconds: animDuration),
            curve: Curves.easeInOut,
            child: AnimatedOpacity(
              opacity: selected ? 0 : 1,
              duration: Duration(milliseconds: animDuration),
              child: InkWell(
                onTap: () => callbackFunction(uniqueKey),
                child: IconTheme(
                  data: IconThemeData(
                    color: selected
                        ? (activeIconColor ?? Colors.white)
                        : (inactiveIconColor ?? Colors.white),
                  ),
                  child: icon,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
