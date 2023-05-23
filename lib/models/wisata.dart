import 'dart:async';
import 'dart:convert';

import 'package:culture_trip/models/db.dart';

class Wisata {
  // untuk melihat data
  Future<List<dynamic>> readWisata() async {
    final completer = Completer<List<dynamic>>();
    await FirebaseHelper.ref.child('wisata').onValue.listen((event) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));
      List<dynamic> wisata = data.values.toList();

      completer.complete(wisata);
    });
    return completer.future;
  }
}
