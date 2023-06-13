import 'package:culture_trip/models/informasi.dart';
import 'package:culture_trip/widgets/contentContainer3.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/customSearch.dart';
import 'package:flutter/material.dart';

class InformasiScreen extends StatefulWidget {
  @override
  State<InformasiScreen> createState() => _InformasiScreenState();
}

class _InformasiScreenState extends State<InformasiScreen> {
  final AllInformasi = new Informasi();
  List<dynamic>? allInformasi;

  String textInput = '';
  Future<bool> searchText(currentText) async {
    int cek = await currentText.toLowerCase().indexOf(textInput.toLowerCase());
    if (cek < 0) {
      return false;
    } else {
      return true;
    }
  }

  int _selectedIndex = 5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  loadInformasi() {
    AllInformasi.readInformasi().then((data) {
      setState(() {
        allInformasi = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadInformasi();
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
                          'Informasi',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: allInformasi != null
                            ? allInformasi!.map((data) {
                                final Map<String, dynamic> arguments = {
                                  'toRoute': '/informasi',
                                  'title': 'Informasi',
                                  'judul': data['judul'],
                                  'artikel': data['artikel'],
                                  'gambar': data['gambar']
                                };

                                return FutureBuilder<bool>(
                                    future: searchText(data['judul']),
                                    builder: (BuildContext context, AsyncSnapshot textSnapshot) {
                                      if (textSnapshot.data == true) {
                                        return ContentContainer3(
                                          textContent: data['judul'],
                                          subTextContent: data['artikel'],
                                          photoContent: data['gambar'],
                                          functionButton: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/readInfo',
                                              arguments: arguments,
                                            );
                                          },
                                        );
                                      } else {
                                        return SizedBox.shrink();
                                      }
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
