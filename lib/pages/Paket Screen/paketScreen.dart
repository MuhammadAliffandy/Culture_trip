import 'dart:async';

import 'package:culture_trip/models/paketWisata.dart';
import 'package:culture_trip/models/user.dart';
import 'package:culture_trip/widgets/contentContainer.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/customSearch.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaketScreen extends StatefulWidget {
  @override
  State<PaketScreen> createState() => _PaketScreenState();
}

class _PaketScreenState extends State<PaketScreen> {
  final Paket = new PaketWisata();
  final Akun = new Users();
  List<dynamic>? allPaket;
  String? User;
  String textInput = '';

  int _selectedIndex = 5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  loadUser() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    setState(() {
      User = session.getString('user');
    });
  }

  loadPaket() {
    Paket.readPaket().then((data) {
      setState(() {
        allPaket = data;
      });
    });
  }

  Future<bool> searchText(currentText) async {
    int cek = await currentText.toLowerCase().indexOf(textInput.toLowerCase());
    if (cek < 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    loadPaket();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, '/beranda');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
              size: 30,
            )),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Paket',
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(fit: StackFit.expand, children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomSearch(
                  functionField: (value) {
                    setState(() {
                      textInput = value;
                    });
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: 365,
                        child: Text(
                          'Paket',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: allPaket != null
                            ? allPaket!.map((paket) {
                                final Map<String, dynamic> arguments = {
                                  'judul': paket['judul'],
                                  'idPaket': paket['idPaket'],
                                  'gambar': paket['gambar']
                                };

                                return FutureBuilder<bool>(
                                    future: Akun.getFavorit(User, paket['judul']),
                                    builder: (BuildContext context, AsyncSnapshot<bool> favSnapshot) {
                                      bool cekFavorit = favSnapshot.data ?? false; // Mengambil nilai dari snapshot.data dan mengatur defaultnya ke false jika snapshot.data null
                                      return FutureBuilder<bool>(
                                        future: searchText(paket['judul']),
                                        builder: (BuildContext context, AsyncSnapshot<bool> textSnapshot) {
                                          if (textSnapshot.data == true) {
                                            return ContentContainer(
                                              textContent: paket['judul'],
                                              subTextContent: paket['deskripsi'],
                                              photoContent: paket['gambar'],
                                              idPaket: paket['judul'],
                                              isFavorited: cekFavorit,
                                              user: User,
                                              functionButton: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/readPaket',
                                                  arguments: arguments,
                                                );
                                              },
                                            );
                                          } else {
                                            return SizedBox.shrink();
                                          }
                                        },
                                      );
                                    });
                              }).toList()
                            : [
                                Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Theme.of(context).primaryColor,
                                  ), // Tampilkan animasi loading
                                )
                              ],
                      ),
                    ),
                    SizedBox(
                      height: 120,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
      ]),
    );
  }
}
