import 'package:culture_trip/models/user.dart';
import 'package:culture_trip/widgets/formInput.dart';
import 'package:culture_trip/widgets/navAkun.dart';
import 'package:culture_trip/widgets/signButton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  final formKey = new GlobalKey<FormState>();

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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      FormInput(
                        myController: email,
                        labelAwal: 'Email',
                        labelAkhir: 'Masukan Email',
                        typeInput: false,
                        logicValidation: (value) {
                          if (value.isEmpty) {
                            return 'Email harus diisi';
                          } else if (!value.contains("@")) {
                            return 'Email tidak valid';
                          }
                        },
                      ),
                      FormInput(
                        myController: password,
                        labelAwal: 'Password',
                        labelAkhir: 'Masukan Password',
                        typeInput: true,
                        logicValidation: (value) {
                          if (value.isEmpty) {
                            return 'Password harus diisi';
                          }
                        },
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
                          final Akun = Users();

                          if (formKey.currentState!.validate()) {
                            Akun.checkUsers(email.text, password.text).then(
                              (value) async {
                                if (value['status'] == true) {
                                  SharedPreferences session = await SharedPreferences.getInstance();
                                  session.setString('user', value['key']);
                                  Navigator.pushNamedAndRemoveUntil(context, '/beranda', ModalRoute.withName('/beranda'));
                                } else if (value['status'] == false) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Email atau password salah',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                            );
                          }
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
