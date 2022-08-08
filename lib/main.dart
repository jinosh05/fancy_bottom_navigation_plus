import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation2.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey bottomNavigationKey = GlobalKey();
  int currentPage = 0;

  _getPage(int page) {
    switch (page) {
      case 0:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text("This is the home page"),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SecondPage()));
              },
              child: const Text(
                "Start new page",
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                final FancyBottomNavigation2State fState = bottomNavigationKey
                    .currentState as FancyBottomNavigation2State;
                fState.setPage(2);
              },
              child: const Text(
                "Change to page 3",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text("This is the search page"),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SecondPage()));
              },
              child: const Text(
                "Start new page",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text("This is the basket page"),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {},
              child: const Text(
                "Start new page",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fancy Bottom Navigation"),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation2(
        titleStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: [
          TabData(
            icon: const Icon(Icons.home),
            title: "Home",
            onclick: () {
              final FancyBottomNavigation2State fState = bottomNavigationKey
                  .currentState as FancyBottomNavigation2State;
              fState.setPage(2);
            },
          ),
          TabData(
              icon: const Icon(Icons.search),
              title: "Search",
              onclick: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SecondPage()))),
          TabData(icon: const Icon(Icons.shopping_cart), title: "Basket"),
          TabData(
              icon: const Icon(Icons.settings),
              title: "Settings",
              onclick: () {
                final FancyBottomNavigation2State fState = bottomNavigationKey
                    .currentState as FancyBottomNavigation2State;
                fState.setPage(2);
              }),
        ],
        initialSelection: 1,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[Text("Hello"), Text("World")],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Page")),
    );
  }
}
