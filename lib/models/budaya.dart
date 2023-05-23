import 'dart:async';
import 'dart:convert';

import 'package:culture_trip/models/db.dart';

class Budaya {
  // untuk melihat data
  Future<List<dynamic>> readBudaya() async {
    final completer = Completer<List<dynamic>>();
    await FirebaseHelper.ref.child('budaya').onValue.listen((event) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
      List<dynamic> paket = data.values.toList();

      completer.complete(paket);
    });
    return completer.future;
  }
}
