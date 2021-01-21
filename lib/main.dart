
import 'package:flutter/material.dart';
import 'package:green_bot/screens/home_screen.dart';
import 'package:green_bot/screens/new_order.dart';
import 'package:green_bot/screens/splash_screen.dart';
import 'package:green_bot/screens/track_order.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Hexcolor("#00b34d"),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        NewOrder.routeName: (_) => NewOrder(),
        TrackOrder.routeName: (_) => TrackOrder(),
      },
    );
  }
}
