import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:culture_trip/models/user.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/inputEdit.dart';
import 'package:culture_trip/widgets/mapProfile.dart';
import 'package:culture_trip/widgets/signButton.dart';
import 'package:culture_trip/widgets/textProfile.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Akun = new Users();
  final ImagePicker picker = ImagePicker();
  TextEditingController cNama = TextEditingController();
  TextEditingController cBio = TextEditingController();
  TextEditingController cTanggal = TextEditingController();
// varibel data photos
  dynamic pp = AssetImage('lib/assets/images/defaultpp.jpg');
  File? foto;

// counter icon color
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
// function get profil from db

  Future<Map<String, dynamic>> getProfil() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String? key = session.getString('user');
    Map<String, dynamic>? data = await Akun.readUserId(key);
    return data;
  }

//  method update foto profil
  updateFotoProfil(foto) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String? key = session.getString('user');
    Map<String, dynamic>? data = await Akun.readUserId(key);
    Akun.addFoto(foto, data['nama'], context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, '/beranda');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              )),
          elevation: 0,
          title: Text(
            'Akun',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, '/profil');
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Stack(children: [
                              Positioned(
                                top: 0,
                                right: 0,
                                child: AlertDialog(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 100,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/login'));
                                            SharedPreferences session = await SharedPreferences.getInstance();
                                            session.setString('user', '');
                                            session.setString('uid', '');
                                          },
                                          child: Text(
                                            'Sign Out',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        );
                      });
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: FutureBuilder<Map<String, dynamic>>(
            future: getProfil(),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return Center(child: Text('No data'));
              }

              Map<String, dynamic> data = snapshot.data!;
              dynamic nama = data['nama'];
              dynamic email = data['email'];
              dynamic alamat = data['alamat'];
              dynamic bio = data['bio'];
              dynamic ttl = data['ttl'];

              if (data['foto'] != 'belum diisi') {
                pp = NetworkImage(data['foto']);
              }

              return Stack(fit: StackFit.expand, children: [
                ListView(children: [
                  Column(
                    children: [
                      Container(
                        height: 900,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('lib/assets/images/beranda.png'),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 400,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 180),
                                child: Center(
                                    child: Container(
                                  width: 150,
                                  height: 150,
                                  child: Stack(children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: pp,
                                        ),
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 4.0,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    actions: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            IconButton(
                                                              icon: Icon(Icons.close),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Center(
                                                        child: TextButton(
                                                          onPressed: () async {
                                                            final ImagePicker picker = ImagePicker();
                                                            ProgressDialog pd = ProgressDialog(context: context);
                                                            XFile? image = await picker.pickImage(source: ImageSource.camera);
                                                            foto = File(image!.path);
                                                            updateFotoProfil(foto);

                                                            Navigator.of(context).pop();

                                                            pd.show(
                                                              msg: 'Mengunggah foto...',
                                                              progressBgColor: Theme.of(context).primaryColor,
                                                            );
                                                          },
                                                          child: Text(
                                                            'Camera',
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              color: Theme.of(context).primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: TextButton(
                                                          onPressed: () async {
                                                            ProgressDialog pd = ProgressDialog(context: context);
                                                            final ImagePicker picker = ImagePicker();
                                                            XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                                            foto = File(image!.path);
                                                            updateFotoProfil(foto);

                                                            Navigator.of(context).pop();

                                                            pd.show(
                                                              msg: 'Mengunggah foto...',
                                                              progressBgColor: Theme.of(context).primaryColor,
                                                            );
                                                          },
                                                          child: Text(
                                                            'Gallery',
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              color: Theme.of(context).primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.camera_alt,
                                            size: 25,
                                            color: Color.fromARGB(255, 236, 233, 233),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                )),
                              ),
                            ),
                            Positioned(
                              top: 220,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  width: 400,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 66, 66, 66),
                                        spreadRadius: -7,
                                        blurRadius: 7,
                                        offset: Offset(7, 7),
                                      )
                                    ],
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Profil',
                                                style: Theme.of(context).textTheme.headlineMedium,
                                              ),
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
                                                                height: 430,
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
                                                                                cNama.clear();
                                                                                cBio.clear();
                                                                                cTanggal.clear();
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
                                                                      height: 350,
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              EditInput(
                                                                                myController: cNama,
                                                                                labelAwal: 'Nama',
                                                                                labelAkhir: nama,
                                                                              ),
                                                                              EditInput(
                                                                                myController: cBio,
                                                                                labelAwal: 'Bio',
                                                                                labelAkhir: bio,
                                                                              ),
                                                                              EditInput(
                                                                                myController: cTanggal,
                                                                                labelAwal: 'TTL',
                                                                                labelAkhir: ttl,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          signButton(
                                                                            textButton: 'Perbarui',
                                                                            functionButton: () async {
                                                                              final Akun = new Users();
                                                                              SharedPreferences session = await SharedPreferences.getInstance();
                                                                              String? key = session.getString('user');
                                                                              Akun.upUser(key, cNama.text, cBio.text, cTanggal.text);
                                                                              Navigator.pushReplacementNamed(context, '/profil');
                                                                              cNama.clear();
                                                                              cBio.clear();
                                                                              cTanggal.clear();
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
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'edit',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.edit,
                                                      color: Theme.of(context).primaryColor,
                                                      size: 15,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextProfile(
                                          textContent: 'Nama',
                                          subTextContent: nama,
                                        ),
                                        TextProfile(
                                          textContent: 'Email',
                                          subTextContent: email,
                                        ),
                                        MapProfile(
                                          textContent: 'Alamat',
                                          subTextContent: alamat,
                                        ),
                                        TextProfile(
                                          textContent: 'Bio',
                                          subTextContent: bio,
                                        ),
                                        TextProfile(
                                          textContent: 'TTL',
                                          subTextContent: ttl,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 120,
                      )
                    ],
                  ),
                ]),
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 10,
                  right: 0,
                  child: CustomNavButton(
                    selectedIndex: _selectedIndex,
                    onItemTapped: _onItemTapped,
                  ),
                ),
              ]);
            }));
  }
}
