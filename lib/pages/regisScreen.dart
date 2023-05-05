import 'package:flutter/material.dart';
import 'package:culture_trip/widgets/formInput.dart';
import 'package:culture_trip/widgets/navAkun.dart';
import 'package:culture_trip/widgets/signButton.dart';

class RegisScreen extends StatelessWidget {
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
                'Create Account',
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
                'Silahkan buat akun untuk lanjut !',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    FormInput(
                      labelAwal: 'Nama',
                      labelAkhir: 'Masukan Nama',
                      typeInput: false,
                    ),
                    FormInput(
                      labelAwal: 'Alamat',
                      labelAkhir: 'Masukan Alamat',
                      typeInput: false,
                    ),
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
                    SizedBox(
                      height: 40,
                    ),
                    signButton(
                      textButton: 'Sign Up',
                    ),
                    NavAkun(
                      textContent: 'Sudah punya akun ?',
                      textButton: 'Sign In',
                      functionButton: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/login'));
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
