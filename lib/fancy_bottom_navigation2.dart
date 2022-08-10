import 'package:fancy_bottom_navigation_2/components/half_clipper.dart';
import 'package:fancy_bottom_navigation_2/components/half_painter.dart';
import 'package:fancy_bottom_navigation_2/components/tab_item.dart';
import 'package:flutter/material.dart';

class FancyBottomNavigation2 extends StatefulWidget {
  const FancyBottomNavigation2({
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
  })  : assert(tabs.length > 1 && tabs.length < 5),
        super(key: key);

  final int animDuration;
  final Color? barBackgroundColor, circleColor;
  final int initialSelection;
  final Function(int position) onTabChangedListener;
  final double barheight, circleRadius, shadowRadius, circleOutline;
  final List<TabData> tabs;
  final TextStyle? titleStyle;

  @override
  State<FancyBottomNavigation2> createState() => FancyBottomNavigation2State();
}

class FancyBottomNavigation2State extends State<FancyBottomNavigation2> {
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
      setState(() {
        activeIcon = nextIcon;
      });
    }).then((_) {
      Future.delayed(Duration(milliseconds: (widget.animDuration ~/ 5 * 3)),
          () {
        setState(() {
          _circleIconAlpha = 1;
        });
      });
    });
  }

  void setPage(int page) {
    widget.onTabChangedListener(page);
    _setSelected(widget.tabs[page].key);
    _initAnimationAndStart(_circleAlignX, 1);

    setState(() {
      currentSelected = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        //
        // Using this container to create the
        //  background and text contemts
        //
        Container(
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
                        callbackFunction: (uniqueKey) {
                          int selected = widget.tabs.indexWhere(
                              (tabData) => tabData.key == uniqueKey);
                          widget.onTabChangedListener(selected);
                          _setSelected(uniqueKey);
                          _initAnimationAndStart(_circleAlignX, 1);
                        },
                      ))
                  .toList(),
            )),

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
            alignment: Alignment(_circleAlignX, 1),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: (widget.circleRadius / 2) - widget.shadowRadius,
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
                        width: widget.circleRadius + widget.shadowRadius,
                        height: widget.circleRadius + widget.shadowRadius,
                        decoration: BoxDecoration(
                          color: widget.barBackgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: widget.shadowRadius * 0.75,
                            )
                          ],
                        ),
                      ),
                    ),

                    //
                    //  Custom Painting ARC to create Border
                    //
                    SizedBox(
                      height: arcHeight,
                      width: arcWidth,
                      child: CustomPaint(
                        painter: HalfPainter(
                          barBackgroundColor,
                          arcHeight,
                          outline: widget.shadowRadius,
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

class TabData {
  TabData({required this.icon, required this.title, this.onclick});

  Widget icon;
  final UniqueKey key = UniqueKey();
  Function? onclick;
  String title;
}
