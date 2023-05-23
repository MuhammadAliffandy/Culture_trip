import 'dart:async';
import 'dart:convert';

import 'package:culture_trip/models/db.dart';

class Informasi {
  // untuk melihat data
  Future<List<dynamic>> readInformasi() async {
    final completer = Completer<List<dynamic>>();
    await FirebaseHelper.ref.child('informasi').onValue.listen((event) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
      List<dynamic> informasi = data.values.toList();

      completer.complete(informasi);
    });
    return completer.future;
  }
}
