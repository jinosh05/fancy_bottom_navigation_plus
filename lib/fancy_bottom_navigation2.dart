import 'package:fancy_bottom_navigation_2/components/half_clipper.dart';
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
    this.circleSize = 60,
    this.shadowRadius = 10,
  }) : super(key: key);

  final double barheight, circleSize, shadowRadius;
  final List<TabData> tabs;
  final int animDuration;
  final Color? barBackgroundColor;
  final Function(int position) onTabChangedListener;
  final int initialSelection;

  @override
  State<FancyBottomNavigation2> createState() => _FancyBottomNavigation2State();
}

class _FancyBottomNavigation2State extends State<FancyBottomNavigation2> {
  Widget nextIcon = const Icon(Icons.home);
  Widget activeIcon = const Icon(Icons.home);

  int currentSelected = 0;
  double _circleAlignX = 0;
  double _circleIconAlpha = 1;
  late Color barBackgroundColor;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    activeIcon = widget.tabs[currentSelected].icon;

    barBackgroundColor = widget.barBackgroundColor ??
        ((Theme.of(context).brightness == Brightness.dark)
            ? Colors.black54
            : Colors.white);
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

        Positioned(
          child: AnimatedAlign(
            duration: Duration(milliseconds: widget.animDuration),
            curve: Curves.easeOut,
            alignment: Alignment(_circleAlignX, 1),
            child: FractionallySizedBox(
              widthFactor: 1 / widget.tabs.length,
              child: InkWell(
                onTap: widget.tabs[currentSelected].onclick as void Function()?,
                child: Stack(alignment: Alignment.center, children: [
                  //
                  //  Part of the Semicircle ARC with shadow
                  //
                  ClipRect(
                    clipper: HalfClipper(),
                    child: Container(
                      width: widget.circleSize + widget.shadowRadius,
                      height: widget.circleSize + widget.shadowRadius,
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
                ]),
              ),
            ),
          ),
        )
      ],
    );
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
}

class TabData {
  TabData({required this.icon, required this.title, this.onclick});

  Widget icon;
  String title;
  Function? onclick;
  final UniqueKey key = UniqueKey();
}
