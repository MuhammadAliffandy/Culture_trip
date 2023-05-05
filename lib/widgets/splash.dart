import 'package:culture_trip/pages/Home%20Screen/homeScreen.dart';
import 'package:culture_trip/pages/Home%20Screen/splashScreen.dart';
import "package:flutter/material.dart";

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return HomeScreen();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
