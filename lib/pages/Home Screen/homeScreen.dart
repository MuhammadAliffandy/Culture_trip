import 'package:culture_trip/main.dart';
import 'package:culture_trip/pages/loginScreen.dart';
import 'package:culture_trip/widgets/signButton.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Container(
                width: 300,
                height: 300,
                child: Image.asset('lib/assets/images/tripvector.png'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                child: Column(
                  children: [
                    Text(
                      'Welcome to CultureTrip',
                      style: TextStyle(
                        fontSize: 28,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Nikmati perjalan wisata menyenangkan dan bermanfaat dengan pengenalan beraneka ragam budaya',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    signButton(
                      textButton: 'Sign In',
                      functionButton: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    signupButton(
                      functionButton: () {
                        Navigator.pushNamed(context, '/regis');
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
