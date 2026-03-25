library fancy_bottom_navigation_plus;

import 'package:fancy_bottom_navigation_plus/components/tab_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'components/half_clipper.dart';
import 'components/half_painter.dart';

/// [FancyBottomNavigationPlus] is a highly customizable, animated bottom navigation bar
/// developed in Flutter. It features a floating circle animation that moves
/// smoothly when tabs are switched, providing a premium feel to your application.
///
/// The widget typically resides in the `bottomNavigationBar` property of a [Scaffold].
/// It supports between 2 and 5 tabs defined using [TabData] objects.
class FancyBottomNavigationPlus extends StatefulWidget {
  /// Creates a [FancyBottomNavigationPlus] widget.
  ///
  /// The [tabs] and [onTabChangedListener] arguments must not be null.
  /// The [tabs] list must have a length between 2 and 5 (inclusive).
  const FancyBottomNavigationPlus({
    Key? key,
    this.barheight = 60,
    required this.tabs,
    required this.onTabChangedListener,
    this.animDuration = 300,
    this.initialSelection = 0,
    this.barBackgroundColor,
    this.circleRadius = 60,
    this.shadowRadius = 10,
    this.circleColor,
    this.titleStyle,
    this.circleOutline = 10,
  })  : assert(tabs.length > 1 && tabs.length < 6),
        super(key: key);

  /// The duration of the slide and fade animations in milliseconds.
  /// Defaults to 300.
  final int animDuration;

  /// The background color of the navigation bar.
  /// If null, it defaults to the [Theme]'s canvas color or black54/white based on brightness.
  final Color? barBackgroundColor;

  /// The color of the animated floating circle.
  /// If null, it defaults to the [Theme]'s primary color.
  final Color? circleColor;

  /// The index of the initially selected tab.
  /// Defaults to 0.
  final int initialSelection;

  /// Callback function that is triggered when the user taps on a tab.
  /// Receives the [position] (index) of the newly selected tab.
  final Function(int position) onTabChangedListener;

  /// The height of the bottom navigation bar.
  /// Defaults to 60.0.
  final double barheight;

  /// The radius of the floating circle.
  /// Defaults to 60.0.
  final double circleRadius;

  /// The radius of the shadow applied to the navigation bar.
  /// Defaults to 10.0.
  final double shadowRadius;

  /// The width of the circle's outline border.
  /// Defaults to 10.0.
  final double circleOutline;

  /// The list of tabs to display.
  /// Must contain between 2 and 5 [TabData] objects.
  final List<TabData> tabs;

  /// Custom [TextStyle] for the tab labels.
  final TextStyle? titleStyle;

  @override
  State<FancyBottomNavigationPlus> createState() =>
      FancyBottomNavigationPlusState();
}

class FancyBottomNavigationPlusState extends State<FancyBottomNavigationPlus> {
  Widget activeIcon = const Icon(Icons.home);
  Widget nextIcon = const Icon(Icons.home);
  //  Arc is used to create sonme outline
  late double arcHeight, arcWidth;

  late Color barBackgroundColor;
  late Color circleColor;
  int currentSelected = 0;

  double _circleAlignX = 0;
  //  Opacity of the Icon
  double _circleIconAlpha = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    activeIcon = widget.tabs[currentSelected].icon;

    barBackgroundColor = widget.barBackgroundColor ??
        ((Theme.of(context).brightness == Brightness.dark)
            ? Colors.black54
            : Colors.white);

    circleColor = widget.circleColor ??
        ((Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Theme.of(context).primaryColor);

    arcHeight = widget.circleRadius + widget.shadowRadius;
    arcWidth = widget.circleRadius + (widget.shadowRadius * 3);
  }

  @override
  void initState() {
    super.initState();
    _setSelected(widget.tabs[widget.initialSelection].key);
  }

  void _setSelected(UniqueKey key) {
    int selected = widget.tabs.indexWhere((tabData) => tabData.key == key);

    if (mounted) {
      setState(() {
        currentSelected = selected;
        _circleAlignX = -1 + (2 / (widget.tabs.length - 1) * selected);
        nextIcon = widget.tabs[selected].icon;
      });
    }
  }

  _initAnimationAndStart(double from, double to) {
    _circleIconAlpha = 0;

    Future.delayed(Duration(milliseconds: widget.animDuration ~/ 5), () {
      if (mounted) {
        setState(() {
          activeIcon = nextIcon;
        });
      }
    }).then((_) {
      Future.delayed(Duration(milliseconds: (widget.animDuration ~/ 5 * 3)),
          () {
        if (mounted) {
          setState(() {
            _circleIconAlpha = 1;
          });
        }
      });
    });
  }

  void setPage(int page) {
    widget.onTabChangedListener(page);
    _setSelected(widget.tabs[page].key);
    _initAnimationAndStart(_circleAlignX, 1);

    HapticFeedback.selectionClick();

    if (mounted) {
      setState(() {
        currentSelected = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextDirection textDirection = Directionality.of(context);
    bool isRtl = TextDirection.rtl == textDirection;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        //
        // Using this container to create the
        //  background and text contemts
        //
        RepaintBoundary(
          child: Container(
              height: widget.barheight,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: barBackgroundColor,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, -1),
                        blurRadius: 8)
                  ]),
              child: Row(
                children: widget.tabs
                    .map((t) => TabItem(
                          selected: t.key == widget.tabs[currentSelected].key,
                          title: t.title,
                          uniqueKey: t.key,
                          icon: t.icon,
                          animDuration: widget.animDuration,
                          titleStyle: widget.titleStyle,
                          activeIconColor: t.activeIconColor,
                          inactiveIconColor: t.inactiveIconColor,
                          callbackFunction: (uniqueKey) {
                            int selected = widget.tabs.indexWhere(
                                (tabData) => tabData.key == uniqueKey);
                            widget.onTabChangedListener(selected);
                            _setSelected(uniqueKey);
                            _initAnimationAndStart(_circleAlignX, 1);
                            HapticFeedback.selectionClick();
                          },
                        ))
                    .toList(),
              )),
        ),

        //
        // Using this to create Icon Portion
        //

        Positioned.fill(
          top: -(widget.circleRadius +
                  widget.shadowRadius +
                  widget.circleOutline) /
              2,
          child: AnimatedAlign(
            duration: Duration(milliseconds: widget.animDuration),
            curve: Curves.easeOut,
            alignment: Alignment(isRtl ? -_circleAlignX : _circleAlignX, 1),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: widget.barheight / 2,
              ),
              child: FractionallySizedBox(
                widthFactor: 1 / widget.tabs.length,
                child: GestureDetector(
                  onTap:
                      widget.tabs[currentSelected].onclick as void Function()?,
                  child: Stack(alignment: Alignment.center, children: [
                    //
                    //  Part of the Semicircle ARC with shadow
                    //
                    ClipRect(
                      clipper: HalfClipper(),
                      child: Container(
                        width: widget.circleRadius - widget.shadowRadius,
                        height: widget.circleRadius - widget.shadowRadius,
                        decoration: BoxDecoration(
                          color: widget.barBackgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10 * 0.75, // Simplified to const
                            )
                          ],
                        ),
                      ),
                    ),

                    //
                    //  Custom Painting ARC to create Border
                    //
                    SizedBox(
                      height: arcHeight - widget.shadowRadius,
                      width: arcWidth,
                      child: RepaintBoundary(
                        child: CustomPaint(
                          painter: HalfPainter(
                            barBackgroundColor,
                            arcHeight,
                            outline: widget.shadowRadius,
                          ),
                        ),
                      ),
                    ),

                    //
                    // Container to render the Icon
                    //

                    Container(
                      width: widget.circleRadius,
                      height: widget.circleRadius,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: circleColor),
                      child: AnimatedOpacity(
                        opacity: _circleIconAlpha,
                        duration:
                            Duration(microseconds: widget.animDuration ~/ 5),
                        child: activeIcon,
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

/// [TabData] is a model used to define a single tab in [FancyBottomNavigationPlus].
class TabData {
  /// Creates a [TabData] object.
  ///
  /// The [icon] and [title] arguments must not be null.
  TabData({
    required this.icon,
    required this.title,
    this.onclick,
    this.activeIconColor,
    this.inactiveIconColor,
  });

  /// The widget used as the icon for this tab.
  Widget icon;

  /// A unique key generated for this tab to track selection.
  final UniqueKey key = UniqueKey();

  /// An optional callback function that is triggered when the active tab circle is clicked.
  Function? onclick;

  /// The text label for this tab.
  String title;

  /// Optional color for the icon when the tab is active.
  final Color? activeIconColor;

  /// Optional color for the icon when the tab is inactive.
  final Color? inactiveIconColor;
}
