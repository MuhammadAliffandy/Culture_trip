import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
  static final DatabaseReference ref = FirebaseDatabase.instance.ref();
}

class FbStorage {
  static final storage = FirebaseStorage.instance.ref();
}
