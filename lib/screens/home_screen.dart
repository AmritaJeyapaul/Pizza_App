import 'package:green_bot/screens/new_order.dart';
import 'package:green_bot/screens/track_order.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle textStyle = const TextStyle(
    fontSize: 24,
  );

  int index = 0;

@override
Widget build(BuildContext context) {
  return new Scaffold(
    body: new Stack(
      children: <Widget>[
        new Offstage(
          offstage: index != 0,
          child: new TickerMode(
            enabled: index == 0,
            child: new MaterialApp(home: new NewOrder(),debugShowCheckedModeBanner: false),
          ),
        ),
        new Offstage(
          offstage: index != 1,
          child: new TickerMode(
            enabled: index == 1,
            child: new MaterialApp(home: new TrackOrder(),debugShowCheckedModeBanner: false),
          ),
        ),
      ],
    ),
    bottomNavigationBar: new BottomNavigationBar(
      currentIndex: index,
      onTap: (int index) { setState((){ this.index = index; }); },
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
          icon: new Icon(Icons.chat_bubble),
          // ignore: deprecated_member_use
          title: new Text("Order Here"),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.location_on),
          title: new Text("Track Order"),
        ),
      ],
    ),
  );
}
}
