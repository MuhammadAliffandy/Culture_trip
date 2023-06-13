import 'dart:convert';

import 'package:culture_trip/models/budaya.dart';
import 'package:culture_trip/models/paketWisata.dart';
import 'package:culture_trip/models/user.dart';
import 'package:culture_trip/models/weather.dart';
import 'package:culture_trip/widgets/berandaContainer.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripScreen extends StatefulWidget {
  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  dynamic lokasi = 'load';
  dynamic suhu = 'load';
  dynamic status = 'load';
  dynamic icon = '//w7.pngwing.com/pngs/164/641/png-transparent-logo-business-please-wait-angle-text-hand.png';
  final Akun = Users();
  final Paket = new PaketWisata();
  List<dynamic>? allPaket;
  final AllBudaya = new Budaya();
  List<dynamic>? allBudaya;
  final API = new WeatherAPI();

  loadAPI() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String? key = session.getString('user');
    Map<String, dynamic>? data = await Akun.readUserId(key);

    API.fetchData(data['lokasi']['latitude'], data['lokasi']['longitude']).then((response) {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          lokasi = '${data['location']['name']}\n${data['location']['region']}';
          suhu = data['current']['temp_c'];
          status = data['current']['condition']['text'];
          icon = data['current']['condition']['icon'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    }).catchError((error) {
      print(error);
    });
  }

  loadPaket() {
    Paket.readPaket().then((data) {
      setState(() {
        allPaket = data;
      });
    });
  }

  loadBudaya() {
    AllBudaya.readBudaya().then((data) {
      setState(() {
        allBudaya = data;
      });
    });
  }

  int _selectedIndex = 5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPaket();
    loadBudaya();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  child: Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: SliderImage(),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(102, 236, 236, 236),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 60,
                          child: FutureBuilder<dynamic>(
                              future: loadAPI(),
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState == ConnectionState.none) {
                                  return CircularProgressIndicator();
                                } else {
                                  if (snapshot.hasError) {
                                    return Text('Failed to load data from API');
                                  } else {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          lokasi,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${suhu}`C',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              child: Text(
                                                status,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Image(
                                              image: NetworkImage('https:${icon}'),
                                              width: 40,
                                              height: 40,
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  }
                                }
                              }),
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Paket Wisata',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: allPaket != null
                              ? allPaket!.map((paket) {
                                  final Map<String, dynamic> arguments = {
                                    'judul': paket['judul'],
                                    'idPaket': paket['idPaket'],
                                    'gambar': paket['gambar']
                                  };
                                  return BerandaContainer(
                                    textContent: 'Culture Trip \n${paket['judul']}',
                                    photoContent: paket['gambar'],
                                    functionButton: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/readPaket',
                                        arguments: arguments,
                                      );
                                    },
                                  );
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
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Inspirasi Budaya',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: allBudaya != null
                              ? allBudaya!.map((data) {
                                  final Map<String, dynamic> arguments = {
                                    'toRoute': '/budaya',
                                    'title': 'Budaya',
                                    'judul': data['judul'],
                                    'artikel': data['artikel'],
                                    'gambar': data['gambar']
                                  };

                                  return BerandaContainer(
                                    textContent: data['judul'],
                                    photoContent: data['gambar'],
                                    functionButton: () {
                                      Navigator.pushNamed(context, '/readItem', arguments: arguments);
                                    },
                                  );
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
                    )
                  ],
                ),
                SizedBox(
                  height: 120,
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
