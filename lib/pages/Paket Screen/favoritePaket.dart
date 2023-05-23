import 'package:culture_trip/models/paketWisata.dart';
import 'package:culture_trip/widgets/berandaContainer.dart';
import 'package:culture_trip/widgets/contentContainer.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/customSearch.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final Paket = new PaketWisata();
  List<dynamic>? allPaket;

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  loadPaket() {
    Paket.filterFavorite().then((data) {
      setState(() {
        allPaket = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
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
          'Favorit',
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
                        'Paket',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: allPaket != null
                            ? allPaket!.map((paket) {
                                return ContentContainer(
                                  textContent: paket['judul'],
                                  subTextContent: paket['deskripsi'],
                                  photoContent: paket['gambar'],
                                  idPaket: paket['judul'],
                                  isFavorited: paket['favorite'],
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
