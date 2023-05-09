import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper {
  static final DatabaseReference ref = FirebaseDatabase.instance.ref();
}
