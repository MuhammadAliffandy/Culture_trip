import 'package:culture_trip/models/pesanan.dart';
import 'package:culture_trip/widgets/listPesanan.dart';
import 'package:flutter/material.dart';

class ReadPesananScreen extends StatefulWidget {
  @override
  State<ReadPesananScreen> createState() => _ReadPesananScreenState();
}

class _ReadPesananScreenState extends State<ReadPesananScreen> {
  @override
  Widget build(BuildContext context) {
    final AllPesanan = new Pesanan();
    final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    var _judul = arguments?['judul'];
    var _gambar = arguments?['gambar'];
    var _tanggal = arguments?['tanggal'];
    var _idPaket = arguments?['idListPaket'];
    var _toPaket = arguments?['listPaket'];

    Future<Map<String, dynamic>> readDataPesanan() async {
      Map<String, dynamic>? data = await AllPesanan.readPesananList(_toPaket, _idPaket);
      return data;
    }

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, '/pesanan');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              )),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(
            'Pesanan',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, '/pesanan');
                  },
                  child: Text(
                    'Batal',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(112, 46),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/bayar', ModalRoute.withName('/pesanan'));
                  },
                  child: Text(
                    'Bayar',
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
        body: FutureBuilder<Map<String, dynamic>>(
            future: readDataPesanan(),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return Text('Failed to load data from firebase');
                } else {
                  Map<String, dynamic> pesanan = snapshot.data!;

                  return ListPesanan(
                    paket: _judul,
                    gambar: _gambar,
                    harga: pesanan['harga'],
                    tanggal: _tanggal,
                    listDestinasi: [
                      Text('${pesanan['Destinasi'][1]}'),
                      Text('${pesanan['Destinasi'][2]}'),
                    ],
                    listBajuAdat: [
                      Text('${pesanan['BajuAdat']}'),
                    ],
                    listPenginapan: [
                      Text('Hotel: ${pesanan['Penginapan']['tempat']}'),
                      Text('CheckIn: ${pesanan['Penginapan']['checkIn']}'),
                      Text('CheckOut: ${pesanan['Penginapan']['checkOut']}'),
                    ],
                  );
                }
              }
            }));
  }
}
