import 'package:culture_trip/pages/profilScreen.dart';
import 'package:flutter/material.dart';

class LoadingUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 10)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ProfileScreen();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tunggu Sebentar',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
