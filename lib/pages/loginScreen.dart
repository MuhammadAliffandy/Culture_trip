import 'package:culture_trip/models/user.dart';
import 'package:culture_trip/widgets/formInput.dart';
import 'package:culture_trip/widgets/navAkun.dart';
import 'package:culture_trip/widgets/signButton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../widgets/inputEdit.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController cEmail = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final Akun = new Users();
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
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Material(
                                        color: Color.fromARGB(40, 77, 77, 77),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              width: 330,
                                              height: 250,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              cEmail.clear();

                                                              Navigator.pop(context);
                                                            },
                                                            child: Text(
                                                              'batal',
                                                              style: TextStyle(
                                                                color: Theme.of(context).primaryColor,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 150,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            EditInput(
                                                              myController: cEmail,
                                                              labelAwal: 'Email',
                                                              labelAkhir: 'Masukkan Email',
                                                            ),
                                                          ],
                                                        ),
                                                        signButton(
                                                          textButton: 'Kirim',
                                                          functionButton: () async {
                                                            Akun.updatePassword(cEmail.text);
                                                            Navigator.pop(context);
                                                            showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  return AlertDialog(
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                    ),
                                                                    title: Text(
                                                                      'Permintaan Berhasil',
                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    content: Text(
                                                                      'Tunggu notifikasi di email anda, jika tidak ada cek ulang email anda! ',
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    actions: [
                                                                      Center(
                                                                        child: ElevatedButton(
                                                                          style: ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all(Colors.green),
                                                                            minimumSize: MaterialStateProperty.all(Size(150, 50)),
                                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                            )),
                                                                          ),
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Text(
                                                                            'Okay',
                                                                            style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
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
                          ProgressDialog pd = ProgressDialog(context: context);
                          pd.show(
                            msg: 'Sedang Login...',
                            progressBgColor: Theme.of(context).primaryColor,
                          );

                          if (formKey.currentState!.validate()) {
                            Akun.checkUsers(email.text, password.text).then(
                              (value) async {
                                if (value['status'] == true) {
                                  pd.close();
                                  SharedPreferences session = await SharedPreferences.getInstance();
                                  session.setString('user', value['key']);
                                  Navigator.pushNamedAndRemoveUntil(context, '/beranda', ModalRoute.withName('/beranda'));
                                } else if (value['status'] == false) {
                                  pd.close();
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
