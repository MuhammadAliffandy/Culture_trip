import 'package:culture_trip/widgets/berandaContainer.dart';
import 'package:culture_trip/widgets/cardBoard.dart';

import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/slider.dart';
import 'package:flutter/material.dart';

class TripScreen extends StatefulWidget {
  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  int _selectedIndex = 5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Jakarta,\nIndonesia',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '20`C',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Cerah',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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
                          children: [
                            BerandaContainer(
                              textContent: 'Culture Trip\nYogyakarta',
                              photoContent: 'lib/assets/images/wisata1.png',
                            ),
                            BerandaContainer(
                              textContent: 'Culture Trip\nYogyakarta',
                              photoContent: 'lib/assets/images/wisata1.png',
                            ),
                            BerandaContainer(
                              textContent: 'Culture Trip\nYogyakarta',
                              photoContent: 'lib/assets/images/wisata1.png',
                            ),
                            BerandaContainer(
                              textContent: 'Culture Trip\nYogyakarta',
                              photoContent: 'lib/assets/images/wisata1.png',
                            ),
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
                          children: [
                            BerandaContainer(
                              textContent: 'Culture Trip\nYogyakarta',
                              photoContent: 'lib/assets/images/wisata1.png',
                            ),
                            BerandaContainer(
                              textContent: 'Culture Trip\nYogyakarta',
                              photoContent: 'lib/assets/images/wisata1.png',
                            ),
                            BerandaContainer(
                              textContent: 'Culture Trip\nYogyakarta',
                              photoContent: 'lib/assets/images/wisata1.png',
                            ),
                            BerandaContainer(
                              textContent: 'Culture Trip\nYogyakarta',
                              photoContent: 'lib/assets/images/wisata1.png',
                            ),
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
