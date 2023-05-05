import 'package:culture_trip/widgets/berandaContainer.dart';
import 'package:culture_trip/widgets/cardBoard.dart';
import 'package:culture_trip/widgets/contentContainer3.dart';
import 'package:culture_trip/widgets/fiturButton.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:flutter/material.dart';

class BerandaScreen extends StatefulWidget {
  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  int _selectedIndex = 0;

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
                      height: 320,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'lib/assets/images/beranda.png',
                        ),
                      )),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Selamat Datang User',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      shadows: [
                                        Shadow(
                                          color: Color.fromARGB(255, 89, 89, 89),
                                          blurRadius: 2,
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 300,
                                    child: Text(
                                      'Rasakan sensasi budaya yang melekat dengan keindahan alam.',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        shadows: [
                                          Shadow(
                                            color: Color.fromARGB(255, 89, 89, 89),
                                            blurRadius: 2,
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FiturButton(
                                icon: Icons.card_travel,
                                textFitur: 'Paket',
                                warnaIcon: Colors.blue,
                                functionButton: () {
                                  Navigator.pushNamed(context, '/paket');
                                },
                              ),
                              FiturButton(
                                icon: Icons.terrain,
                                textFitur: 'Wisata',
                                warnaIcon: Colors.green,
                                functionButton: () {
                                  Navigator.pushNamed(context, '/wisata');
                                },
                              ),
                              FiturButton(
                                icon: Icons.cruelty_free_rounded,
                                textFitur: 'Budaya',
                                warnaIcon: Colors.orange,
                                functionButton: () {
                                  Navigator.pushNamed(context, '/budaya');
                                },
                              ),
                              FiturButton(
                                icon: Icons.newspaper,
                                textFitur: 'Informasi',
                                warnaIcon: Colors.red,
                                functionButton: () {
                                  Navigator.pushNamed(context, '/informasi');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Pencapaian',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    CardBoard(
                      textContent: 'Robert',
                      textTier: 'Pemula',
                      numberTrip: '0',
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
                        'Informasi',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ContentContainer3(
                              textContent: '15 Hal terbaik di jogja',
                              subTextContent: 'Budaya kedaerahan yang melekat dan indah lekuknya bangunan dengan ciri khas asdsad sddsa jawanyadasdasddd',
                              photoContent: 'lib/assets/images/wisata1.png',
                            ),
                            ContentContainer3(
                              textContent: '15 Hal terbaik di jogja',
                              subTextContent: 'Budaya kedaerahan yang melekat dan indah lekuknya bangunan dengan ciri khas asdsad sddsa jawanyadasdasddd',
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
