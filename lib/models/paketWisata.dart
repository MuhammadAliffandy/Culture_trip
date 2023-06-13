import 'dart:async';
import 'dart:convert';
import 'package:culture_trip/models/db.dart';

class PaketWisata {
  // untuk melihat data paket
  Future<List<dynamic>> readPaket() async {
    final completer = Completer<List<dynamic>>();
    await FirebaseHelper.ref.child('Paket').onValue.listen((event) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
      List<dynamic> paket = data.values.toList();

      completer.complete(paket);
    });
    return completer.future;
  }

  Future<List<dynamic>> readPaketId(id) async {
    // untuk melihat data paket

    var event = await FirebaseHelper.ref.child('Paket/${id}').once();
    Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
    List<dynamic> paket = data.values.toList();
    return paket;
  }

  // consume list paket

  Future<Map<String, dynamic>> readPaketList1(id) async {
    // untuk melihat data paket per key

    var paket = await FirebaseHelper.ref.child('listPaket/paket1/${id}').once();
    final String jsonString = jsonEncode(paket.snapshot.value);
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return jsonData;
  }

  Future<Map<String, dynamic>> readPaketList2(id) async {
    // untuk melihat data paket per key

    var paket = await FirebaseHelper.ref.child('listPaket/paket2/${id}').once();
    final String jsonString = jsonEncode(paket.snapshot.value);
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return jsonData;
  }

  Future<Map<String, dynamic>> readPaketList3(id) async {
    // untuk melihat data paket per key
    var paket = await FirebaseHelper.ref.child('listPaket/paket3/${id}').once();
    final String jsonString = jsonEncode(paket.snapshot.value);
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return jsonData;
  }
}
