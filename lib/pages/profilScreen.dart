import 'dart:ui';

import 'package:culture_trip/widgets/berandaContainer.dart';
import 'package:culture_trip/widgets/fiturButton.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/mapProfile.dart';
import 'package:culture_trip/widgets/textProfile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(fit: StackFit.expand, children: [
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
                        image: AssetImage(
                          'lib/assets/images/beranda.png',
                        ),
                      )),
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
                                  image: AssetImage(
                                    'lib/assets/images/wisata1.png',
                                  ),
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
                                  onPressed: () {},
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
                                        onPressed: () {},
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
                                  subTextContent: 'Muhammad Aliffandy\nanjay',
                                ),
                                TextProfile(
                                  textContent: 'Nama',
                                  subTextContent: 'Muhammad Aliffandy\nanjay',
                                ),
                                TextProfile(
                                  textContent: 'Nama',
                                  subTextContent: 'Muhammad Aliffandy\nanjay',
                                ),
                                TextProfile(
                                  textContent: 'Nama',
                                  subTextContent: 'Muhammad Aliffandy\nanjay',
                                ),
                                MapProfile(
                                  textContent: 'Nama',
                                  subTextContent: 'Muhammad Aliffandy',
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
      ]),
    );
  }
}
