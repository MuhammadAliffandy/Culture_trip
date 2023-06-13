import 'dart:async';
import 'dart:convert';

import 'package:culture_trip/models/db.dart';

class Pesanan {
  addPesanan(nama, tanggal, paket, listPaket, idListPaket, gambar) async {
    await FirebaseHelper.ref.child('pesanan').push().set({
      "key": FirebaseHelper.ref.child('pesanan').push().key,
      "nama": nama,
      "tanggal": tanggal,
      'gambar': gambar,
      "paket": paket,
      "listPaket": listPaket,
      "idListPaket": idListPaket
    });
  }

  // untuk mengambil data pesanan
  Future<List<dynamic>> getPesanan(user) async {
    final completer = Completer<List<dynamic>>();
    FirebaseHelper.ref.child('pesanan').orderByChild('nama').equalTo(user).once().then((event) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
      List<dynamic> pesanan = data.values.toList();
      completer.complete(pesanan);
    });
    return completer.future;
  }

  Future<Map<String, dynamic>> readPesananList(listPaket, idPaket) async {
    // untuk melihat data paket per key

    var paket = await FirebaseHelper.ref.child('listPaket/${listPaket}/${idPaket}').once();
    final String jsonString = jsonEncode(paket.snapshot.value);
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return jsonData;
  }

  delPesanan(key) async {
    await FirebaseHelper.ref.child('pesanan').orderByChild('key').equalTo(key).once().then((event) {
      var value = jsonDecode(jsonEncode(event.snapshot.value));
      final Map<String, dynamic> toMapDynamic = Map<String, dynamic>.from(value);
      final String jsonString = jsonEncode(toMapDynamic);
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      var data = jsonData.keys.first.toString();

      FirebaseHelper.ref.child('pesanan').child('$data').remove();
    });
  }
}
