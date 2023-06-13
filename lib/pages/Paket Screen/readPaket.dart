import 'package:culture_trip/models/paketWisata.dart';
import 'package:culture_trip/models/pesanan.dart';
import 'package:culture_trip/widgets/listTab.dart';
import 'package:culture_trip/widgets/miniMap.dart';
import 'package:culture_trip/widgets/modalpopup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadPaketScreen extends StatefulWidget {
  @override
  State<ReadPaketScreen> createState() => _ReadPaketScreenState();
}

class _ReadPaketScreenState extends State<ReadPaketScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    var _judul = arguments?['judul'];
    var _idPaket = arguments?['idPaket'];
    var _gambar = arguments?['gambar'];
    DateTime now = DateTime.now();
    String tanggal = DateFormat('dd MMMM yyyy').format(now);

    final ListPaket = new PaketWisata();
    final Pesan = new Pesanan();
    final List<Widget> MyTab = [
      Tab(
        text: 'Paket 1',
      ),
      Tab(
        text: 'Paket 2',
      ),
      Tab(
        text: 'Paket 3',
      ),
    ];

    // function load paket 1, 2 ,3

    Future<Map<String, dynamic>> loadPaket1() async {
      Map<String, dynamic>? data = await ListPaket.readPaketList1(_idPaket);
      return data;
    }

    Future<Map<String, dynamic>> loadPaket2() async {
      Map<String, dynamic>? data = await ListPaket.readPaketList2(_idPaket);
      return data;
    }

    Future<Map<String, dynamic>> loadPaket3() async {
      Map<String, dynamic>? data = await ListPaket.readPaketList3(_idPaket);
      return data;
    }

    getProfil() async {
      SharedPreferences session = await SharedPreferences.getInstance();
      String? key = session.getString('user');
      return key;
    }

    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, '/readPaket');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              )),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(
            'Paket',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Color.fromARGB(255, 255, 255, 255),
            tabs: MyTab,
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: TabBarView(children: [
          FutureBuilder<Map<String, dynamic>>(
              future: loadPaket1(),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Text('Failed to load data from firebase');
                  } else {
                    Map<String, dynamic> paket1 = snapshot.data!;
                    dynamic currentLng = paket1['lokasi']['longitude'];
                    dynamic currentLat = paket1['lokasi']['latitude'];

                    double longitude = currentLng.toDouble();
                    double latitude = currentLat.toDouble();
                    return Stack(
                      children: [
                        ListTab(
                          judul: _judul,
                          gambar: _gambar,
                          listDestinasi: [
                            Text('${paket1['Destinasi'][1]}'),
                            Text('${paket1['Destinasi'][2]}'),
                          ],
                          listBajuAdat: [
                            Text('${paket1['BajuAdat']}'),
                          ],
                          listPenginapan: [
                            Text('Hotel: ${paket1['Penginapan']['tempat']}'),
                            Text('CheckIn: ${paket1['Penginapan']['checkIn']}'),
                            Text('CheckOut: ${paket1['Penginapan']['checkOut']}'),
                          ],
                          miniMap: MiniMap(
                            longitude: longitude,
                            latitude: latitude,
                          ),
                          functionMapButton: () {
                            final Map<String, dynamic> arguments = {
                              'longitude': longitude,
                              'latitude': latitude,
                            };
                            Navigator.pushNamed(
                              context,
                              '/showMap',
                              arguments: arguments,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tanggal,
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      getProfil().then((value) {
                                        Pesan.addPesanan(value, tanggal, _judul, 'paket1', _idPaket, _gambar);
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ModalPopUp(context);
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Pesan',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                      minimumSize: MaterialStateProperty.all(
                                        Size(112, 46),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }
              }),
          FutureBuilder<Map<String, dynamic>>(
              future: loadPaket2(),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Text('Failed to load data from firebase');
                  } else {
                    Map<String, dynamic> paket1 = snapshot.data!;
                    dynamic currentLng = paket1['lokasi']['longitude'];
                    dynamic currentLat = paket1['lokasi']['latitude'];

                    double longitude = currentLng.toDouble();
                    double latitude = currentLat.toDouble();
                    return Stack(
                      children: [
                        ListTab(
                          judul: _judul,
                          gambar: _gambar,
                          listDestinasi: [
                            Text('${paket1['Destinasi'][2]}'),
                            Text('${paket1['Destinasi'][3]}'),
                            Text('${paket1['Destinasi'][4]}'),
                          ],
                          listBajuAdat: [
                            Text('${paket1['BajuAdat']}'),
                          ],
                          listPenginapan: [
                            Text('Hotel: ${paket1['Penginapan']['tempat']}'),
                            Text('CheckIn: ${paket1['Penginapan']['checkIn']}'),
                            Text('CheckOut: ${paket1['Penginapan']['checkOut']}'),
                          ],
                          miniMap: MiniMap(
                            longitude: longitude,
                            latitude: latitude,
                          ),
                          functionMapButton: () {
                            final Map<String, dynamic> arguments = {
                              'longitude': longitude,
                              'latitude': latitude,
                            };
                            Navigator.pushNamed(
                              context,
                              '/showMap',
                              arguments: arguments,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tanggal,
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      getProfil().then((value) {
                                        Pesan.addPesanan(value, tanggal, _judul, 'paket2', _idPaket, _gambar);
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ModalPopUp(context);
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Pesan',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                      minimumSize: MaterialStateProperty.all(
                                        Size(112, 46),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }
              }),
          FutureBuilder<Map<String, dynamic>>(
              future: loadPaket3(),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Text('Failed to load data from firebase');
                  } else {
                    Map<String, dynamic> paket1 = snapshot.data!;
                    dynamic currentLng = paket1['lokasi']['longitude'];
                    dynamic currentLat = paket1['lokasi']['latitude'];

                    double longitude = currentLng.toDouble();
                    double latitude = currentLat.toDouble();
                    return Stack(
                      children: [
                        ListTab(
                          judul: _judul,
                          gambar: _gambar,
                          listDestinasi: [
                            Text('${paket1['Destinasi'][3]}'),
                            Text('${paket1['Destinasi'][4]}'),
                            Text('${paket1['Destinasi'][5]}'),
                            Text('${paket1['Destinasi'][6]}'),
                          ],
                          listBajuAdat: [
                            Text('${paket1['BajuAdat']}'),
                          ],
                          listPenginapan: [
                            Text('Hotel: ${paket1['Penginapan']['tempat']}'),
                            Text('CheckIn: ${paket1['Penginapan']['checkIn']}'),
                            Text('CheckOut: ${paket1['Penginapan']['checkOut']}'),
                          ],
                          miniMap: MiniMap(
                            longitude: longitude,
                            latitude: latitude,
                          ),
                          functionMapButton: () {
                            final Map<String, dynamic> arguments = {
                              'longitude': longitude,
                              'latitude': latitude,
                            };
                            Navigator.pushNamed(
                              context,
                              '/showMap',
                              arguments: arguments,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tanggal,
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      getProfil().then((value) {
                                        Pesan.addPesanan(value, tanggal, _judul, 'paket3', _idPaket, _gambar);
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ModalPopUp(context);
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Pesan',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                      minimumSize: MaterialStateProperty.all(
                                        Size(112, 46),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }
              }),
        ]),
      ),
    );
  }
}
