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
  }) : super(key: key);

  final double barheight;
  final List<TabData> tabs;
  final int animDuration;
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
        Positioned(child: Container())
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
