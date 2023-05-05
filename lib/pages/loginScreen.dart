import 'package:culture_trip/models/user.dart';
import 'package:culture_trip/widgets/formInput.dart';
import 'package:culture_trip/widgets/navAkun.dart';
import 'package:culture_trip/widgets/signButton.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                child: Image.asset('lib/assets/images/CultureTrip-01.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Silahkan masuk terlebih dahulu untuk lanjut !',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    FormInput(
                      labelAwal: 'Email',
                      labelAkhir: 'Masukan Email',
                      typeInput: false,
                    ),
                    FormInput(
                      labelAwal: 'Password',
                      labelAkhir: 'Masukan Password',
                      typeInput: true,
                    ),
                    Container(
                      width: 297,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Lupa password?',
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    signButton(
                      textButton: 'Sign In',
                      functionButton: () {
                        Navigator.pushNamed(context, '/beranda');
                      },
                    ),
                    NavAkun(
                      textContent: 'Belum punya akun ?',
                      textButton: 'Sign Up',
                      functionButton: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/regis', ModalRoute.withName('/regis'));
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
