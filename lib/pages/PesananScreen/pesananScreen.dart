import 'package:culture_trip/models/pesanan.dart';
import 'package:culture_trip/widgets/contentContainer4.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/customSearch.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PesananScreen extends StatefulWidget {
  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  final AllPesan = new Pesanan();

  List<dynamic>? allPesanan;

  String textInput = '';
  Future<bool> searchText(currentText) async {
    int cek = await currentText.toLowerCase().indexOf(textInput.toLowerCase());
    if (cek < 0) {
      return false;
    } else {
      return true;
    }
  }

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  loadPesanan() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String? user = session.getString('user');
    AllPesan.getPesanan(user).then((value) {
      setState(() {
        allPesanan = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadPesanan();
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
          'Pesanan',
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
                          'Pesanan',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            children: allPesanan != null
                                ? allPesanan!.map((data) {
                                    final Map<String, dynamic> arguments = {
                                      'judul': data['paket'],
                                      'tanggal': data['tanggal'],
                                      'gambar': data['gambar'],
                                      'idListPaket': data['idListPaket'],
                                      'listPaket': data['listPaket']
                                    };
                                    return FutureBuilder<bool>(
                                        future: searchText('Culture Trip ${data['paket']}'),
                                        builder: (BuildContext context, AsyncSnapshot textSnapshot) {
                                          if (textSnapshot.data == true) {
                                            return ContentContainer4(
                                              textContent: 'Culture Trip ${data['paket']}',
                                              subTextContent: data['listPaket'],
                                              tanggal: data['tanggal'],
                                              photoContent: data['gambar'],
                                              functionButton: () {
                                                Navigator.pushNamed(context, '/readPesanan', arguments: arguments);
                                              },
                                              optionButton: () {
                                                AllPesan.delPesanan(data['key']);
                                                Navigator.pushNamedAndRemoveUntil(context, '/pesanan', ModalRoute.withName('/beranda'));
                                              },
                                            );
                                          } else {
                                            return SizedBox.shrink();
                                          }
                                        });
                                  }).toList()
                                : [
                                    Center(child: Text('Anda Belum Melakukan Pemesanan'))
                                  ])),
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
