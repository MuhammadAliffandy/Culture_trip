import 'package:culture_trip/models/budaya.dart';
import 'package:culture_trip/widgets/contentContainer2.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/customSearch.dart';
import 'package:flutter/material.dart';

class BudayaScreen extends StatefulWidget {
  @override
  State<BudayaScreen> createState() => _BudayaScreenState();
}

class _BudayaScreenState extends State<BudayaScreen> {
  final AllBudaya = new Budaya();
  List<dynamic>? allBudaya;

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

  loadBudaya() {
    AllBudaya.readBudaya().then((data) {
      setState(() {
        allBudaya = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadBudaya();
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
          'Budaya',
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
                          'Budaya',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: allBudaya != null
                            ? allBudaya!.map((data) {
                                final Map<String, dynamic> arguments = {
                                  'toRoute': '/budaya',
                                  'title': 'Budaya',
                                  'judul': data['judul'],
                                  'artikel': data['artikel'],
                                  'gambar': data['gambar']
                                };

                                return FutureBuilder<bool>(
                                    future: searchText(data['judul']),
                                    builder: (BuildContext context, AsyncSnapshot textSnapshot) {
                                      if (textSnapshot.data == true) {
                                        return ContentContainer2(
                                          textContent: data['judul'],
                                          photoContent: data['gambar'],
                                          functionButton: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/readItem',
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
