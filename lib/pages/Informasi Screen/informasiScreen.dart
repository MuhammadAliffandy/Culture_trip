import 'package:culture_trip/widgets/contentContainer3.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/customSearch.dart';
import 'package:flutter/material.dart';

class InformasiScreen extends StatefulWidget {
  @override
  State<InformasiScreen> createState() => _InformasiScreenState();
}

class _InformasiScreenState extends State<InformasiScreen> {
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
          'Informasi',
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
                CustomSearch(),
                SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Info Wisata',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
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
                          ContentContainer3(
                            textContent: '15 Hal terbaik di jogja',
                            subTextContent: 'Budaya kedaerahan yang melekat dan indah lekuknya bangunan dengan ciri khas asdsad sddsa jawanyadasdasddd',
                            photoContent: 'lib/assets/images/wisata1.png',
                          ),
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
