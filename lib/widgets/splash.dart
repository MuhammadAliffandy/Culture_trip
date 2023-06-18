import 'package:culture_trip/models/user.dart';
import 'package:culture_trip/pages/Home%20Screen/berandaScreen.dart';
import 'package:culture_trip/pages/Home%20Screen/homeScreen.dart';
import 'package:culture_trip/pages/Home%20Screen/splashScreen.dart';
import "package:flutter/material.dart";

class MySplashScreen extends StatelessWidget {
  final Akun = Users();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder<bool>(
              future: Akun.cekUserLogin(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data == true) {
                  return BerandaScreen();
                } else {
                  return HomeScreen();
                }
              },
            );
          } else {
            return SplashScreen();
          }
        });
  }
}
