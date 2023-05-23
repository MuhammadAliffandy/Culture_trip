import 'dart:async';
import 'dart:convert';

import 'package:culture_trip/models/db.dart';

class PaketWisata {
  Future<List<dynamic>> readPaket() async {
    // untuk melihat data paket

    final completer = Completer<List<dynamic>>();
    await FirebaseHelper.ref.child('Paket').onValue.listen((event) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
      List<dynamic> paket = data.values.toList();

      completer.complete(paket);
    });
    return completer.future;
  }

  upFavorite(id, data) async {
    await FirebaseHelper.ref.child('Paket/${id}').update({
      "favorite": data,
    });
  }

  filterFavorite() {
    final completer = Completer<List<dynamic>>();
    FirebaseHelper.ref.child('Paket').orderByChild('favorite').equalTo(true).once().then((event) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
      List<dynamic> paket = data.values.toList();

      completer.complete(paket);
    });
    return completer.future;
  }
}
