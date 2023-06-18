import 'package:culture_trip/models/user.dart';
import 'package:flutter/material.dart';
import 'package:culture_trip/widgets/formInput.dart';
import 'package:culture_trip/widgets/navAkun.dart';
import 'package:culture_trip/widgets/signButton.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

// ignore: must_be_immutable
class RegisScreen extends StatelessWidget {
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController alamat = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      FormInput(
                        myController: nama,
                        labelAwal: 'Nama',
                        labelAkhir: 'Masukan Nama',
                        typeInput: false,
                        logicValidation: (value) {
                          if (value.isEmpty) {
                            return 'Nama harus diisi';
                          }
                        },
                      ),
                      FormInput(
                        myController: alamat,
                        labelAwal: 'Alamat',
                        labelAkhir: 'Masukan Alamat',
                        typeInput: false,
                        logicValidation: (value) {
                          if (value.isEmpty) {
                            return 'Alamat harus diisi';
                          }
                        },
                      ),
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
                          } else if (value.length < 8) {
                            return 'Panjang password harus 8';
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            signButton(
                              textButton: 'Sign Up',
                              functionButton: () async {
                                ProgressDialog pd = ProgressDialog(context: context);
                                pd.show(
                                  msg: 'Tunggu Sebentar...',
                                  progressBgColor: Theme.of(context).primaryColor,
                                );
                                if (formKey.currentState!.validate()) {
                                  final Akun = new Users(
                                    nama: nama.text,
                                    email: email.text,
                                    alamat: alamat.text,
                                    password: password.text,
                                  );

                                  var value = await Akun.addUser();

                                  if (value == true) {
                                    pd.close();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            title: Text(
                                              'Selamat',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Text(
                                              'Akun Berhasil Terdaftar',
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
                                                    Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/login'));
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
                                  } else {
                                    pd.close();
                                    final snackBar = SnackBar(
                                      content: Text(
                                        'Email / Akun sudah ada ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                }
                              },
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
                      ),
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
