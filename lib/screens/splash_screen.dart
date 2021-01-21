import 'package:flutter/material.dart';
import 'package:green_bot/screens/home_screen.dart';
import 'package:splashscreen/splashscreen.dart';


class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new HomeScreen(),
      title: new Text('YoYo Pizza',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
        ),
      ),
      image: Image.asset("assets/images/logo.png"),
      photoSize: 100.0,
    );
  }
}
