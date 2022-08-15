import 'package:fancy_bottom_navigation_plus/fancy_bottom_navigation_plus.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentpage = 0;

  Center? _getpage(int page) {
    switch (page) {
      case 0:
        return Center(
          child: Text("Welcome to $page page"),
        );
      case 1:
        return Center(
          child: Text("Welcome to $page page"),
        );
      case 2:
        return Center(
          child: Text("Welcome to $page page"),
        );
      case 3:
        return Center(
          child: Text("Welcome to $page page"),
        );
      case 4:
        return Center(
          child: Text("Welcome to $page page"),
        );
      default:
        Center(
          child: Text("Welcome to $page page"),
        );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.purple,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fancy Bottom Navigation'),
          backgroundColor: Colors.purple,
        ),
        body: _getpage(currentpage),
        bottomNavigationBar: FancyBottomNavigationPlus(
          barBackgroundColor: Colors.purple,
          tabs: [
            TabData(icon: const Icon(Icons.home), title: "Home"),
            TabData(icon: const Icon(Icons.history), title: "History"),
            TabData(icon: const Icon(Icons.search), title: "Search"),
            TabData(icon: const Icon(Icons.phone), title: "Phone"),
            TabData(icon: const Icon(Icons.settings), title: "Settings"),
          ],
          onTabChangedListener: (position) {
            setState(() {
              currentpage = position;
            });
          },
        ),
      ),
    );
  }
}
